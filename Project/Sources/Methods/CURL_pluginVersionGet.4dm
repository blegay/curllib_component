//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_pluginVersionGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns curl plugin version (e.g. "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0")
  //@parameter[0-OUT-paramName-TEXT] : curl plugin version
  //@notes : value returned by "cURL Get version"
  //@example : CURL_pluginVersionGet => 
  // "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 15:56:40 - 1.00.08
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_curlPluginVersion)

  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
C_OBJECT:C1216($vo_curlVersion)
$vo_curlVersion:=cURL_VersionInfo 

  //C_TEXT($vt_curlVersionJson)
  //$vt_curlVersionJson:=cURL_VersionInfo 

  //  //ALERT($vt_curlVersionJson)

  //C_OBJECT($vo_curlVersion)
  //$vo_curlVersion:=JSON Parse($vt_curlVersionJson)
  //<Modif>

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

$vt_curlPluginVersion:="libcurl/"+$vo_curlVersion.version+\
" "+$vo_curlVersion.ssl_version+\
" zlib/"+$vo_curlVersion.libz_version+\
" "+$vo_curlVersion.libssh_version

  // "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0"

  //$vt_curlPluginVersion:=cURL Get version

$0:=$vt_curlPluginVersion