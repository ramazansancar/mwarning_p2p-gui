﻿module webcore.Dictionary;

/*
* This file is part of P2P-GUI and is 
* licensed under GNU General Public License.
*/

import tango.io.Stdout;

/*
* Enumeration of almost all strings used in the application
*
* - New Enum names should closely match the english translation.
* - Meta information is added after two underscores
*   and not part of the translation.
*/
enum Phrase
{
    Nil = 0,
    
    /*module names*/
    Core,
    Titlebar,
    FileBrowser,
    Downloads,
    Servers,
    Clients,
    Console,
    Searches,
    PageRefresh,
    UserManagement,
    UserSettings,
    ModuleSettings,
    ClientSettings,
    Container,
    AddLinks,
    QuickConnect,
    Uploads,
    Translator,
    Logout,
    
    /*languages*/
    English,
    German,
    Spanish,
    Polish,
    Galician,
    Brazilian_Portuguese,
    Danish,
    Dutch,
    Swedish,
    French,
    Italian,
    
    /*titlebar styles*/
    Default_Titlebar,
    Icon_Titlebar,
    Plain_Titlebar,
    
    /*setting names*/
    basic_auth,
    enable_ssl,
    password,
    Home_Directory,
    language,
    style,
    design,
    elements,
    use_javascript,
    min_refresh,
    cmd_on_top,
    content_source,
    reload_content,
    column_order,
    show_columns,
    allow_file_upload,
    show_directories,
    show_hidden_files,
    Number_of_Lines,
    Load_Modules,
    Unload_Modules,
    default_interface,
    show_description,
    auto_disconnect_clients,
    show_help,
    enable_sessions,
    show_percent_bar,
    enable_row_colors,
    Disable_Account,
    Exit_Program,
    enable_rotX,
    enable_l33t,
    
    /*downloads/servers/uploads table headers names*/
    Id,
    Size,
    Name,
    State,
    Speed,
    UploadRate,
    DownloadRate,
    Downloaded,
    Uploaded,
    Priority,
    Users,
    Check,
    ETA,
    Percent,
    Description,
    Files,
    Flag,
    IP_Address,
    Host,
    Port,
    Action,
    Last_Seen,
    Sources,
    Software,
    Hash,
    Chunks,
    Networks,
    Ping,
    Filename,
    
    /*file states*/
    Active,
    Paused,
    Stopped,
    Complete,
    Process,
    
    /*Servers*/
    Connect,
    Disconnect,
    Block,
    Unblock,
    Remove,
    
    /*File Browser*/
    Type,
    Delete,
    Load_Torrent,
    Upload,
    Directory,
    Upload_File,
    No_Home_Directory,
    
    /*Downloads*/
    Cancel,
    Pause,
    Stop,
    Resume,
    Prioritize,
    Rename,
    Hide,
    Preview,
    No_Items_Found,
    Commit,
    FileNames,
    SubFiles,
    Comments,
    Connecting,
    Connected,
    Disconnected,
    Blocked,
    Add_Owner,
    Invert,
    Range,
    Refreshing_every_x_seconds,
    
    /*for priorities*/
    Auto,
    None__priority,
    None__empty,
    Very_Low,
    Low,
    Normal,
    High,
    Very_High,
    
    /*Page Refresh*/
    Refresh,
    
    /*Settings*/
    Value,
    Save,
    Apply,
    
    /*Searches*/
    Text,
    Results,
    Content_Type,
    Availability,
    Search,
    Keywords,
    Found,
    Actions,
    Not_Connected,
    Network,
    All,
    Program,
    Document,
    Image,
    Audio,
    Video,
    Archive,
    Download,
    Format,
    Nothing_found_yet,
    
    /*Clients*/
    Selected,
    Select,
    Shutdown,
    Password,
    
    /*Console*/
    Not_Available,
    Not_Supported,
    Send,
    
    /*Module Settings*/
    Nothing_Selected,
    Categories,
    User,
    Modules,
    
    /*Client Settings*/
    Not_Found,
    
    /*User Management*/
    Add,
    Set_Password,
    
    /*Links*/
    Load_Link,
    
    /*misc. comments*/
    Not_Tested,
    Not_Working,
    
    /*Shutdown*/
    Really_Shutdown,
    Yes,
    No,
    
    /*Translator*/
    Show,
    
    /*Client Settings - inspired by Transmission*/
    download_dir__setting,
    peer_limit__setting,
    port__setting,
    port_forwarding_enabled__setting,
    speed_limit_down__setting,
    speed_limit_up__setting,
    Preview_Directory__setting
}

struct Language
{
    Phrase id;
    char[] code;
    char[][] dictionary;
}

struct Dictionary
{
    static const Language[] languages;
    static const Language default_language;
    
    static this()
    {
        languages = [
            Language(Phrase.English, "en_US", english_dict),
            Language(Phrase.Danish, "dk_DK", danish_dict),
            Language(Phrase.Brazilian_Portuguese, "pt_BR", brazilian_portuguese_dict),
            Language(Phrase.Dutch, "nl_NL", dutch_dict),
            Language(Phrase.French, "fr_FR", french_dict),
            Language(Phrase.Galician, "gl_ES", galician_dict),
            Language(Phrase.German, "de_DE", german_dict),
            Language(Phrase.Polish, "pl_PL", polish_dict),
            Language(Phrase.Spanish, "es_ES", spanish_dict),
            Language(Phrase.Swedish, "se_SE", swedish_dict),
            Language(Phrase.Italian, "it_IT", italian_dict),
            Language(Phrase.Turkish, "tr_TR", turkish_dict)
        ];
        
        default_language = languages[0];
    }
    
    //language ids
    static const Phrase[] all_languages = [
        Phrase.Brazilian_Portuguese, Phrase.Danish, Phrase.Dutch, Phrase.English, Phrase.French,
        Phrase.Galician, Phrase.German, Phrase.Polish, Phrase.Spanish, Phrase.Swedish, Phrase.Italian, 
        Phrase.Turkish
    ];

    static char[][] getDictionary(Phrase id)
    {
        foreach(ref item; languages)
        {
            if(item.id == id)
            {
                return item.dictionary;
            }
        }
        return null;
    }

    static Language* getLanguage(Phrase id)
    {
        foreach(ref lang; languages)
        {
            if(lang.id == id)
            {
                return &lang;
            }
        }
        return null;
    }

    static Language* getLanguage(char[] code)
    {
        foreach(ref lang; languages)
        {
            if(lang.code == code)
            {
                return &lang;
            }
        }
        return null;
    }
    
    /*
    * All Translations.
    */

    static char[][Phrase.max+1] english_dict =
    [
        Phrase.Nil : " ", //not empty! Empty strings are considered not to be set!
        
        /*module names*/
        Phrase.Core : "Core",
        Phrase.Titlebar : "Titlebar",
        Phrase.FileBrowser : "File Browser",
        Phrase.Downloads : "Downloads",
        Phrase.Servers : "Servers",
        Phrase.Clients : "Clients",
        Phrase.Console : "Console",
        Phrase.Searches : "Searches",
        Phrase.PageRefresh : "Page Refresh",
        Phrase.UserManagement : "User Management",
        Phrase.UserSettings : "User Settings",
        Phrase.ModuleSettings : "Module Settings",
        Phrase.ClientSettings : "Client Settings",
        Phrase.Container : "Container",
        Phrase.AddLinks : "Add Links",
        Phrase.QuickConnect : "Quick Connect",
        Phrase.Uploads : "Uploads",
        Phrase.Translator : "Translator",
        Phrase.Logout : "Logout",
        
        /*languages*/
        Phrase.English : "English",
        Phrase.German : "German",
        Phrase.Spanish : "Spanish",
        Phrase.Polish : "Polish",
        Phrase.Galician : "Galician",
        Phrase.Brazilian_Portuguese : "Brazilian Portuguese",
        Phrase.Danish : "Danish",
        Phrase.Dutch : "Dutch",
        Phrase.Swedish : "Swedish",
        Phrase.French : "French",
        Phrase.Italian : "Italian",
        Phrase.Turkish : "Turkish",
        
        /*setting names*/
        Phrase.basic_auth : "Basic Authentification",
        Phrase.enable_ssl : "Enable SSL",
        Phrase.password : "Password",
        Phrase.Home_Directory : "Home Directory",
        Phrase.language : "Language",
        Phrase.style : "Style",
        Phrase.design : "Design",
        Phrase.elements : "Elements",
        Phrase.use_javascript : "Use Javascript",
        Phrase.min_refresh : "Min Refresh",
        Phrase.cmd_on_top : "Command Line on Top",
        Phrase.content_source : "Content Source",
        Phrase.reload_content : "Reload Content",
        Phrase.column_order : "Column Order",
        Phrase.show_columns : "Show Columns",
        Phrase.allow_file_upload : "Allow File Upload",
        Phrase.show_directories : "Show Directories",
        Phrase.show_hidden_files : "Show Hidden Files",
        Phrase.Number_of_Lines : "Number of Rows",
        Phrase.Load_Modules : "Load Modules",
        Phrase.Unload_Modules : "Unload Modules",
        Phrase.default_interface : "Default Interface",
        Phrase.show_description : "Show Description",
        Phrase.auto_disconnect_clients : "Auto Disconnect Clients",
        Phrase.show_help : "Show Help",
        Phrase.enable_sessions : "Enable Sessions",
        Phrase.show_percent_bar : "Show Percent Bar",
        Phrase.enable_row_colors : "Enable Row Colors",
        Phrase.Disable_Account : "Disable Account",
        Phrase.Exit_Program : "Exit Program",
        Phrase.enable_rotX : "Enable ROT-X",
        Phrase.enable_l33t : "Enable l33t",

        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Size : "Size",
        Phrase.Name : "Name",
        Phrase.State : "State",
        Phrase.Speed : "Speed",
        Phrase.UploadRate : "Upload Rate",
        Phrase.DownloadRate : "Download Rate",
        Phrase.Downloaded : "Downloaded",
        Phrase.Uploaded : "Uploaded",
        Phrase.Priority : "Priority",
        Phrase.Users : "Users",
        Phrase.Check : "[x]",
        Phrase.ETA : "ETA",
        Phrase.Percent : "Percent",
        Phrase.Description : "Description",
        Phrase.Files : "Files",
        Phrase.Flag : "Flag",
        Phrase.IP_Address : "IP Address",
        Phrase.Host : "Host",
        Phrase.Port : "Port",
        Phrase.Action : "Action",
        Phrase.Last_Seen : "Last Seen",
        Phrase.Sources : "Sources",
        Phrase.Software : "Software",
        Phrase.Hash : "Hash",
        Phrase.Chunks : "Chunks",
        Phrase.Networks : "Networks",
        Phrase.Ping : "Ping",
        Phrase.Filename : "Filename",
        
        /*file states*/
        Phrase.Active : "Active",
        Phrase.Paused : "Paused",
        Phrase.Stopped : "Stopped",
        Phrase.Complete : "Complete",
        Phrase.Process : "Process",
        
        Phrase.Default_Titlebar : "Default",
        Phrase.Icon_Titlebar : "Icons",
        Phrase.Plain_Titlebar : "Plain",
        
        /*Servers*/
        Phrase.Connect : "Connect",
        Phrase.Disconnect : "Disconnect",
        Phrase.Block : "Block",
        Phrase.Unblock : "Unblock",
        Phrase.Remove : "Remove",
        
        /*File Browser*/
        Phrase.Delete : "Delete",
        Phrase.Type : "Type",
        Phrase.Load_Torrent : "Load Torrent",
        Phrase.Upload : "Upload",
        Phrase.Directory : "Directory",
        Phrase.Upload_File : "Upload File",
        Phrase.No_Home_Directory : "No Home Directory",
        
        /*Downloads*/
        Phrase.Cancel : "Cancel",
        Phrase.Pause : "Pause",
        Phrase.Stop : "Stop",
        Phrase.Resume : "Resume",
        Phrase.Prioritize : "Set Priority",
        Phrase.Rename : "Rename",
        Phrase.Hide : "Hide",
        Phrase.Preview : "Preview",
        Phrase.No_Items_Found : "No Items found.",
        Phrase.Commit : "Commit",
        Phrase.FileNames : "File Names",
        Phrase.SubFiles : "Subfiles",
        Phrase.Comments : "Comments",
        Phrase.Connecting : "Connecting",
        Phrase.Connected : "Connected",
        Phrase.Disconnected : "Disconnected",
        Phrase.Blocked : "Blocked",
        Phrase.Add_Owner : "Add Owner",
        Phrase.Invert : "Invert",
        Phrase.Range : "Range",
        Phrase.Refreshing_every_x_seconds : "Refreshing every {} seconds.",
        
        /*for priorities*/
        Phrase.Auto : "Auto",
        Phrase.None__empty : "None",
        Phrase.None__priority : "None",
        Phrase.Very_Low : "Very Low",
        Phrase.Low : "Low",
        Phrase.Normal : "Normal",
        Phrase.High : "High",
        Phrase.Very_High : "Very High",
        
        /*Page Refresh*/
        Phrase.Refresh : "Refresh",
        
        /*Settings*/
        Phrase.Value : "Value",
        Phrase.Save : "Save",
        Phrase.Apply : "Apply",
        
        /*Searches*/
        Phrase.Text : "Text",
        Phrase.Results : "Results",
        Phrase.Content_Type : "Content Type",
        Phrase.Availability : "Availability",
        Phrase.Search : "Search",
        Phrase.Keywords : "Keywords",
        Phrase.Found : "Found",
        Phrase.Actions : "Actions",
        Phrase.Not_Connected : "Not Connected",
        Phrase.Network : "Network",
        Phrase.All : "All",
        Phrase.Program : "Program",
        Phrase.Document : "Document",
        Phrase.Image : "Image",
        Phrase.Audio : "Audio",
        Phrase.Video : "Video",
        Phrase.Archive : "Archive",
        Phrase.Download : "Download",
        Phrase.Format : "Format",
        Phrase.Nothing_found_yet : "Nothing found yet!",
        
        /*Clients*/
        Phrase.Selected : "Selected",
        Phrase.Select : "Select",
        Phrase.Shutdown : "Shutdown",
        Phrase.Password : "Password",
        
        /*Console*/
        Phrase.Not_Available : "Not Available!",
        Phrase.Not_Supported : "Not Supported!",
        Phrase.Send : "Send",
        
        /*Module Settings*/
        Phrase.Nothing_Selected : "Nothing Selected",
        Phrase.Categories : "Categories",
        Phrase.User : "User",
        Phrase.Modules : "Modules",
        
        /*Client Settings*/
        Phrase.Not_Found : "Not Found!",
        
        /*User Management*/
        Phrase.Add : "Add",
        Phrase.Set_Password : "Set Password",
        
        /*Links*/
        Phrase.Load_Link : "Load Link",
        
        /*misc. comments*/
        Phrase.Not_Tested : "Not tested!",
        Phrase.Not_Working : "Not working!",
        
        /*Shutdown*/
        Phrase.Really_Shutdown : "Do you really want to shutdown %s?",
        Phrase.Yes : "Yes",
        Phrase.No : "No",
        
        /*Translator*/
        Phrase.Show : "Show",
        
        /*Client Settings*/
        Phrase.download_dir__setting : "Download Directory",
        Phrase.peer_limit__setting : "Peer Limit",
        Phrase.port__setting : "Port",
        Phrase.port_forwarding_enabled__setting : "Port Forwarding Enabled",
        Phrase.speed_limit_down__setting : "Download Speed Limit",
        Phrase.speed_limit_up__setting : "Upload Speed Limit",
        Phrase.Preview_Directory__setting : "Preview Directory"
    ];

    static char[][Phrase.max+1] german_dict =
    [
        Phrase.Nil : " ",
        
        /*Modulnamen*/
        Phrase.Core : "Kern",
        Phrase.Titlebar : "Navigation",
        Phrase.FileBrowser : "Datei Browser",
        Phrase.Downloads : "Downloads",
        Phrase.Servers : "Server",
        Phrase.Clients : "Clients",
        Phrase.Console : "Konsole",
        Phrase.Searches : "Suchen",
        Phrase.PageRefresh : "Page Refresh",
        Phrase.UserManagement : "Benutzer Verwaltung",
        Phrase.UserSettings : "Benutzer Einstellungen",
        Phrase.ModuleSettings : "Modul Einstellungen",
        Phrase.ClientSettings : "Client Einstellungen",
        Phrase.Container : "Container",
        Phrase.AddLinks : "Starte Links",
        Phrase.QuickConnect : "Verbinden",
        Phrase.Uploads : "Uploads",
        Phrase.Translator : "Übersetzer",
        Phrase.Logout : "Abmelden",
        
        /*Sprachen*/
        Phrase.English : "Englisch",
        Phrase.German : "Deutsch",
        Phrase.Spanish : "Spanisch",
        Phrase.Polish : "Polnisch",
        Phrase.Galician : "Galicisch",
        Phrase.Brazilian_Portuguese : "Brazilianisch Portugiesisch",
        Phrase.Danish : "Dänisch",
        Phrase.Dutch : "Niederländisch",
        Phrase.Swedish : "Schwedisch",
        Phrase.French : "Französisch",
        Phrase.Italian : "Italienisch",
        Phrase.Turkish : "Türkisch",
        
        /*Einstellungen*/
        Phrase.basic_auth : "Basic Authentifikation",
        Phrase.enable_ssl : "Enable SSL",
        Phrase.password : "Passwort",
        Phrase.Home_Directory : "Heimatverzeichnis",
        Phrase.language : "Sprache",
        Phrase.style : "Style",
        Phrase.design : "Design",
        Phrase.elements : "Elemente",
        Phrase.use_javascript : "Verwende Javascript",
        Phrase.min_refresh : "Min Refresh",
        Phrase.cmd_on_top : "Kommandozeile oben",
        Phrase.content_source : "Quelleninhalt",
        Phrase.reload_content : "Inhalt Neuladen",
        Phrase.column_order : "Spalten Reihenfolge",
        Phrase.show_columns : "Spalten Anzeigen",
        Phrase.allow_file_upload : "Datei Upload erlauben",
        Phrase.show_directories : "Zeige Verzeichnisse",
        Phrase.show_hidden_files : "Versteckte Dateien anzeigen",
        Phrase.Number_of_Lines : "Zeilenanzahl",
        Phrase.Load_Modules : "Module Laden",
        Phrase.Unload_Modules : "Module Entladen",
        Phrase.default_interface : "Default Oberfläche",
        Phrase.show_description : "Zeige Beschreibung",
        Phrase.auto_disconnect_clients : "Clients automatisch trennen",
        Phrase.show_help : "Hilfe Anzeigen",
        
        Phrase.Id : "Nr",
        Phrase.Name : "Name",
        Phrase.State : "Status",
        Phrase.Speed : "Speed",
        Phrase.Downloaded : "Downloaded",
        Phrase.Uploaded : "Uploaded",
        Phrase.Priority : "Priorität",
        Phrase.Users : "Benutzer",
        Phrase.ETA : "ETA",
        Phrase.Percent : "Prozent",
        Phrase.Description : "Beschreibung",
        Phrase.Files : "Dateien",
        Phrase.Flag : "Flagge",
        Phrase.IP_Address : "IP Adresse",
        Phrase.Action : "Aktion",
        Phrase.Last_Seen : "Zuletzt gesehen",    
        Phrase.Sources : "Quellen",
        Phrase.Software : "Software",
        Phrase.Hash : "Hash",
        Phrase.Chunks : "Chunks",
        Phrase.Networks : "Netzwerke",
        
        Phrase.Default_Titlebar : "Default",
        Phrase.Icon_Titlebar : "Icons",
        Phrase.Plain_Titlebar : "Plain",
        
        /*Server*/
        Phrase.Connect : "Verbinden",
        Phrase.Disconnect : "Trennen",
        Phrase.Block : "Blockieren",
        Phrase.Unblock : "Entsperren",
        Phrase.Remove : "Entfernen",
        
        /*Datei Browser*/
        Phrase.Delete : "Löschen",
        Phrase.Type : "Typ",
        Phrase.Load_Torrent : "Torrent laden",
        Phrase.Upload : "Hochladen",
        Phrase.Directory : "Verzeichnis",
        Phrase.Upload_File : "Datei hochladen",
        Phrase.No_Home_Directory : "Keine Wurzelverzeichnis",
        
        /*Downloads*/
        Phrase.Cancel : "Abbrechen",
        Phrase.Pause : "Pause",
        Phrase.Stop : "Stop",
        Phrase.Resume : "Fortführen",
        Phrase.Prioritize : "Priorisieren",
        Phrase.Rename : "Umbenennen",
        Phrase.Hide : "Vertecken",
        Phrase.Preview : "Vorschau",
        Phrase.No_Items_Found : "Keine Einträge gefunden.",
        Phrase.Commit : "Commit",
        Phrase.FileNames : "Dateinamen",
        Phrase.SubFiles : "Teildateien",
        Phrase.Comments : "Kommetare",
        Phrase.Connecting : "Verbindet",
        Phrase.Connected : "Verbunden",
        Phrase.Disconnected : "Getrennt",
        Phrase.Blocked : "Gesperrt",
        Phrase.Add_Owner : "Benutzer Hinzufügen",
        Phrase.Invert : "Invertieren",
        Phrase.Range : "Bereich",
        Phrase.Refreshing_every_x_seconds : "Alle {} Sekunden neuladen.",
        
        /*for priorities*/
        Phrase.Auto : "Auto",
        Phrase.None__empty : "Keine",
        Phrase.Very_Low : "Sehr Niedrig",
        Phrase.Low : "Niedrig",
        Phrase.Normal : "Normal",
        Phrase.High : "Hoch",
        Phrase.Very_High : "Sehr Hoch",
        
        /*Seiten Neuladen*/
        Phrase.Refresh : "Neu Laden",
        
        /*Einstellungen*/
        Phrase.Value : "Wert",
        Phrase.Save : "Speichern",
        Phrase.Apply : "Anwenden",
        
        /*Suchen*/
        Phrase.Text : "Text",
        Phrase.Size : "Größe",
        Phrase.Results : "Ergebnisse",
        Phrase.Content_Type : "Format",
        Phrase.Availability : "Verfügbarkeit",
        Phrase.Search : "Suche",
        Phrase.Keywords : "Stichwörter",
        Phrase.Found : "Gefunden",
        Phrase.Actions : "Aktionen",
        Phrase.Not_Connected : "Nicht verbunden!",
        Phrase.Network : "Netzwerk",
        Phrase.All : "Alle",
        Phrase.Program : "Programm",
        Phrase.Document : "Dokument",
        Phrase.Image : "Bild",
        Phrase.Audio : "Ton",
        Phrase.Video : "Video",
        Phrase.Archive : "Archive",
        Phrase.Download : "Download",
        Phrase.Format : "Format",
        Phrase.Nothing_found_yet : "Nichts gefunden bisher!",
        
        /*Clients*/
        Phrase.Selected : "Ausgewählt",
        Phrase.Select : "Auswählen",
        Phrase.Shutdown : "Beenden",
        
        /*Konsole*/
        Phrase.Not_Available : "Nicht verfügbar!",
        Phrase.Not_Supported : "Nicht Unterstützt!",
        Phrase.Send : "Senden",
        
        /*Module Einstellungen*/
        Phrase.Nothing_Selected : "Nichts ausgewählt",
        Phrase.Categories : "Kategorien",
        Phrase.User : "Benutzer",
        Phrase.Modules : "Module",
        
        /*Client Einstellungen*/
        Phrase.Not_Found : "Nicht gefunden!",
        
        /*Benutzerverwaltung*/
        Phrase.Add : "Hinzufügen",
        Phrase.Set_Password : "Password setzen",
        
        /*Links*/
        Phrase.Load_Link : "Lade Link",
        
        /*vers. Kommentare*/
        Phrase.Not_Tested : "Nicht getestet!",
        Phrase.Not_Working : "Funktioniert nicht!",
        
        /*Beenden*/
        Phrase.Really_Shutdown : "Soll %s wirklich beendet werden?",
        Phrase.Yes : "Ja",
        Phrase.No : "Nein",
        
        /*Translator*/
        Phrase.Show : "Show"
    ];

    static char[][Phrase.max+1] spanish_dict =
    [
        Phrase.Nil : " ",
        Phrase.password : "Contraseña",
        Phrase.Send : "Entrar",
        Phrase.Console : "Consola",
        Phrase.Nothing_Selected : "No se han seleccionado objetos.",
        Phrase.Rename : "Renombrar",
        //Phrase.Owner : "Dueño",
        Phrase.Network : "Red",
        Phrase.Hash : "Hash",
        Phrase.Size : "Tamaño",
        Phrase.Downloaded : "Descargado",
        Phrase.Priority : "Prioridad",
        Phrase.Speed : "Velocidad",
        Phrase.Last_Seen : "Último Visto",
        Phrase.Sources : "Fuentes",
        //Phrase.Complete : "Completado",
        //Phrase.Finished : "Finalizado",
        //Phrase.Verified : "Verificado",
        
        Phrase.Availability : "Disponibilidad",
        //Phrase.Missing : "Falta",
        Phrase.Download : "Descargar",
        Phrase.Downloads : "Descargas",
        Phrase.AddLinks : "Enlaces",
        Phrase.ETA : "ETA",
        Phrase.Resume : "Continuar",
        Phrase.Cancel : "Cancelar",
        Phrase.Commit : "Guardar",
        Phrase.Pause : "Pausa",
        Phrase.Remove : "Eliminar",
        Phrase.Delete : "Eliminar",
        Phrase.Yes : "Si",
        Phrase.No : "No",
        //Phrase.No_abbr : "Nro.",
        //Phrase.Port : "Puerto",
        //Phrase.Group : "Grupo",
        //Phrase.Settings : "Ajustes",
        //Phrase.Incoming : "Bandeja de Entrada",
        Phrase.Directory : "Directorio",
        Phrase.User : "Usuario",
        Phrase.Upload : "Subir",
        Phrase.Apply : "Ajustar",
        Phrase.Search : "Buscar",
        Phrase.Text : "Texto",
        //Phrase.View : "Ver",
        //Phrase.Forget : "Olvidar",
        Phrase.Results : "Resultados",
        //Phrase.Severs : "Servidores",
        Phrase.Files : "Ficheros",
        Phrase.Users : "Usuarios",
        //Phrase.Status : "Status",
        
        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Connected : "Conectado",
        Phrase.Connect : "Conectar",
        Phrase.Disconnect : "Desconectar",
        //Phrase.Shares : "Compartido",
        //Phrase.Share : "Compartido",
        //Phrase.NotAvailable : "No Disponible.",
        //Phrase.Unshare : "No Compartir",
        Phrase.All : "Todo",
        Phrase.None__empty : "Nada", //(select)
        Phrase.Invert : "Invertir",
        Phrase.Range : "Rango",
        //Phrase.KillClient : "Matar Cliente",
        Phrase.Uploads : "Subidas",
        //Phrase.File : "Fichero",
        //Phrase.Client : "Cliente",
        //Phrase.Rating : "Rating",
        Phrase.Uploaded : "Subido",
        //Phrase.Requests : "Peticiones",
        Phrase.UserManagement : "Administrador de Usuarios",
        Phrase.language : "Lenguaje",
        //Phrase.Theme : "Estilo",
        Phrase.PageRefresh : "Refrescar Pagina",
        //Phrase.Off : "Apagar",
        //Phrase.Menu : "Menu",
        //Phrase.Seconds : "Segundos",
        //Phrase.Groups : "Grupos",
        //Phrase.Account : "Cuenta",
        Phrase.None__priority : "Ninguna",
        Phrase.Low : "Baja",
        //Phrase.Medium : "Media",
        Phrase.High : "Alta",
        //Phrase.Welcome : "Bienvenido",
        Phrase.Logout : "Salir",
        Phrase.Paused : "Pausado"
    ];

    static char[][Phrase.max+1] polish_dict =
    [
        Phrase.Nil : " ",
        Phrase.password : "Hasło",
        Phrase.Send : "Wyślij",
        //Phrase.Reset : "Reset",
        //Phrase.Key : "Atrybut",
        Phrase.Value : "Wartość",
        Phrase.Console : "Linia poleceń",
        //Phrase.Details : "Szczegóły",
        //Phrase.Owner : "Właściciel",
        Phrase.Network : "Sieć",
        Phrase.Hash : "Hash",
        Phrase.Size : "Wielkość",
        //Phrase.Downloaded : "Ściągnięto",
        Phrase.Priority : "Priorytet",
        Phrase.Sources : "Źródła",
        //Phrase.Complete : "Kompletny",
        Phrase.Availability : "Dostępność",
        //Phrase.Missing : "Brakujące",
        //Phrase.Downloading : "Ściągane",
        //Phrase.Finished : "Zakończone",
        //Phrase.Verified : "Zweryfikowane",
        Phrase.None__empty : "Pusty", //empty
        Phrase.Download : "Ściągnij",
        //Phrase.Parse : "Przetwórz",
        Phrase.AddLinks : "Skróty",
        Phrase.Downloads : "Pobieranie",
        Phrase.Speed : "Prędkość",
        Phrase.ETA : "ETA",
        Phrase.Add : "Dodaj",
        Phrase.Cancel : "Anuluj",
        Phrase.Pause : "Pauza",
        Phrase.Resume : "Wznów",
        Phrase.Commit : "Wyślij zmiany",
        Phrase.Yes : "Tak",
        Phrase.No : "Nie",
        //Phrase.Nr : "Nr",
        //Phrase.Friends : "Znajomi",
        Phrase.Remove : "Usuń",
        //Phrase.Port : "Port",
        Phrase.Clients : "Klienci",
        //Phrase.Group : "Grupa",
        //Phrase.Settings : "Ustawienia",
        //Phrase.Incoming : "Pobrane",
        Phrase.Directory : "Katalog",
        Phrase.User : "Użytkownik",
        Phrase.Upload : "Wyślij",
        Phrase.Apply : "Ustaw",
        Phrase.Search : "Szukanie",
        Phrase.Text : "Tekst",
        Phrase.Found : "Znaleziono",
        //Phrase.View : "Pokaż",
        //Phrase.Forget : "Usuń",
        Phrase.Results : "Rezultaty",
        Phrase.Servers : "Serwery",
        Phrase.Files : "Pliki",
        Phrase.Users : "Użytkownicy",
        //Phrase.Status : "Status",
        
        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Connected : "Połączony",
        Phrase.Connect : "Połącz",
        Phrase.Disconnect : "Rozłącz",
        //Phrase.Shares : "Udziały",
        Phrase.All : "Zaznacz wszystkie",
        //Phrase.None__empty : "Odznacz wszystki",
        Phrase.Invert : "Odwróć zaznaczenie",
        Phrase.Range : "Range",
        Phrase.Uploads : "Wysyłanie",
        //Phrase.File : "Plik",
        //Phrase.Client : "Klient",
        //Phrase.Rating : "Ocena",
        Phrase.Uploaded : "Wysłane",
        //Phrase.Requests : "Żądania",
        Phrase.language : "Język",
        Phrase.PageRefresh : "Odświeżanie strony",
        //Phrase.Theme : "Schemat",
        //Phrase.Off : "Wyłączony",
        //Phrase.Menu : "Menu",
        //Phrase.Groups : "Grupy",
        Phrase.None__priority : "Brak",
        Phrase.Low : "Niski",
        //Phrase.Medium : "Średni",
        Phrase.High : "Wysoki",
        //Phrase.Welcome : "Witamy",
        Phrase.Logout : "Wyloguj się",
        //Phrase.Ready : "Gotowy",
        Phrase.Paused : "Zatrzymany"
    ];

    static char[][Phrase.max+1] brazilian_portuguese_dict =
    [
        Phrase.Nil : " ",
        Phrase.Name : "Nome",
        Phrase.password : "Senha",
        Phrase.Send : "Enviar",
        //Phrase.Reset : "Limpar",
        //Phrase.Key : "Chave",
        Phrase.Value : "Valor",
        Phrase.Console : "Console",
        //Phrase.Details : "Detalhes",
        //Phrase.Owner : "Dono",
        Phrase.Rename : "Renomear",
        Phrase.Network : "Rede",
        Phrase.Hash : "Hash",
        Phrase.Size : "Tamanho",
        //Phrase.Downloaded : "Baixado",
        Phrase.Priority : "Prioridade",
        Phrase.Sources : "Fontes",
        Phrase.Last_Seen : "Última Visto",
        //Phrase.Complete : "Completo",
        Phrase.Availability : "Disponibilidade",
        //Phrase.Missing : "Faltando",
        //Phrase.Downloading : "Baixando",
        //Phrase.Finished : "Terminado",
        //Phrase.Verified : "Verificado",
        Phrase.None__empty : "Nenhum",
        Phrase.Download : "Download",
        //Phrase.Parse : "Interpretar",
        Phrase.AddLinks : "Links",
        Phrase.Downloads : "Downloads",
        Phrase.Speed : "Velocidade",
        Phrase.ETA : "ETA",
        Phrase.Add : "Adicionar",
        Phrase.Cancel : "Cancelar",
        Phrase.Pause : "Pausar",
        Phrase.Resume : "Continuar",
        Phrase.Commit : "Processar",
        Phrase.Yes : "Sim",
        Phrase.No : "Não",
        //Phrase.Nr : "Núm",
        //Phrase.Friends : "Amigos",
        Phrase.Remove : "Remover",
        //Phrase.Port : "Porta",
        Phrase.Clients : "Clientes",
        //Phrase.Group : "Grupo",
        //Phrase.Settings : "Configurações",
        //Phrase.Incoming : "Diretório do Usuário",
        Phrase.Directory : "Diretório",
        Phrase.User : "Usuário",
        Phrase.Upload : "Upload",
        Phrase.Apply : "Alterar",
        Phrase.Search : "Pesquisar",
        Phrase.Text : "Texto",
        Phrase.Found : "Encontrado(s)",
        //Phrase.View : "Ver",
        //Phrase.Forget : "Esquecer",
        Phrase.Results : "Resultados",
        Phrase.Servers : "Servidores",
        Phrase.Files : "Arquivos",
        Phrase.Users : "Usuários",
        //Phrase.Status : "Status",
        
        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Connected : "Conectado",
        Phrase.Connect : "Conectar",
        Phrase.Disconnect : "Desconectar",
        //Phrase.Shares : "Compartilhamentos",
        Phrase.All : "Tudo",
        //Phrase.None__empty : "Nada",
        Phrase.Invert : "Inverter",
        Phrase.Range : "Faixa",
        Phrase.Uploads : "Uploads",
        //Phrase.File : "Arquivo",
        //Phrase.Client : "Cliente",
        //Phrase.Rating : "Avaliação",
        Phrase.Uploaded : "Enviado",
        //Phrase.Requests : "Pedidos",
        Phrase.language : "Linguagem",
        Phrase.PageRefresh : "Atualização de Página",
        //Phrase.Theme : "Tema",
        //Phrase.Off : "Desligado",
        //Phrase.Menu : "Menu",
        //Phrase.Groups : "Grupos",
        Phrase.None__priority : "Nenhuma",
        Phrase.Low : "Baixa",
        //Phrase.Medium : "Média",
        Phrase.High : "Alta",
        //Phrase.Welcome : "Bem-vindo",
        Phrase.Logout : "Sair",
        //Phrase.Ready : "Pronto",
        Phrase.Paused : "Pausado"
    ];

    static char[][Phrase.max+1] galician_dict =
    [
        Phrase.Nil : " ",
        Phrase.Name : "Nome",
        Phrase.password : "Contrasinal",
        Phrase.Send : "Entrar",
        //Phrase.Reset : "Borrar",
        //Phrase.Key : "Clave",
        Phrase.Value : "Valor",
        Phrase.Console : "Consola",
        //Phrase.Details : "Detalles",
        //Phrase.Owner : "Dono",
        Phrase.Rename : "Renomear",
        Phrase.Network : "Rede",
        Phrase.Hash : "Hash",
        Phrase.Size : "Tamaño",
        //Phrase.Downloaded : "Descargado",
        Phrase.Priority : "Prioridade",
        Phrase.Sources : "Fontes",
        Phrase.Last_Seen : "Última Visto",
        //Phrase.Complete : "Completado",
        Phrase.Availability : "Dispoñibilidade",
        //Phrase.Missing : "Falta",
        //Phrase.Downloading : "Descargando",
        //Phrase.Finished : "Finalizado",
        //Phrase.Verified : "Verificado",
        Phrase.Download : "Descargar",
        //Phrase.Parse : "Analizar",
        Phrase.AddLinks : "Enlaces",
        Phrase.Downloads : "Descargas",
        Phrase.Speed : "Velocidade",
        Phrase.ETA : "ETA",
        Phrase.Add : "Engadir",
        Phrase.Cancel : "Cancelar",
        Phrase.Pause : "Pausa",
        Phrase.Resume : "Continuar",
        Phrase.Commit : "Gardar",
        Phrase.Yes : "Si",
        Phrase.No : "Non",
        //Phrase.Nr : "Nro.",
        //Phrase.Friends : "Amigos",
        Phrase.Remove : "Eliminar",
        //Phrase.Port : "Porto",
        Phrase.Clients : "Clientes",
        //Phrase.Group : "Grupo",
        //Phrase.Settings : "Axustes",
        //Phrase.Incoming : "Arquivos baixados",
        Phrase.Directory : "Directorio",
        Phrase.User : "Usuario",
        Phrase.Upload : "Subir",
        Phrase.Apply : "Axustar",
        Phrase.Search : "Buscar",
        Phrase.Text : "Texto",
        Phrase.Found : "Atopado",
        //Phrase.View : "Ver",
        //Phrase.Forget : "Olvidar",
        Phrase.Results : "Resultados",
        Phrase.Servers : "Servidores",
        Phrase.Files : "Ficheiros",
        Phrase.Users : "Usuarios",
        //Phrase.Status : "Estado",
        
        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Connected : "Conectado",
        Phrase.Connect : "Conectar",
        Phrase.Disconnect : "Desconectar",
        //Phrase.Shares : "Compartido",
        Phrase.All : "Todo",
        Phrase.None__empty : "Nada",
        Phrase.Invert : "Invertir",
        Phrase.Range : "Rango",
        Phrase.Uploads : "Subidas",
        //Phrase.File : "Ficheiro",
        //Phrase.Client : "Cliente",
        //Phrase.Rating : "Rating",
        Phrase.Uploaded : "Subido",
        //Phrase.Requests : "Petici&oacute;ns",
        Phrase.language : "Linguaxe",
        Phrase.PageRefresh : "Refrescar páxina",
        //Phrase.Theme : "Estilo",
        //Phrase.Off : "Apagar",
        //Phrase.Menu : "Menu",
        //Phrase.Groups : "Grupos",
        Phrase.None__priority : "Ningunha",
        Phrase.Low : "Baixa",
        //Phrase.Medium : "Media",
        Phrase.High : "Alta",
        //Phrase.Welcome : "Benvido",
        Phrase.Logout : "Sair",
        //Phrase.Ready : "Listo",
        Phrase.Paused : "Pausado"
    ];

    static char[][Phrase.max+1] danish_dict =
    [
        Phrase.Nil : " ",
        Phrase.Servers : "Servere",
        Phrase.Clients : "Klienter",
        Phrase.Searches : "Søgninger",
        Phrase.PageRefresh : "Side Opdatering",
        Phrase.AddLinks : "Links",
        Phrase.Uploads : "Uploads",
        Phrase.password : "Kodeord",
        Phrase.show_directories : "Vis Biblioteker",
        Phrase.Name : "Navn",
        Phrase.State : "Status",
        Phrase.Speed : "Hastighed",
        Phrase.Downloaded : "Downloadet",
        Phrase.Uploaded : "Uploadet",
        Phrase.Priority : "Prioritet",
        Phrase.Users : "Bruger",
        Phrase.Percent : "%",
        Phrase.Files : "Filer",
        Phrase.IP_Address : "IP Adresse",
        Phrase.Last_Seen : "Sidst Set",    
        Phrase.Sources : "Kilder",
        Phrase.Networks : "Netværker",
        Phrase.Connect : "Forbind",
        Phrase.Disconnect : "Afbryd",
        Phrase.Remove : "Slet",
        Phrase.Cancel : "Annullér",
        Phrase.Pause : "Pause",
        Phrase.Resume : "Genoptag",
        Phrase.Rename : "Omdøb",
        Phrase.Commit : "Færdiggør",
        Phrase.Refresh : "Opdatér",
        Phrase.Save : "Gen",
        Phrase.Size : "Størrelse",
        Phrase.Results : "Resultater",
        Phrase.Availability : "Tilgængelighed",
        Phrase.Search : "Søg",
        Phrase.Network : "Netværk",
        Phrase.All : "Alle",
        Phrase.Send : "Send",
        Phrase.User : "Bruger",
        Phrase.Add : "Tilføj",
        Phrase.Yes : "Ja",
        Phrase.No : "Nej"
    ];

    static char[][Phrase.max+1] dutch_dict =
    [
        Phrase.Nil : " ",
        Phrase.Servers : "Servers",
        Phrase.Clients : "Cliënten",
        Phrase.Searches : "Zoekopdrachten",
        Phrase.PageRefresh : "Pagina Verversing",
        Phrase.AddLinks : "Koppelingen",
        Phrase.Uploads : "Uploads",
        Phrase.password : "Wachtwoord",
        Phrase.Name : "Naam",
        Phrase.State : "Status",
        Phrase.Speed : "Snelheid",
        Phrase.Downloaded : "Gedownload",
        Phrase.Uploaded : "Geupload",
        Phrase.Priority : "Prioriteit",
        Phrase.Users : "Gebruikers",
        Phrase.Percent : "%",
        Phrase.ETA : "Rest. tijd",
        Phrase.Files : "Bestanden",
        Phrase.IP_Address : "IP Adres",
        Phrase.Last_Seen : "Laatst Gezien",
        Phrase.Networks : "Netwerken",
        Phrase.Connect : "Verbind",
        Phrase.Disconnect : "Verbreek verbinding",
        Phrase.Remove : "Verwijder",
        Phrase.Cancel : "Annuleren",
        Phrase.Pause : "Pauzeer",
        Phrase.Resume : "Hervat",
        Phrase.Rename : "Hernoem",
        Phrase.Commit : "Doorvoeren",
        Phrase.Size : "Grootte",
        Phrase.Results : "Resultaten",
        Phrase.Availability : "Beschikbaarheid",
        Phrase.Search : "Zoek",
        Phrase.Network : "Netwerk",
        Phrase.All : "Allen",
        Phrase.User : "Gebruiker",
        Phrase.Add : "Vriend",
        Phrase.Yes : "Ja",
        Phrase.No : "Nee"
    ];

    static char[][Phrase.max+1] swedish_dict =
    [
        Phrase.Nil : " ",
        Phrase.Servers : "Servers",
        Phrase.Clients : "Klienter",
        Phrase.Searches : "Sökningar",
        Phrase.PageRefresh : "Uppdatering av sida",
        Phrase.AddLinks : "Länkar",
        Phrase.Uploads : "Uppladdningar",
        Phrase.password : "Lösenord",
        Phrase.Name : "Namn",
        Phrase.State : "Status",
        Phrase.Speed : "Hastighet",
        Phrase.Downloaded : "Nerladdad",
        Phrase.Uploaded : "Uppladdat",
        Phrase.Priority : "Prioritet",
        Phrase.Users : "Användare",
        Phrase.Percent : "%",
        Phrase.ETA : "TTA",
        Phrase.Files : "Filer",
        Phrase.IP_Address : "IP Adress",
        Phrase.Last_Seen : "Senast Sedd",
        Phrase.Networks : "Nätverker",
        Phrase.Connect : "Koppla upp",
        Phrase.Disconnect : "Avbryt",
        Phrase.Remove : "Radera",
        Phrase.Cancel : "Annullera",
        Phrase.Pause : "Pause",
        Phrase.Resume : "Återuppta",
        Phrase.Rename : "Döp om",
        Phrase.Commit : "Överlämna",
        Phrase.Size : "Storlek",
        Phrase.Results : "Sökresultat",
        Phrase.Availability : "Tillgänglighet",
        Phrase.Search : "Sök",
        Phrase.Network : "Nätverk",
        Phrase.All : "Alla",
        Phrase.User : "Användare",
        Phrase.Yes : "Ja",
        Phrase.No : "Nej"
    ];

    static char[][Phrase.max+1] french_dict =
    [
        Phrase.Nil : " ",

        /*module names*/
        Phrase.Core : "Centre",
        Phrase.Titlebar : "Barre De Navigation",
        Phrase.FileBrowser : "Fichier Browser",
        Phrase.Downloads : "Téléchargements",
        Phrase.Servers : "Serveurs",
        Phrase.Clients : "Clients",
        Phrase.Console : "Console",
        Phrase.Searches : "Recherches",
        Phrase.PageRefresh : "Actualiser la Page",
        Phrase.UserManagement : "Administrateur de l'Utilisation",
        Phrase.UserSettings : "Paramètres de l'utilisation",
        Phrase.ModuleSettings : "Paramètres du Module",
        Phrase.ClientSettings : "Paramètres des Clients",
        Phrase.Container : "Container",
        Phrase.AddLinks : "Liens",
        Phrase.QuickConnect : "Connection Rapide",
        Phrase.Uploads : "Téléchargements",
        Phrase.Translator : "Traduction",

        /*languages*/
        Phrase.English : "Anglais",
        Phrase.German : "Allemand",
        Phrase.Spanish : "Espagnol",
        Phrase.Polish : "Polonais",
        Phrase.Galician : "Galicien",
        Phrase.Brazilian_Portuguese : "Portuguais Brésilien",
        Phrase.Danish : "Danois",
        Phrase.Dutch : "Hollandais",
        Phrase.Swedish : "Suédois",
        Phrase.French : "Français",
        Phrase.Italian : "Italien",
        Phrase.Turkish : "Turc",
        
        Phrase.Default_Titlebar : "Défaut",
        Phrase.Icon_Titlebar : "Icônes",
        Phrase.Plain_Titlebar : "Plain",
        
        /*setting names*/
        Phrase.basic_auth : "Authentification de Base",
        Phrase.enable_ssl : "Activer SSL",
        Phrase.password : "Mot De Passe",
        Phrase.Home_Directory : "Répertoire de Base",
        Phrase.language : "Langue",
        Phrase.style : "Style",
        Phrase.design : "Design",
        Phrase.elements : "Éléments",
        Phrase.use_javascript : "Utiliser Javascript",
        Phrase.cmd_on_top : "Ligne de Commande en Haut",
        Phrase.content_source : "Source du Contenu",
        Phrase.reload_content : "Recharger le Contenu",
        Phrase.column_order : "Ordre de Colonnes",
        Phrase.show_columns : "Montrer les Colonnes",
        Phrase.allow_file_upload : "Autoriser Transfert de Données",
        Phrase.show_directories : "Montrer les Répertoires",
        Phrase.show_hidden_files : "Montrer les Données Cachées",
        Phrase.Number_of_Lines : "Quantité de Lignes",
        Phrase.Load_Modules : "Charger les Modules",
        Phrase.Unload_Modules : "Décharger les Modules",
        Phrase.default_interface : "Interface par Défaut",
        Phrase.show_description : "Montrer la Description",
        Phrase.auto_disconnect_clients : "Déconnecter Automatiquement les Clients",
        Phrase.show_help : "Montrer l'aide",
        Phrase.enable_sessions : "Activer la Session",
        Phrase.Size : "Taille",
        Phrase.Name : "Nom",
        Phrase.State : "État",
        Phrase.Speed : "Vitesse",
        Phrase.Downloaded : "Téléchargé",
        Phrase.Uploaded : "Fichiers Envoyés",
        Phrase.Priority : "Priorité",
        Phrase.Users : "Utilisateurs",
        Phrase.ETA : "ETA",
        Phrase.Percent : "Pourcentage",
        Phrase.Description : "Description",
        Phrase.Files : "Fichiers",
        Phrase.Flag : "Drapeaux",
        Phrase.IP_Address : "Adresse IP",
        Phrase.Action : "Action",
        Phrase.Last_Seen : "Dernier Vu",
        Phrase.Sources : "Sources",
        Phrase.Software : "Logiciel",
        Phrase.Chunks : "Paquets",
        Phrase.Networks : "Réseaux",
        Phrase.Connect : "Connecter",
        Phrase.Disconnect : "Déconnecter",
        Phrase.Block : "Bloquer",
        Phrase.Unblock : "Débloquer",
        Phrase.Remove : "Extraire",
        Phrase.Type : "type",
        Phrase.Delete : "supprimer",
        Phrase.Load_Torrent : "Charger Torrent",
        Phrase.Upload : "Transférer",
        Phrase.Directory : "Répertoire",
        Phrase.Upload_File : "Transférer Fichier",
        Phrase.No_Home_Directory : "Aucun Répertoire de Base",
        Phrase.Cancel : "Annuler",
        Phrase.Pause : "Pause",
        Phrase.Stop : "Arrêter",
        Phrase.Resume : "Reprendre",
        Phrase.Prioritize : "Choisir Priorité",
        Phrase.Rename : "Renommer",
        Phrase.Hide : "Cacher",
        Phrase.Preview : "Présentation",
        Phrase.No_Items_Found : "Aucune Information Trouvée.",
        Phrase.FileNames : "Noms des Fichiers",
        Phrase.SubFiles : "Sous-Dossiers",
        Phrase.Comments : "Commentaires",
        Phrase.Connected : "Connecté",
        Phrase.Disconnected : "Déconnecté",
        Phrase.Add_Owner : "Ajouter Utilisateur",
        Phrase.Auto : "Automatique",
        Phrase.None__empty : "Aucun",
        Phrase.Very_Low : "Très Bas",
        Phrase.Low : "Bas",
        Phrase.Normal : "Normal",
        Phrase.High : "Haut",
        Phrase.Very_High : "Très Haut",
        Phrase.Refresh : "actualiser",
        Phrase.Value : "valeur",
        Phrase.Save : "Sauver",
        Phrase.Apply : "Appliquer",
        Phrase.Text : "Texte",
        Phrase.Results : "Résultats",
        Phrase.Content_Type : "contenu type",
        Phrase.Availability : "disponibilité",
        Phrase.Search : "Recherche",
        Phrase.Keywords : "Mots-Clé",
        Phrase.Found : "Trouvé",
        Phrase.Actions : "Actions",
        Phrase.Not_Connected : "Non Connecté",
        Phrase.Network : "Réseau",
        Phrase.All : "Tout",
        Phrase.Program : "Programme",
        Phrase.Document : "Document",
        Phrase.Image : "Image",
        Phrase.Audio : "Audio",
        Phrase.Video : "Vidéo",
        Phrase.Archive : "Archive ",
        Phrase.Download : "Télécharger",
        Phrase.Format : "Format",
        Phrase.Nothing_found_yet : "Encore Rien Trouvé!",
        Phrase.Selected : "Sélectionné",
        Phrase.Select : "Sélectionner",
        Phrase.Shutdown : "Fermer",
        Phrase.Not_Available : "Non Disponible",
        Phrase.Not_Supported : "Non Soutenu!",
        Phrase.Send : "Envoyer",
        Phrase.Nothing_Selected : "Rien Sélectionné",
        Phrase.Categories : "Catégories",
        Phrase.User : "Utilisateur",
        Phrase.Modules : "Modules",
        Phrase.Not_Found : "Non Trouvé!",
        Phrase.Add : "Ajouter",
        Phrase.Set_Password : "Entrer Mot de Passe",
        Phrase.Load_Link : "Charger Lien",
        Phrase.Not_Tested : "Non Testé!",
        Phrase.Not_Working : "Ne marche pas!",
        Phrase.Really_Shutdown : "Voulez-vous Vraiment Fermer %s?",
        Phrase.Yes : "Oui",
        Phrase.No : "Non",
        Phrase.Show : "Montrer"
    ];

    static char[][Phrase.max+1] italian_dict =
    [
        Phrase.Nil : " ",

        /*module names*/
        Phrase.Core : "Nucleo (pragramma Centrale)",
        Phrase.Titlebar : "Barra dei Titoli",
        Phrase.FileBrowser : "Sfoglia File",
        Phrase.Downloads : "Downloads",
        Phrase.Servers : "Servers",
        Phrase.Clients : "Clients",
        Phrase.Console : "Console",
        Phrase.Searches : "Ricerche",
        Phrase.PageRefresh : "Aggiorna Pagina",
        Phrase.UserManagement : "Gestione Utente",
        Phrase.UserSettings : "Impostazioni Utente",
        Phrase.ModuleSettings : "Impostazioni Moduli",
        Phrase.ClientSettings : "Impostazioni Client",
        Phrase.Container : "Archivio",
        Phrase.AddLinks : "Links",
        Phrase.QuickConnect : "Connessione Veloce",
        Phrase.Uploads : "Uploads",
        Phrase.Translator : "Traduttore",
        Phrase.Logout : "Esci",

        /*languages*/
        Phrase.English : "Inglese",
        Phrase.German : "Tedesco",
        Phrase.Spanish : "Spagnolo",
        Phrase.Polish : "Polacco",
        Phrase.Galician : "Galiziano",
        Phrase.Brazilian_Portuguese : "Brasiliano Portoghese",
        Phrase.Danish : "Danese",
        Phrase.Dutch : "Olandese",
        Phrase.Swedish : "Svedese",
        Phrase.French : "Francese",
        Phrase.Italian : "Italiano",
        Phrase.Turkish : "Turco",

        /*setting names*/
        Phrase.Default_Titlebar : "Default",
        Phrase.Icon_Titlebar : "Icone",
        Phrase.Plain_Titlebar : "Semplice",
        
        /*setting names*/
        Phrase.basic_auth : "Identificazione di Base",
        Phrase.enable_ssl : "Abilita SSL",
        Phrase.password : "Password",
        Phrase.Home_Directory : "Directory Principale",
        Phrase.language : "Lingua",
        Phrase.style : "Stile",
        Phrase.design : "Design",
        Phrase.elements : "Elementi",
        Phrase.use_javascript : "Usa Javascript",
        Phrase.min_refresh : "Refresh Minimo",
        Phrase.cmd_on_top : "Linea di Comando in Alto",
        Phrase.content_source : "Fonte del Contenuto",
        Phrase.reload_content : "Recarica Contenuto",
        Phrase.column_order : "Ordina colonna",
        Phrase.show_columns : "Mostra Colonne",
        Phrase.allow_file_upload : "Permetti Upload File",
        Phrase.show_directories : "Mostra Percorsi",
        Phrase.show_hidden_files : "Mostra Files Nascosti",
        Phrase.Number_of_Lines : "Barra delle file",
        Phrase.Load_Modules : "Carica Moduli",
        Phrase.Unload_Modules : "Scarica (unload) Moduli",
        Phrase.default_interface : "Interfaccia di Default",
        Phrase.show_description : "Mostra Descrizione",
        Phrase.auto_disconnect_clients : "Disconnetti Automaticamente Clients",
        Phrase.show_help : "Mostra Aiuto",
        Phrase.enable_sessions : "Abilita Sessioni",
        Phrase.show_percent_bar : "Mostra Barra Percentuale",
        Phrase.enable_row_colors : "Abilita Fila dei Colori",
        Phrase.Disable_Account : "Disabilita Account",
        Phrase.Exit_Program : "Esci dal Programma",
        Phrase.enable_rotX : "Abilita ROT-X",
        Phrase.enable_l33t : "Abilita l33t",

        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Size : "Dimensione",
        Phrase.Name : "Nome",
        Phrase.State : "Stato",
        Phrase.Speed : "Velocità",
        Phrase.UploadRate : "Velocità di Upload",
        Phrase.DownloadRate : "Velocità di Download",
        Phrase.Downloaded : "Scaricato",
        Phrase.Uploaded : "Inviato",
        Phrase.Priority : "Priorità",
        Phrase.Users : "Utenti",
        Phrase.Check : "[x]",
        Phrase.ETA : "ETA",
        Phrase.Percent : "Percentuale",
        Phrase.Description : "Descrizione",
        Phrase.Files : "Files",
        Phrase.Flag : "Bandiera", //Nazionalità
        Phrase.IP_Address : "Indirizzo IP",
        Phrase.Host : "Host",
        Phrase.Port : "Porta",
        Phrase.Action : "Azione",
        Phrase.Last_Seen : "Ultimo Contatto",
        Phrase.Sources : "Fonti",
        Phrase.Software : "Software",
        Phrase.Hash : "Hash",
        Phrase.Chunks : "Chunks",
        Phrase.Networks : "Reti",
        Phrase.Ping : "Ping",
        Phrase.Filename : "Nome File",

        /*file states*/
        Phrase.Active : "Attivo",
        Phrase.Paused : "In Pausa",
        Phrase.Stopped : "Stoppato",
        Phrase.Complete : "Completo",
        Phrase.Process : "Processo",

        Phrase.Default_Titlebar : "Predefinito",
        Phrase.Icon_Titlebar : "Icone",
        Phrase.Plain_Titlebar : "Semplice",

        /*Servers*/
        Phrase.Connect : "Connetti",
        Phrase.Disconnect : "Disconnetti",
        Phrase.Block : "Blocca",
        Phrase.Unblock : "Sblocca",
        Phrase.Remove : "Rimuovi",

        /*File Browser*/
        Phrase.Delete : "Cancella",
        Phrase.Type : "Tipo",
        Phrase.Load_Torrent : "Load Torrent",
        Phrase.Upload : "Upload",
        Phrase.Directory : "Directory",
        Phrase.Upload_File : "Upload File",
        Phrase.No_Home_Directory : "Nessuna Home Directory",

        /*Downloads*/
        Phrase.Cancel : "Cancella",
        Phrase.Pause : "Pausa",
        Phrase.Stop : "Stop",
        Phrase.Resume : "Riavvia",
        Phrase.Prioritize : "Imposta Priorità",
        Phrase.Rename : "Rinomina",
        Phrase.Hide : "Nascondi",
        Phrase.Preview : "Anteprima",
        Phrase.No_Items_Found : "Nessun Oggetto Trovato",
        Phrase.Commit : "Archivia",
        Phrase.FileNames : "Nomi File",
        Phrase.SubFiles : "Subfiles",
        Phrase.Comments : "Commenti",
        Phrase.Connecting : "In Connessione",
        Phrase.Connected : "Connesso",
        Phrase.Disconnected : "Disconnesso",
        Phrase.Blocked : "Bloccato",
        Phrase.Add_Owner : "Aggingi Propietario",
        Phrase.Invert : "Inverti",
        Phrase.Range : "Range (Da -> A)",
        Phrase.Refreshing_every_x_seconds : "Aggiorna ogni {} secondi.",

        /*for priorities*/
        Phrase.Auto : "Auto",
        Phrase.None__empty : "Nessuna",
        Phrase.Very_Low : "Bassissima",
        Phrase.Low : "Bassa",
        Phrase.Normal : "Normale",
        Phrase.High : "Alta",
        Phrase.Very_High : "Altissima",

        /*Page Refresh*/
        Phrase.Refresh : "Aggiorna",

        /*Settings*/
        Phrase.Value : "Valore",
        Phrase.Save : "Salva",
        Phrase.Apply : "Applica",

        /*Searches*/
        Phrase.Text : "Text",
        Phrase.Results : "Risultati",
        Phrase.Content_Type : "Tipo Contenuto",
        Phrase.Availability : "Disponibilità",
        Phrase.Search : "Cerca",
        Phrase.Keywords : "Parole Chiave",
        Phrase.Found : "Trovato",
        Phrase.Actions : "Azione",
        Phrase.Not_Connected : "Non Connesso",
        Phrase.Network : "Rete",
        Phrase.All : "Tutto",
        Phrase.Program : "Programma",
        Phrase.Document : "Documento",
        Phrase.Image : "Immagine",
        Phrase.Audio : "Audio",
        Phrase.Video : "Video",
        Phrase.Archive : "Archivio",
        Phrase.Download : "Download",
        Phrase.Format : "Formato",
        Phrase.Nothing_found_yet : "Non Ancora Trovato!",

        /*Clients*/
        Phrase.Selected : "Selezionato",
        Phrase.Select : "Seleziona",
        Phrase.Shutdown : "Spengi",
        Phrase.Password : "Password",

        /*Console*/
        Phrase.Not_Available : "Non Disponibile!",
        Phrase.Not_Supported : "Non Supportato!",
        Phrase.Send : "Inviato",

        /*Module Settings*/
        Phrase.Nothing_Selected : "Nessuna Scelta",
        Phrase.Categories : "Categoria",
        Phrase.User : "Utente",
        Phrase.Modules : "Moduli",

        /*Client Settings*/
        Phrase.Not_Found : "Non Trovato!",

        /*User Management*/
        Phrase.Add : "Aggiungi",
        Phrase.Set_Password : "Imposta Password",

        /*Links*/
        Phrase.Load_Link : "Carcia Link",

        /*misc. comments*/
        Phrase.Not_Tested : "Non Testato!",
        Phrase.Not_Working : "Non Funzionante!",

        /*Shutdown*/
        Phrase.Really_Shutdown : "Vuoi Realmente Spengere?",
        Phrase.Yes : "Si",
        Phrase.No : "No",

        /*Translator*/
        Phrase.Show : "Mostra"

        /*Client Settings*/
        Phrase.download_dir__setting: "Cartella download";
        Phrase.peer_limit__setting: "Limite peer";
        Phrase.port__setting: "Porta";
        Phrase.port_forwarding_enabled__setting: "Port forwarding attivo";
        Phrase.speed_limit_down__setting: "Limite velocità download";
        Phrase.speed_limit_up__setting: "Limite velocità upload";
        Phrase.Preview_Directory__setting: "Cartella anteprima";
    ];

    static char[][Phrase.max+1] turkish_dict =
    [
        Phrase.Nil : " ", //not empty! Empty strings are considered not to be set!
        
        /*module names*/
        Phrase.Core : "Çekirdek",
        Phrase.Titlebar : "Başlık çubuğu",
        Phrase.FileBrowser : "Dosya tarayıcısı",
        Phrase.Downloads : "İndirilenler",
        Phrase.Servers : "Sunucular",
        Phrase.Clients : "İstemciler",
        Phrase.Console : "Konsol",
        Phrase.Searches : "Aramalar",
        Phrase.PageRefresh : "Sayfa Yenile",
        Phrase.UserManagement : "Kullanıcı Yönetimi",
        Phrase.UserSettings : "Kullanıcı Ayarları",
        Phrase.ModuleSettings : "Modül Ayarları",
        Phrase.ClientSettings : "İstemci Ayarları",
        Phrase.Container : "Konteyner",
        Phrase.AddLinks : "Bağlantı Ekle",
        Phrase.QuickConnect : "Hızlı Bağlantı",
        Phrase.Uploads : "Yükelemeler",
        Phrase.Translator : "Çevirmen",
        Phrase.Logout : "Çıkış",
        
        /*languages*/
        Phrase.English : "İngilizce",
        Phrase.German : "Almanca",
        Phrase.Spanish : "İspanyolca",
        Phrase.Polish : "Lehçe",
        Phrase.Galician : "Galiçyaca",
        Phrase.Brazilian_Portuguese : "Brezilya Portekizcesi",
        Phrase.Danish : "Danca (Danimarka)",
        Phrase.Dutch : "Flemenkçe",
        Phrase.Swedish : "İsveççe",
        Phrase.French : "Fransızca",
        Phrase.Italian : "İtalyanca",
        Phrase.Turkish : "Türkçe",
        
        /*setting names*/
        Phrase.basic_auth : "Temel Kimlik Doğrulaması"
        Phrase.enable_ssl : "SSL'yi etkinleştir"
        Phrase.password : "Parola"
        Phrase.Home_Directory : "Ana Dizin"
        Phrase.language : "Dil"
        Phrase.style : "Stil"
        Phrase.design : "Tasarım"
        Phrase.elements : "Elementler"
        Phrase.use_javascript : "Javascript Kullan"
        Phrase.min_refresh : "Min Yenileme"
        Phrase.cmd_on_top : "Komut Satırı Üstte"
        Phrase.content_source : "İçerik Kaynağı"
        Phrase.reload_content : "İçeriği Yeniden Yükle"
        Phrase.column_order : "Sütun Sırası"
        Phrase.show_columns : "Sütunları Göster"
        Phrase.allow_file_upload : "Dosya Yüklemeye İzin Ver"
        Phrase.show_directories : "Dizinleri Göster"
        Phrase.show_hidden_files : "Gizli Dosyaları Göster"
        Phrase.Number_of_Lines : "Satır Sayısı"
        Phrase.Load_Modules : "Modülleri Yükle"
        Phrase.Unload_Modules : "Modülleri Kaldır"
        Phrase.default_interface : "Varsayılan Arayüz"
        Phrase.show_description : "Açıklamayı Göster"
        Phrase.auto_disconnect_clients : "İstemcileri Otomatik Kes"
        Phrase.show_help : "Yardımı Göster"
        Phrase.enable_sessions : "Oturumları Etkinleştir"
        Phrase.show_percent_bar : "Yüzde Çubuğunu Göster"
        Phrase.enable_row_colors : "Satır Renklerini Etkinleştir"
        Phrase.Disable_Account : "Hesabı Devre Dışı Bırak"
        Phrase.Exit_Program : "Programdan Çık"
        Phrase.enable_rotX : "ROT-X'i Etkinleştir"
        Phrase.enable_l33t : "l33t'i Etkinleştir"

        /*download/server table headers names*/
        Phrase.Id : "Kimlik"
        Phrase.Size : "Boyut"
        Phrase.Name : "Adı"
        Phrase.State : "Durum"
        Phrase.Speed : "Hız"
        Phrase.UploadRate : "Yükleme Hızı"
        Phrase.DownloadRate : "İndirme Hızı"
        Phrase.Downloaded : "İndirilen"
        Phrase.Uploaded : "Yüklenen"
        Phrase.Priority : "Öncelik"
        Phrase.Users : "Kullanıcılar"
        Phrase.Check : "[x]"
        Phrase.ETA : "Kalan Süre"
        Phrase.Percent : "Yüzde"
        Phrase.Description : "Açıklama"
        Phrase.Files : "Dosyalar"
        Phrase.Flag : "İşaret"
        Phrase.IP_Address : "IP Adresi"
        Phrase.Host : "Sunucu"
        Phrase.Port : "Port"
        Phrase.Action : "İşlem"
        Phrase.Last_Seen : "Son Görülme"
        Phrase.Sources : "Kaynaklar"
        Phrase.Software : "Yazılım"
        Phrase.Hash : "Hash"
        Phrase.Chunks : "Parçalar"
        Phrase.Networks : "Ağlar"
        Phrase.Ping : "Ping"
        Phrase.Filename : "Dosya Adı"
        
        /*file states*/
        Phrase.Active : "Aktif",
        Phrase.Paused : "Duraklatıldı",
        Phrase.Stopped : "Durduruldu",
        Phrase.Complete : "Tamamlandı",
        Phrase.Process : "İşleniyor",
        
        Phrase.Default_Titlebar : "Varsayılan",
        Phrase.Icon_Titlebar : "Simgeli",
        Phrase.Plain_Titlebar : "Sade",
        
        /*Servers*/
        Phrase.Connect : "Bağlan",
        Phrase.Disconnect : "Bağlantıyı Kes",
        Phrase.Block : "Engelle",
        Phrase.Unblock : "Engelini Kaldır",
        Phrase.Remove : "Kaldır",
        
        /*File Browser*/
        Phrase.Delete: "Sil";
        Phrase.Type: "Tür";
        Phrase.Load_Torrent: "Torrent Yükle";
        Phrase.Upload: "Yükle";
        Phrase.Directory: "Dizin";
        Phrase.Upload_File: "Dosya Yükle";
        Phrase.No_Home_Directory: "Ana Dizin Yok";
        
        /*Downloads*/
        Phrase.Cancel: "İptal";
        Phrase.Pause: "Duraklat";
        Phrase.Stop: "Durdur";
        Phrase.Resume: "Devam Et";
        Phrase.Prioritize: "Önceliklendir";
        Phrase.Rename: "Adlandır";
        Phrase.Hide: "Gizle";
        Phrase.Preview: "Önizleme";
        Phrase.No_Items_Found: "Hiç öğe bulunamadı.";
        Phrase.Commit: "Onayla";
        Phrase.FileNames: "Dosya Adları";
        Phrase.SubFiles: "Alt Dosyalar";
        Phrase.Comments: "Yorumlar";
        Phrase.Connecting: "Bağlanıyor";
        Phrase.Connected: "Bağlandı";
        Phrase.Disconnected: "Bağlantı Kesildi";
        Phrase.Blocked: "Engellendi";
        Phrase.Add_Owner: "Sahip Ekله";
        Phrase.Invert: "Ters Çevir";
        Phrase.Range: "Aralık";
        Phrase.Refreshing_every_x_seconds: "Her {} saniyede yenileniyor.";
        
        /*for priorities*/
        Phrase.Auto: "Otomatik";
        Phrase.None__empty: "Yok";
        Phrase.None__priority: "Yok";
        Phrase.Very_Low: "Çok Düşük";
        Phrase.Low: "Düşük";
        Phrase.Normal: "Normal";
        Phrase.High: "Yüksek";
        Phrase.Very_High: "Çok Yüksek";
        
        /*Page Refresh*/
        Phrase.Refresh: "Yenile";
        
        /*Settings*/
        Phrase.Value: "Değer";
        Phrase.Save: "Kaydet";
        Phrase.Apply: "Uygula";
        
        /*Searches*/
        Phrase.Text: "Metin";
        Phrase.Results: "Sonuçlar";
        Phrase.Content_Type: "İçerik Türü";
        Phrase.Availability: "Kullanılabilirlik";
        Phrase.Search: "Ara";
        Phrase.Keywords: "Anahtar Kelimeler";
        Phrase.Found: "Bulunan";
        Phrase.Actions: "İşlemler";
        Phrase.Not_Connected: "Bağlı Değil";
        Phrase.Network: "Ağ";
        Phrase.All: "Tümü";
        Phrase.Program: "Program";
        Phrase.Document: "Belge";
        Phrase.Image: "Resim";
        Phrase.Audio: "Ses";
        Phrase.Video: "Video";
        Phrase.Archive: "Arşiv";
        Phrase.Download: "İndir";
        Phrase.Format: "Biçim";
        Phrase.Nothing_found_yet: "Henüz bir şey bulunamadı!";
        
        /*Clients*/
        Phrase.Selected: "Seçili";
        Phrase.Select: "Seç";
        Phrase.Shutdown: "Kapat";
        Phrase.Password: "Parola";
        
        /*Console*/
        Phrase.Not_Available: "Kullanılamaz!";
        Phrase.Not_Supported: "Desteklenmiyor!";
        Phrase.Send: "Gönder";
        
        /*Module Settings*/
        Phrase.Nothing_Selected: "Hiçbir Şey Seçili Değil";
        Phrase.Categories: "Kategoriler";
        Phrase.User: "Kullanıcı";
        Phrase.Modules: "Modüller";
        
        /*Client Settings*/
        Phrase.Not_Found: "Bulunamadı!";
        
        /*User Management*/
        Phrase.Add: "Ekle";
        Phrase.Set_Password: "Parola Belirle";
        
        /*Links*/
        Phrase.Load_Link: "Bağlantı Yükle";
        
        /*misc. comments*/
        Phrase.Not_Tested: "Test Edilmedi!";
        Phrase.Not_Working: "Çalışmıyor!";
        
        /*Shutdown*/
        Phrase.Really_Shutdown: "%s gerçekten kapatmak istiyor musunuz?";
        Phrase.Yes: "Evet";
        Phrase.No: "Hayır";
        
        /*Translator*/
        Phrase.Show: "Göster";
        
        /*Client Settings*/
        Phrase.download_dir__setting: "İndirme Dizini";
        Phrase.peer_limit__setting: "Eş Limiti";
        Phrase.port__setting: "Port";
        Phrase.port_forwarding_enabled__setting: "Port Yönlendirme Etkin";
        Phrase.speed_limit_down__setting: "İndirme Hız Limiti";
        Phrase.speed_limit_up__setting: "Yükleme Hız Limiti";
        Phrase.Preview_Directory__setting: "Önizleme Dizini";
    ];

    static ushort toId(char[] str)
    {
        foreach(id, string; string_dict)
        {
            if(string == str) return id;
        }
        return 0;
    }
    
    static char[] toString(ushort id)
    {
        return (id < string_dict.length) ? string_dict[id] : null;
    }

    /*
    * String represetation of enum names.
    *
    * Needed for:
    * - to print out source code for new translations (HtmlTranslator.d)
    * - to have human readable names for stored settings (e.g. json)
    */
    static const char[][Phrase.max+1] string_dict =
    [
        Phrase.Nil : "Nil",

        /*module names*/
        Phrase.Core : "Core",
        Phrase.Titlebar : "Titlebar",
        Phrase.FileBrowser : "FileBrowser",
        Phrase.Downloads : "Downloads",
        Phrase.Servers : "Servers",
        Phrase.Clients : "Clients",
        Phrase.Console : "Console",
        Phrase.Searches : "Searches",
        Phrase.PageRefresh : "PageRefresh",
        Phrase.UserManagement : "UserManagement",
        Phrase.UserSettings : "UserSettings",
        Phrase.ModuleSettings : "ModuleSettings",
        Phrase.ClientSettings : "ClientSettings",
        Phrase.Container : "Container",
        Phrase.AddLinks : "Links",
        Phrase.QuickConnect : "QuickConnect",
        Phrase.Uploads : "Uploads",
        Phrase.Translator : "Translator",
        Phrase.Logout : "Logout",

        /*languages*/
        Phrase.English : "English",
        Phrase.German : "German",
        Phrase.Spanish : "Spanish",
        Phrase.Polish : "Polish",
        Phrase.Galician : "Galician",
        Phrase.Brazilian_Portuguese : "Brazilian_Portuguese",
        Phrase.Danish : "Danish",
        Phrase.Dutch : "Dutch",
        Phrase.Swedish : "Swedish",
        Phrase.French : "French",
        Phrase.Italian : "Italian",

        /*setting names*/
        Phrase.basic_auth : "basic_auth",
        Phrase.enable_ssl : "enable_ssl",
        Phrase.password : "password",
        Phrase.Home_Directory : "Home_Directory",
        Phrase.language : "language",
        Phrase.style : "style",
        Phrase.design : "design",
        Phrase.elements : "elements",
        Phrase.use_javascript : "use_javascript",
        Phrase.min_refresh : "min_refresh",
        Phrase.cmd_on_top : "cmd_on_top",
        Phrase.content_source : "content_source",
        Phrase.reload_content : "reload_content",
        Phrase.column_order : "column_order",
        Phrase.show_columns : "show_columns",
        Phrase.allow_file_upload : "allow_file_upload",
        Phrase.show_directories : "show_directories",
        Phrase.show_hidden_files : "show_hidden_files",
        Phrase.Number_of_Lines : "Number_of_Lines",
        Phrase.Load_Modules : "Load_Modules",
        Phrase.Unload_Modules : "Unload_Modules",
        Phrase.default_interface : "default_interface",
        Phrase.show_description : "show_description",
        Phrase.auto_disconnect_clients : "auto_disconnect_clients",
        Phrase.show_help : "show_help",
        Phrase.enable_sessions : "enable_sessions",
        Phrase.show_percent_bar : "show_percent_bar",
        Phrase.enable_row_colors : "enable_row_colors",
        Phrase.Disable_Account : "Disable_Account",
        Phrase.Exit_Program : "Exit_Program",
        Phrase.enable_rotX : "enable_rotX",
        Phrase.enable_l33t : "enable_l33t",

        /*download/server table headers names*/
        Phrase.Id : "Id",
        Phrase.Size : "Size",
        Phrase.Name : "Name",
        Phrase.State : "State",
        Phrase.Speed : "Speed",
        Phrase.UploadRate : "UploadRate",
        Phrase.DownloadRate : "DownloadRate",
        Phrase.Downloaded : "Downloaded",
        Phrase.Uploaded : "Uploaded",
        Phrase.Priority : "Priority",
        Phrase.Users : "Users",
        Phrase.Check : "Check",
        Phrase.ETA : "ETA",
        Phrase.Percent : "Percent",
        Phrase.Description : "Description",
        Phrase.Files : "Files",
        Phrase.Flag : "Flag",
        Phrase.IP_Address : "IP_Address",
        Phrase.Host : "Host",
        Phrase.Port : "Port",
        Phrase.Action : "Action",
        Phrase.Last_Seen : "Last_Seen",    
        Phrase.Sources : "Sources",
        Phrase.Software : "Software",
        Phrase.Hash : "Hash",
        Phrase.Chunks : "Chunks",
        Phrase.Networks : "Networks",
        Phrase.Ping : "Ping",
        Phrase.Filename : "Filename",

        /*file states*/
        Phrase.Active : "Active",
        Phrase.Paused : "Paused",
        Phrase.Stopped : "Stopped",
        Phrase.Complete : "Complete",
        Phrase.Process : "Process",

        Phrase.Default_Titlebar : "Default_Titlebar",
        Phrase.Icon_Titlebar : "Icon_Titlebar",
        Phrase.Plain_Titlebar : "Plain_Titlebar",

        /*Servers*/
        Phrase.Connect : "Connect",
        Phrase.Disconnect : "Disconnect",
        Phrase.Block : "Block",
        Phrase.Unblock : "Unblock",
        Phrase.Remove : "Remove",

        /*File Browser*/
        Phrase.Delete : "Delete",
        Phrase.Type : "Type",
        Phrase.Load_Torrent : "Load_Torrent",
        Phrase.Upload : "Upload",
        Phrase.Directory : "Directory",
        Phrase.Upload_File : "Upload_File",
        Phrase.No_Home_Directory : "No_Home_Directory",

        /*Downloads*/
        Phrase.Cancel : "Cancel",
        Phrase.Pause : "Pause",
        Phrase.Stop : "Stop",
        Phrase.Resume : "Resume",
        Phrase.Prioritize : "Prioritize",
        Phrase.Rename : "Rename",
        Phrase.Hide : "Hide",
        Phrase.Preview : "Preview",
        Phrase.No_Items_Found : "No_Items_Found",
        Phrase.Commit : "Commit",
        Phrase.FileNames : "FileNames",
        Phrase.SubFiles : "SubFiles",
        Phrase.Comments : "Comments",
        Phrase.Connecting : "Connecting",
        Phrase.Connected : "Connected",
        Phrase.Disconnected : "Disconnected",
        Phrase.Blocked : "Blocked",
        Phrase.Add_Owner : "Add_Owner",
        Phrase.Invert : "Invert",
        Phrase.Range : "Range",
        Phrase.Refreshing_every_x_seconds : "Refreshing_every_x_seconds",

        /*for priorities*/
        Phrase.Auto : "Auto",
        Phrase.None__empty : "None__empty",
        Phrase.None__priority : "None__priority",
        Phrase.Very_Low : "Very_Low",
        Phrase.Low : "Low",
        Phrase.Normal : "Normal",
        Phrase.High : "High",
        Phrase.Very_High : "Very_High",

        /*Page Refresh*/
        Phrase.Refresh : "Refresh",

        /*Settings*/
        Phrase.Value : "Value",
        Phrase.Save : "Save",
        Phrase.Apply : "Apply",

        /*Searches*/
        Phrase.Text : "Text",
        Phrase.Results : "Results",
        Phrase.Content_Type : "Content_Type",
        Phrase.Availability : "Availability",
        Phrase.Search : "Search",
        Phrase.Keywords : "Keywords",
        Phrase.Found : "Found",
        Phrase.Actions : "Actions",
        Phrase.Not_Connected : "Not_Connected",
        Phrase.Network : "Network",
        Phrase.All : "All",
        Phrase.Program : "Program",
        Phrase.Document : "Document",
        Phrase.Image : "Image",
        Phrase.Audio : "Audio",
        Phrase.Video : "Video",
        Phrase.Archive : "Archive",
        Phrase.Download : "Download",
        Phrase.Format : "Format",
        Phrase.Nothing_found_yet : "Nothing_found_yet",

        /*Clients*/
        Phrase.Selected : "Selected",
        Phrase.Select : "Select",
        Phrase.Shutdown : "Shutdown",
        Phrase.Password : "Password",

        /*Console*/
        Phrase.Not_Available : "Not_Available",
        Phrase.Not_Supported : "Not_Supported",
        Phrase.Send : "Send",

        /*Module Settings*/
        Phrase.Nothing_Selected : "Nothing_Selected",
        Phrase.Categories : "Categories",
        Phrase.User : "User",
        Phrase.Modules : "Modules",

        /*Client Settings*/
        Phrase.Not_Found : "Not_Found",

        /*User Management*/
        Phrase.Add : "Add",
        Phrase.Set_Password : "Set_Password",

        /*Links*/
        Phrase.Load_Link : "Load_Link",

        /*misc. comments*/
        Phrase.Not_Tested : "Not_Tested",
        Phrase.Not_Working : "Not_Working",

        /*Shutdown*/
        Phrase.Really_Shutdown : "Really_Shutdown",
        Phrase.Yes : "Yes",
        Phrase.No : "No",

        /*Translator*/
        Phrase.Show : "Show",

        /*Client Settings*/
        Phrase.download_dir__setting : "download_dir__setting",
        Phrase.peer_limit__setting : "peer_limit__setting",
        Phrase.port__setting : "port__setting",
        Phrase.port_forwarding_enabled__setting : "port_forwarding_enabled__setting",
        Phrase.speed_limit_down__setting : "speed_limit_down__setting",
        Phrase.speed_limit_up__setting : "speed_limit_up__setting",
        Phrase.Preview_Directory__setting : "Preview_Directory__setting"
    ];

} //end of struct Dictionary
