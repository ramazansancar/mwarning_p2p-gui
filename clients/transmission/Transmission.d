﻿module clients.transmission.Transmission;

/*
* Copyright 2007-2009 Moritz Warning
*
* This file is part of P2P-GUI  and is 
* licensed under GNU General Public License.
*/

import tango.io.Stdout;
import tango.io.FilePath;
import tango.io.device.Array;
static import Tango = tango.io.device.File;
import tango.io.model.IFile;
import tango.io.model.IConduit;
import tango.net.device.Socket;
import tango.text.Util;
import tango.core.Array;
import tango.time.Clock;
static import Base64 = tango.io.encode.Base64;
static import Convert = tango.util.Convert;
static import Integer = tango.text.convert.Integer;

import api.Client;
import api.Host;
import api.Node;
import api.File;
import api.Meta;
import api.User;
import api.Search;
import api.Connection;
import api.Setting;

static import Selector = utils.Selector;
static import Timer = utils.Timer;
static import Utils = utils.Utils;
static import Main = webcore.Main;
import webcore.Dictionary; //for unified settings
import webcore.Logger;

import utils.json.JsonParser;
import utils.json.JsonBuilder;

import clients.transmission.TTorrent;
import clients.transmission.TTracker;
import clients.transmission.TFile;
import clients.transmission.TPeer;


final class Transmission : Client, Files, Nodes, Settings
{
private:
    
    alias JsonBuilder!().JsonValue JsonValue;
    alias JsonBuilder!().JsonString JsonString;
    alias JsonBuilder!().JsonNumber JsonNumber;
    alias JsonBuilder!().JsonNull JsonNull;
    alias JsonBuilder!().JsonBool JsonBool;
    alias JsonBuilder!().JsonArray JsonArray;
    alias JsonBuilder!().JsonObject JsonObject;

    class TSetting : NullSetting
    {
        uint id;
        char[] name;
        char[] value;
        Setting.Type type;
        
        this(uint id, char[] name, Setting.Type type)
        {
            this.id = id;
            this.name = name;
            this.type = type;
        }
        
        uint getId() { return id; }
        Setting.Type getType() { return type; }
        char[] getName() { return name; }
        char[] getValue() { return value; }
        char[] getDescription() { return null; }
        Settings getSettings() { return null; }
    }

    uint id;
    char[] host = "127.0.0.1";
    ushort port = 9091;
    char[] session_id; //value for request header key X-Transmission-Session-Id
    
    bool is_connected;
    
    uint upload_speed;
    uint download_speed;
    ulong downloaded;
    ulong uploaded;

    char[] client_version;

    Time lastChanged;

    void changed()
    {
        lastChanged = Clock.now();
    }
    
    TTorrent[uint] downloads;
    TSetting[uint] settings;
    
    const uint torrent_get_tag = 1;
    const uint session_stats_tag = 2;
    const uint get_settings_tag = 3;
    
    package BtNetwork network;
    static const uint bittorrent_net_id = 1;
    
    static final class BtNetwork : NullNode
    {
        Transmission tc;
        this(Transmission tc)
        {
            this.tc = tc;
        }
        
        uint getId() { return bittorrent_net_id; }
        char[] getName() { return "BitTorrent"; }
        Node_.State getState() { return tc.getState(); }
        ulong getUploaded() { return tc.getUploaded(); }
        ulong getDownloaded() { return tc.getDownloaded(); }
    }

    Array buffer;
    
public:

    this(uint id)
    {
        this.id = id;
        network = new BtNetwork(this);
        buffer = new Array(8 * 1024, 2 * 1024);
        
        struct Rec { uint id; char[] name; Setting.Type type; }
        static Rec[] recs = [
            {Phrase.download_dir__setting, "download-dir", Setting.Type.STRING},
            {0, "encryption", Setting.Type.STRING},
            {Phrase.peer_limit__setting, "peer-limit", Setting.Type.NUMBER},
            {0, "pex-allowed", Setting.Type.BOOL},
            {Phrase.port__setting, "port", Setting.Type.NUMBER}, 
            {Phrase.port_forwarding_enabled__setting, "port-forwarding-enabled", Setting.Type.BOOL},
            {Phrase.speed_limit_down__setting, "speed-limit-down", Setting.Type.NUMBER},
            {0, "speed-limit-down-enabled", Setting.Type.BOOL},
            {Phrase.speed_limit_up__setting, "speed-limit-up", Setting.Type.NUMBER},
            {0, "speed-limit-up-enabled", Setting.Type.BOOL},
            {Phrase.Preview_Directory__setting, "preview_directory", Setting.Type.STRING} //sneak in own setting
        ];
        
        foreach(i, ref rec; recs)
        {
            uint sid = rec.id ? rec.id : (i + Phrase.max);
            settings[sid] = new TSetting(sid, rec.name, rec.type);
        }
    }
    
    uint getId() { return id; }
    
    uint getLastChanged() { return (lastChanged - Time.epoch1970).seconds; }
    char[] getHost() { return host; }
    ushort getPort() { return port; }
    char[] getLocation() { return null; }
    void setHost(char[] host) { this.host = host; }
    void setPort(ushort port) {this.port = port; }
    
    synchronized void connect()
    {
        if(is_connected) return;
        is_connected = true;
        
        Timer.add(&updateSlow, 0.5, 10);
        Timer.add(&updateFast, 1, 2);
        Timer.add(&statsRequest, 1, 2);
        //Timer.add(&getJsonSettings, 2, 6);
        
        changed();
    }
    
    synchronized void disconnect()
    {
        if(!is_connected) return;
        is_connected = false;
        session_id = null;
        
        buffer.clear();
        
        upload_speed = 0;
        download_speed = 0;
        downloads = null;
        downloaded = 0;
        uploaded = 0;
        client_version = null;
        
        foreach(s; settings)
            s.value = null;
        
        //remove all callers related to this instance
        Timer.remove(this); 
        
        changed();
    }
    
    char[] getSoftware() { return "Transmission"; }
    char[] getVersion() { return client_version; }
    char[] getUsername() { return null; }
    char[] getName() { return null; }
    char[] getPassword() { return null; }
    char[] getProtocol() { return "json-rpc"; }
    
    void setUsername(char[] user) {}
    void setPassword(char[] pass) {}
    
    void addLink(char[] link)
    {
        if(link.length < 512)
        {
            Logger.addError(this, "Transmission: Links are not supported.");
        }
        else if(link.length < 200 * 1024)
        {
            addTorrent(link);
        }
        else
        {
            Logger.addError(this, "Transmission: File too big.");
        }
    }
    
    void shutdown() {}
    
    uint getFileCount(File_.Type type, File_.State state)
    {
        return downloads.length;
    }
    
    uint getNodeCount(Node_.Type type, Node_.State state)
    {
        if(type == Node_.Type.NETWORK)
        {
            return 1;
        }
    }
    
    uint getUserCount(/*User.State state*/) { return 0; }
    
    Searches getSearches() { return null; }
    Nodes getNodes() { return this; }
    Files getFiles() { return this; }
    
    Settings getSettings()
    {
        getJsonSettings();
        return this;
    }
    
    Metas getMetas() { return null; }
    Users getUsers() { return null; }
    
    char[] getDescription() { return null; }
    ushort getPing() { return 0; }
    uint getAge() { return 0; }
    Priority getPriority() { return Priority.NONE; }
    
    uint getUploadRate() { return upload_speed; }
    uint getDownloadRate() { return download_speed; }
    ulong getUploaded() { return uploaded; }
    ulong getDownloaded(){ return downloaded; }
    
    
    Node_.Type getType() { return Node_.Type.CORE; }
    Node_.State getState()
    {
        return is_connected ? Node_.State.CONNECTED : Node_.State.DISCONNECTED;
    }

//from Nodes:
    
    Node addNode(Node_.Type type, char[] host, ushort  port, char[] user, char[] password) { return null; }
    void removeNode(Node_.Type type, uint id) {}

    void connect(Node_.Type type, uint id) {}
    void disconnect(Node_.Type type, uint id) {}
    
    Node getNode(Node_.Type type, uint id)
    {
        if(type == Node_.Type.NETWORK && is_connected && id == network.getId)
        {
            return network;
        }
        return null;
    }
    
    Node[] getNodeArray(Node_.Type type, Node_.State state, uint age) 
    {
        if(type == Node_.Type.NETWORK && is_connected)
        {
            return Utils.filter!(Node)([network], state, age);
        }
        else if(type == Node_.Type.CLIENT || type == Node_.Type.SERVER)
        {
            Node[] all = [];
            foreach(download; downloads)
            {
                all ~= download.getNodeArray(type, state, age);
            }
            return all;
        }
        return null;
    }
    
//from Files
    
    File getFile(File_.Type type, uint id)
    {
        if(type == File_.Type.DOWNLOAD)
        {
            auto ptr = (id in downloads);
            if(ptr) return *ptr;
        }
        return null;
    }
    
    File[] getFileArray(File_.Type type, File_.State state, uint age)
    {
        if(type != File_.Type.DOWNLOAD) return null;
        return Utils.filter!(File)(downloads, state, age);
    }

    void previewFile(File_.Type type, uint id) {}

    void removeFiles(File_.Type type, uint[] ids)
    {
        deleteTorrents(ids);
    }
    
    void copyFiles(File_.Type type, uint[] source, uint target) {}
    void moveFiles(File_.Type taddype, uint[] source, uint target) {}
    
    void renameFile(File_.Type type, uint id, char[] new_name)
    {
        Logger.addWarning(this, "Transmission: Renaming not supported.");
    }
        
    //for download resume and search result start
    void startFiles(File_.Type type, uint[] ids)
    {
        startTorrents(ids);
    }
    
    void pauseFiles(File_.Type type, uint[] ids)
    {
        stopTorrents(ids);
    }
    
    void stopFiles(File_.Type type, uint[] ids)
    {
        stopTorrents(ids);
    }
    
    void prioritiseFiles(File_.Type type, uint[] ids, Priority priority)
    {
        if(ids.length == 0)
            return;
            
        //missing files indexes match all
        static const uint[] all;
        
        switch(priority)
        {
            case Priority.VERY_LOW:
            case Priority.LOW:
                torrentSet("priority-low", ids, all);
                break;
            case Priority.NONE:
            case Priority.AUTO:
            case Priority.NORMAL:
                torrentSet("priority-normal", ids, all);
                break;
            case Priority.HIGH:
            case Priority.VERY_HIGH:
                torrentSet("priority-high", ids, all);
                break;
        }
    }

    void setPreviewDirectory(char[] directory)
    {
        if(directory.length == 0)
        {
            if(auto setting = (Phrase.Preview_Directory__setting in settings))
            {
                setting.value = null;
            }
            return;
        }
        
        if(directory[$-1] != FileConst.PathSeparatorChar)
        {
            directory ~= FileConst.PathSeparatorChar;
        }
        
        auto path = new FilePath(directory);
        if(!path.exists || !path.isFolder)
        {
            Logger.addWarning(this, "Transmission: Directory '{}' does not exist.", directory);
            return;
        }
        
        if(auto setting = (Phrase.Preview_Directory__setting in settings))
        {
            setting.value = directory;
        }
    }
    
    Setting getSetting(uint id)
    {
        if(!is_connected) return null;
        auto ptr = (id in settings);
        return ptr ? *ptr : null;
    }
    
    void setSetting(uint id, char[] value)
    {
        //sneak in own setting
        if(id == Phrase.Preview_Directory__setting)
        {
            return setPreviewDirectory(value);
        }
        
        auto setting = cast(TSetting) getSetting(id);
        if(setting) sessionSet(setting, value);
    }
    
    uint getSettingCount()
    {
        return is_connected ? settings.length : 0;
    }
    
    Setting[] getSettingArray()
    {
        return is_connected ? Utils.convert!(Setting)(settings) : null;
    }
    
    void previewFile(char[] name)
    {
        auto setting = (Phrase.Preview_Directory__setting in settings);
        
        if(setting is null)
        {
            return;
        }
        
        if(setting.value.length == 0)
        {
            Logger.addInfo(this, "Transmision: Please set preview directory first.");
            return;
        }
        
        auto path = new FilePath(setting.getValue);
        path.append = name;
        
        if(!path.exists)
        {
            Logger.addWarning(this, "Transmission: Can't find file '{}' for preview.", path.toString);
            return;
        }
        
        if(path.isFolder)
        {
            Logger.addWarning(this, "Transmission: Can only preview files, found folder '{}'.", path.toString);
            return;
        }
        
        auto file = new Tango.File(path.toString);
        
        Host.saveFile(file, path.file, path.fileSize);
    }
    
    private void getJsonSettings()
    {
        assert(get_settings_tag == 3);
        send(`{ "method" : "session-get", "tag": 3 }`);
    }
    
    //request slow changing data for torrents
    private void updateSlow()
    {
        assert(torrent_get_tag == 1);
        send(`{"method":"torrent-get","tag":1,"arguments":{"fields":["id","name","totalSize","status","comment","downloadLimit","files","trackers","priorities","hashString"]}}`);
    }
    
    //request fast changing data for torrents
    private void updateFast()
    {
        assert(torrent_get_tag == 1);
        send(`{"method":"torrent-get","tag":1,"arguments":{ "fields":["id","files","leftUntilDone","rateDownload","rateUpload","swarmSpeed","seeders","peers","leechers","peersGettingFromUs","peersSendingToUs"]}`
        );
    }
    
    void deleteTorrents(uint[] ids)
    {
        actionRequest("torrent-remove", ids);
    }
    
    void verifyTorrents(uint[] ids)
    {
        actionRequest("torrent-verify", ids);
    }

    void startTorrents(uint[] ids)
    {
        actionRequest("torrent-start", ids);
    }
    
    void stopTorrents(uint[] ids)
    {
        actionRequest("torrent-stop", ids);
    }
    
    private void actionRequest(char[] method, uint[] ids)
    {
        if(ids.length == 0) return;
        
        auto args = new JsonObject();
        args["ids"] = ids;
        
        auto packet = new JsonObject();
        packet["method"] = method;
        packet["arguments"] = args;
        
        send(packet);
    }

    private void statsRequest()
    {
        assert(session_stats_tag == 2);
        send(`{"method":"session-stats","tag": 2}`);
    }

    void setPeerLimit(uint[] ids, uint max_peers)
    {
        torrentSet("peer-limit", ids, max_peers);
    }
    
    void setFilesWanted(uint[] ids, uint[] subfiles_wanted)
    {
        torrentSet("files-wanted", ids, subfiles_wanted);
    }
    
    void setFilesUnwanted(uint[] ids, uint[] subfiles_unwanted)
    {
        torrentSet("files-unwanted", ids, subfiles_unwanted);
    }
    
    void setSpeedLimitDown(uint[] ids, uint speed_limit_down)
    {
        torrentSet("speed-limit-down", ids, speed_limit_down);
    }
    
    void setSpeedLimitDownEnabled(uint[] ids, bool enable)
    {
        torrentSet("speed-limit-down-enabled", ids, enable);
    }
    
    void setSpeedLimitUp(uint[] ids, uint speed_limit_up)
    {
        torrentSet("speed-limit-up", ids, speed_limit_up);
    }
    
    void setSpeedLimitUpEnabled(uint[] ids, bool enable)
    {
        torrentSet("speed-limit-up-enabled", ids, enable);
    }
    
    private void torrentSet(T)(char[] arg_name, uint[] ids, T arg_value)
    {
        if(ids.length == 0)
            return;
        
        auto args = new JsonObject();
        auto packet = new JsonObject();
        
        args[arg_name] = arg_value;
        
        packet["method"] = "torrent-set";
        packet["ids"] = ids;
        packet["arguments"] = args;
        
        send(packet);
    }
    
    private void sessionSet(TSetting setting, char[] new_value)
    {
        if(setting is null || new_value.length > 160)
            return;
        
        auto args = new JsonObject();
        
        switch(setting.type)
        {
        case Setting.Type.BOOL:
            args[setting.name] = Convert.to!(bool)(new_value);
            break;
        case Setting.Type.NUMBER:
            args[setting.name] = Convert.to!(double)(new_value);
            break;
        case Setting.Type.STRING:
            args[setting.name] = new_value;
            break;
        }
        
        auto packet = new JsonObject();
        packet["method"] = "session-set";
        packet["arguments"] = args;
        
        send(packet);
    }
    
    void addTorrent(void[] torrent_file, char[] download_dir = null, bool paused = false, int peer_limit = 0)
    {
        auto args = new JsonObject();
    
        if(download_dir)
            args["download-dir"] = download_dir;
        
        if(paused)
            args["paused"] = 1;
        
        if(peer_limit)
            args["peer-limit"] = peer_limit;
        
        args["metainfo"] = Base64.encode(cast(ubyte[]) torrent_file);
        
        auto packet = new JsonObject();
        
        packet["method"] = "torrent-add";
        packet["arguments"] = args;
        packet["tag"] = "torrent-add";
        
        send(packet);
    }
    
    private synchronized void send(JsonObject query)
    {
        buffer.clear();
        query.print((char[] s) { buffer.append(s); }, false);
        send(cast(char[]) buffer.slice.dup);
    }

    private synchronized void send(char[] query)
    {
        buffer.clear();
        buffer.append("POST /transmission/rpc HTTP/1.1\r\n");
        buffer.append("User-Agent: " ~ Host.main_name ~ "\r\n");
        buffer.append("Content-Type: application/json; charset=UTF-8\r\n");
        buffer.append("X-Transmission-Session-Id: " ~ session_id ~ "\r\n");
        buffer.append("Content-Length: " ~ Integer.toString(query.length) ~ "\r\n\r\n");
        buffer.append(query);

        debug(Transmission)
            Stdout("(D) Transmission request:\n")(req).newline;
        
        char[] packet_header;
        char[] packet_body;
        
        try
        {
            debug(Transmission)
            {
                Stdout("Transmission: Out:\n")(cast(char[]) buffer.slice).newline;
            }
            
            scope socket = new Socket();
            socket.connect(new IPv4Address(host, port));
            
            socket.write(buffer.slice);
            
            buffer.clear();
            
            auto read = Utils.transfer(&socket.read, &buffer.write);
            if(read == 0 || read == IConduit.Eof)
            {
                throw new Exception("Transmission: Connection failed.");
            }
            
            socket.shutdown();
            socket.close();
            
            char[] in_msg = cast(char[]) buffer.slice();
            debug(Transmission)
                Stdout("Transmission: In:\n")(in_msg).newline;
            
            auto header_end = 4 + find(in_msg, "\r\n\r\n");
            if(header_end < in_msg.length)
            {
                packet_header = in_msg[0..header_end];
                packet_body = in_msg[header_end..$];
                
                handlePacketBody(packet_body);
            }
            else
            {
                Logger.addWarning(this, "Transmission: No payload found.");
            }
        }
        catch(Exception e)
        {
            /*
            *    If we receive a 409 http error code,
            *    then we haven't set the header key/value pair yet.
            */
            if(Utils.is_prefix(packet_header, "HTTP/1.1 409") && session_id.length == 0)
            {
                //extract the value of a given key
                static char[] getHeaderValue(char[] header, char[] key)
                {
                    auto beg = key.length + find(header, key);
                    if(beg >= header.length)
                        return null;
                    auto end = beg + find(header[beg..$], "\r\n");
                    if(end >= header.length)
                        return null;
                    return header[beg..end].dup;
                }
                
                session_id = getHeaderValue(packet_header, "X-Transmission-Session-Id: ");
                if(session_id.length != 0)
                {
                    //resend message
                    return send(query);
                }
                Logger.addError(this, "Transmission: Could not get X-Transmission-Session-Id.");
            }
            
            Logger.addError(this, "Transmission: {}", e.toString);
            disconnect(); //clears buffer, too
        }
    }
    
    private void handlePacketBody(char[] packet_body)
    {
        auto pa = new JsonParser!();
        auto packet = pa.parseObject(packet_body);
        
        auto data = packet["arguments"].toJsonObject();
        char[] result = packet["result"].toString();
        uint tag = packet["tag"].toInteger();
        
        
        if(result != "success")
        {
            Logger.addError(this, "Transmission: Received error: {}", result);
            return;
        }

        if(data is null)
        {
            Logger.addError(this, "Transmission: No payload received for tag {}.", tag);
            return;
        }
        
        switch(tag)
        {
            case 0:
                break;
            case torrent_get_tag:
                auto array = data["torrents"].toJsonArray();
                if(array) handleTorrents(array);
                break;
            case session_stats_tag:
                handleStats(data);
                break;
            case get_settings_tag:
                handleSettings(data);
                break;
            default:
                Logger.addWarning(this, "Transmission: Unknown tag {}.", tag);
        }
    }
    
    private void handleTorrents(JsonArray array)
    {
        uint[] ids;
        foreach(JsonValue file_value; array)
        {
            auto file = file_value.toJsonObject();
            if(file is null) continue;
            
            uint id = file["id"].toInteger();
            
            if(id == 0) continue;
            
            if(auto download = (id in downloads))
            {
                download.update(file);
            }
            else
            {
                downloads[id] = new TTorrent(file, this);
            }
            ids ~= id;
        }
        
        foreach(id; Utils.diff(downloads.keys, ids))
        {
            downloads.remove(id);
        }
    }
    
    private void handleStats(JsonObject obj)
    {
        foreach(char[] key, JsonValue value; obj)
        {
            switch(key)
            {
            case "cumulative-stats":
                auto object = value.toJsonObject();
                if(object is null) break;
                downloaded = object["downloadedBytes"].toInteger;
                //object["filesAdded"].toInteger;
                //object["secondsActive"].toInteger;
                //object["sessionCount"].toInteger;
                uploaded = object["uploadedBytes"].toInteger;
                break;
            case "current-stats":
                auto object = value.toJsonObject();
                if(object is null) break;
                //object["downloadedBytes"].toInteger;
                //object["filesAdded"].toInteger;
                auto age = object["secondsActive"].toInteger;
                //object["sessionCount"].toInteger;
                //object["uploadedBytes"].toInteger;
                break;
            case "activeTorrentCount":
                //active_torrent_count = value.toInteger();
                break;
            case "downloadSpeed":
                download_speed = value.toInteger();
                break;
            case "pausedTorrentCount":
                //paused_torrent_count = value.toInteger();
                break;
            case "torrentCount":
                //torrent_count = value.toInteger();
                break;
            case "uploadSpeed":
                upload_speed = value.toInteger();
                break;
            default:
            }
        }
    }
    
    private void handleSettings(JsonObject object)
    {
        foreach(char[] key, JsonValue value; object)
        {
            if(key == "version")
            {
                client_version = value.toString();
            }
            else foreach(setting; settings)
            {
                if(setting.name != key)
                    continue;
                
                if(auto n = value.toJsonNumber)
                {
                    setting.value = n.toString();
                }
                else if(auto n = value.toJsonString)
                {
                    setting.value = n.toString();
                }
                else if(auto n = value.toJsonBool)
                {
                    setting.value = n.toString();
                }
                break;
            }
        }
    }
}