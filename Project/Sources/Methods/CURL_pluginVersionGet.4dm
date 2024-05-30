//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_pluginVersionGet
//@scope : public
//@deprecated : no
//@description : This function returns curl plugin version as text (e.g. "cURL/4.7.1 libcurl/8.7.1 (SecureTransport) OpenSSL/3.3.0 zlib/1.2.11 libssh2/1.11.0")
//@parameter[0-OUT-paramName-TEXT] : curl plugin version
//@notes : value returned by "cURL Get version"
//@example : 
// CURL_pluginVersionGet => 
// "4.7.1 
//
// CURL_pluginVersionGet(true) => 
// "cURL/4.7.1 libcurl/8.7.1 (SecureTransport) OpenSSL/3.3.0 zlib/1.2.11 libssh2/1.11.0"
// "libcurl/8.4.0 (SecureTransport) OpenSSL/3.1.4 zlib/1.2.11 libssh2/1.11.0"
// "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0"
//@see : curl_pluginVersionInfo
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 15:56:40 - 1.00.08
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_curlPluginVersion)
C_BOOLEAN:C305($1; $vb_long)

If (Count parameters:C259=0)
	$vb_long:=False:C215
Else 
	$vb_long:=$1
End if 

//<Modif> Bruno LEGAY (BLE) (04/01/2022)
C_OBJECT:C1216($vo_curlVersion)
$vo_curlVersion:=curl_pluginVersionInfo

// SET TEXT TO PASTEBOARD(JSON Stringify($vo_curlVersion))

//C_TEXT($vt_curlVersionJson)
//$vt_curlVersionJson:=cURL_VersionInfo 

//  //ALERT($vt_curlVersionJson)

//C_OBJECT($vo_curlVersion)
//$vo_curlVersion:=JSON Parse($vt_curlVersionJson)
//<Modif>

If (False:C215)  // curl plugin v3 (v4.6.3) => crash 4D Server v19
	// {
	//     "version": "8.6.0",
	
End if 

If (False:C215)  // curl plugin v3 (v4.6.2)
	// {
	//     "version": "8.4.0",
	//     "version_num": 525312,
	//     "host": "x86_64-apple-darwin21.6.0",
	//     "features": 1441743773,
	//     "ssl_version": "(SecureTransport) OpenSSL/3.1.4",
	//     "libz_version": "1.2.11",
	//     "protocols": [
	//         "dict",
	//         "file",
	//         "ftp",
	//         "ftps",
	//         "gopher",
	//         "gophers",
	//         "http",
	//         "https",
	//         "imap",
	//         "imaps",
	//         "ldap",
	//         "ldaps",
	//         "mqtt",
	//         "pop3",
	//         "pop3s",
	//         "rtmp",
	//         "rtmpe",
	//         "rtmps",
	//         "rtmpt",
	//         "rtmpte",
	//         "rtmpts",
	//         "rtsp",
	//         "scp",
	//         "sftp",
	//         "smb",
	//         "smbs",
	//         "smtp",
	//         "smtps",
	//         "telnet",
	//         "tftp"
	//     ],
	//     "libssh_version": "libssh2/1.11.0",
	//     "brotli_version": "1.0.9",
	//     "nghttp2_version": "1.58.0",
	//     "zstd_version": "1.5.2"
	// }
End if 


If (False:C215)  // curl plugin v3 (v4.4.12)
	//  {
	//    "version":  "7.81.0",
	//    "version_num":  479488,
	//    "host":  "x86_64-apple-darwin18.7.0",
	//    "features":  368035741,
	//    "ssl_version":  "(SecureTransport)  OpenSSL/1.1.1m",
	//    "libz_version":  "1.2.11",
	//    "protocols":  [
	//      "dict",
	//      "file",
	//      "ftp",
	//      "ftps",
	//      "gopher",
	//      "gophers",
	//      "http",
	//      "https",
	//      "imap",
	//      "imaps",
	//      "ldap",
	//      "ldaps",
	//      "mqtt",
	//      "pop3",
	//      "pop3s",
	//      "rtmp",
	//      "rtsp",
	//      "scp",
	//      "sftp",
	//      "smb",
	//      "smbs",
	//      "smtp",
	//      "smtps",
	//      "telnet",
	//      "tftp"
	//    ],
	//    "libidn":  "2.3.2",
	//    "libssh_version":  "libssh2/1.10.0",
	//    "brotli_version":  "1.0.9",
	//    "nghttp2_version":  "1.46.0",
	//    "zstd_version":  "1.5.2"
	//  }
End if 

If (False:C215)  // curl plugin v3
	// {
	//      "version": "7.75.0",
	//      "version_num": 477952,
	//      "host": "x86_64-apple-darwin19.6.0",
	//      "features": 95012509,
	//      "ssl_version": "OpenSSL/1.1.1g",
	//      "libz_version": "1.2.11",
	//      "protocols": [
	//           "dict",
	//           "file",
	//           "ftp",
	//           "ftps",
	//           "gopher",
	//           "gophers",
	//           "http",
	//           "https",
	//           "imap",
	//           "imaps",
	//           "ldap",
	//           "ldaps",
	//           "mqtt",
	//           "pop3",
	//           "pop3s",
	//           "rtsp",
	//           "scp",
	//           "sftp",
	//           "smb",
	//           "smbs",
	//           "smtp",
	//           "smtps",
	//           "telnet",
	//           "tftp"
	//      ],
	//      "libidn": "2.3.0",
	//      "libssh_version": "libssh2/1.9.0",
	//      "brotli_version": "1.0.9",
	//      "nghttp2_version": "1.43.0",
	//      "zstd_version": "1.4.9"
	// }
	
End if 

If (False:C215)  // curl plugin v2
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
End if 

If ($vb_long)
	$vt_curlPluginVersion:=\
		"cURL/"+$vo_curlVersion.pluginVersion+\
		" libcurl/"+$vo_curlVersion.version+\
		" "+$vo_curlVersion.ssl_version+\
		" zlib/"+$vo_curlVersion.libz_version+\
		" "+$vo_curlVersion.libssh_version
	// "cURL/4.7.1 libcurl/8.7.1 (SecureTransport) OpenSSL/3.3.0 zlib/1.2.11 libssh2/1.11.0"
	// "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0"
Else 
	$vt_curlPluginVersion:=$vo_curlVersion.pluginVersion
	// "cURL/4.7.1"
End if 

$0:=$vt_curlPluginVersion