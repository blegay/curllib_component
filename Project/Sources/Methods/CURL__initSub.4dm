//%attributes = {"invisible":true,"shared":false}

//C_BOOLEAN(<>vb_CURL_useLogsSaveDebug)

//If (UTL__isMethod ("logs_save_debug"))
//<>vb_CURL_useLogsSaveDebug:=True
//Else 
//DBG__dbgInitAuto ("CURL__errHdlrToDevNull";-><>vt_CURL_dbgMethodName)
//End if 

//CURL__moduleDebugDateTimeLine (4;Current method name;"curl component version "+CURL_componentVersionGet +" inited...")

//C_TEXT($vt_curlVersion)

//C_TEXT($vt_curlVersionJson)
//$vt_curlVersionJson:=cURL_VersionInfo 
//C_OBJECT($vo_curlVersion)
//$vo_curlVersion:=JSON Parse($vt_curlVersionJson)
//$vt_curlVersion:=$vo_curlVersion.version


//If (False)
//  //   {
//  //      "features" : 2687645,
//  //      "host" : "Darwin",
//  //      "libssh_version" : "libssh2/1.8.0",
//  //      "libz_version" : "1.2.11",
//  //      "protocols" : [
//  //         "dict",
//  //         "file",
//  //         "ftp",
//  //         "ftps",
//  //         "gopher",
//  //         "http",
//  //         "https",
//  //         "imap",
//  //         "imaps",
//  //         "ldap",
//  //         "pop3",
//  //         "pop3s",
//  //         "rtsp",
//  //         "scp",
//  //         "sftp",
//  //         "smb",
//  //         "smbs",
//  //         "smtp",
//  //         "smtps",
//  //         "telnet",
//  //         "tftp"
//  //      ],
//  //      "ssl_version" : "OpenSSL/1.1.0g",
//  //      "ssl_version_num" : 0,
//  //      "version" : "7.62.0",
//  //      "version_num" : 474624
//  //   }

//End if 

//CURL__moduleDebugDateTimeLine (4;Current method name;"curl executable version "+$vt_curlVersion)


//ARRAY TEXT($tt_components;0)
//COMPONENT LIST($tt_components)

//<>vb_CURL__progressInstalled:=(Find in array($tt_components;"4D Progress")>0)

//CURL__headerCallbackInstall 
//CURL__progressCallbackInstall 
//CURL__debugCallbackInstall 

//  //<Modif> Bruno LEGAY (BLE) (18/09/2018) - v1.00.05
//CURL__debugInit 
//  //<Modif>

//ARRAY TEXT($tt_components;0)