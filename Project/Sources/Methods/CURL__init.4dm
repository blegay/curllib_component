//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
If (Not:C34(Bool:C1537(Storage:C1525.curl.init)))
	C_TEXT:C284($vt_prefDir)
	$vt_prefDir:=CURL__prefDirPathGet
	
	Use (Storage:C1525.curl)
		Storage:C1525.curl.init:=True:C214
		Storage:C1525.curl.prefsDirPath:=$vt_prefDir
		Storage:C1525.curl.caPath:=""
		Storage:C1525.curl.debugDirPath:=""
	End use 
	
	CURL_caRefresh
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "curl component version "+CURL_componentVersionGet+" inited...")
	
	
	C_OBJECT:C1216($vo_curlVersion)
	$vo_curlVersion:=cURL_VersionInfo
	// {version:8.4.0,version_num:525312,host:x86_64-apple-darwin21.6.0,features:1441743773,ssl_version:(SecureTransport) OpenSSL/3.1.4,libz_version:1.2.11,protocols:[dict,file,ftp,ftps,gopher,gophers,http,https,imap,imaps,ldap,ldaps,mqtt,pop3,pop3s,rtmp,rtmpe,rtmps,rtmpt,rtmpte,rtmpts,rtsp,scp,sftp,smb,smbs,smtp,smtps,telnet,tftp],libssh_version:libssh2/1.11.0,brotli_version:1.0.9,nghttp2_version:1.58.0,zstd_version:1.5.2...
	
	
	C_TEXT:C284($vt_curlVersion)
	$vt_curlVersion:=$vo_curlVersion.version
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "curl executable version : "+$vt_curlVersion+"\r"+JSON Stringify:C1217($vo_curlVersion; *))
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "curl infos :\r"+JSON Stringify:C1217(Storage:C1525.curl; *))
	
	If (False:C215)
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
	
End if 