//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_pluginVersionGet
//@scope : public
//@deprecated : no
//@description : This function returns curl plugin version (e.g. "libcurl/7.81.0 OpenSSL/1.1.1m zlib/1.2.11 libssh2/1.10.0")
//@parameter[0-OUT-paramName-TEXT] : curl plugin version
//@notes : value returned by "cURL Get version"
// 4d-plugin-curl-v2 v3.7.1
//@example : CURL_pluginVersionGet => 
// "libcurl/7.62.0 OpenSSL/1.1.0g zlib/1.2.11 libssh2/1.8.0"
// "libcurl/7.81.0 OpenSSL/1.1.1m zlib/1.2.11 libssh2/1.10.0"
//@see : 
// https://github.com/miyako/4d-plugin-curl-v3
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 15:56:40 - 1.00.08
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_curlPluginVersion)

C_OBJECT:C1216($vo_curlVersion)
$vo_curlVersion:=cURL_VersionInfo
//   {
//      "features" : 2687645,
//      "host" : "Darwin",
//      "libssh_version" : "libssh2/1.8.0",
//      "libz_version" : "1.2.11",
//      "protocols" : [
//         "dict",
//         "file",
//         "ftp",
//         "ftps",
//         "gopher",
//         "http",
//         "https",
//         "imap",
//         "imaps",
//         "ldap",
//         "pop3",
//         "pop3s",
//         "rtsp",
//         "scp",
//         "sftp",
//         "smb",
//         "smbs",
//         "smtp",
//         "smtps",
//         "telnet",
//         "tftp"
//      ],
//      "ssl_version" : "OpenSSL/1.1.0g",
//      "ssl_version_num" : 0,
//      "version" : "7.62.0",
//      "version_num" : 474624
//   }


$vt_curlPluginVersion:="libcurl/"+$vo_curlVersion.version+\
" "+Replace string:C233($vo_curlVersion.ssl_version; "(SecureTransport) "; ""; *)+\
" zlib/"+$vo_curlVersion.libz_version+\
" "+$vo_curlVersion.libssh_version

//$vt_curlPluginVersion:=cURL Get version

$0:=$vt_curlPluginVersion