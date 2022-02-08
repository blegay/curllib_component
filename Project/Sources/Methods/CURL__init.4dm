//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
  //UTL_initAuto (-><>vb_CURL_init;"CURL__compiler";"CURL__initSub")

If (Storage:C1525.curl=Null:C1517)
	
	C_BOOLEAN:C305($vb_useLogsSaveDebug)
	$vb_useLogsSaveDebug:=False:C215
	
	C_TEXT:C284($vt_dbgMethodName)
	$vt_dbgMethodName:=""
	
	C_BOOLEAN:C305($vb_isPreemptive)
	
	$vb_isPreemptive:=UTL_processIsPreemptive 
	
	  // NOTE : in a pre-emptive process we cannot detect if the method "logs_save_debug" exists
	  // we should assume it does not exists
	C_BOOLEAN:C305($vb_logsSaveDebugExists)
	If ($vb_isPreemptive)
		$vb_logsSaveDebugExists:=False:C215  // no way to know in a pre-emptive process if a method exists :-(
	Else 
		EXECUTE METHOD:C1007("UTL__isMethod";$vb_logsSaveDebugExists;"logs_save_debug")
		  // compiler directives don't work on methods/functions
		  //%T- 
		  //$vb_logsSaveDebugExists:=UTL__isMethod("logs_save_debug") 
		  //%T+
	End if 
	
	If ($vb_logsSaveDebugExists)
		  //If (UTL__isMethod ("logs_save_debug"))
		$vb_useLogsSaveDebug:=True:C214
	Else 
		DBG__dbgInitAuto ("CURL__errHdlrToDevNull";->$vt_dbgMethodName)
	End if 
	
	  // NOTE : in a pre-emptive process we cannot detect if the "4D Progress" component exists
	  // we should assume it is not installed
	C_BOOLEAN:C305($vb_progressComponentInstalled)
	If ($vb_isPreemptive)
		$vb_progressComponentInstalled:=False:C215
	Else 
		ARRAY TEXT:C222($tt_components;0)
		  //%T-  // no way to know in a pre-emptive process if a method exists :-(
		COMPONENT LIST:C1001($tt_components)
		  //%T+
		$vb_progressComponentInstalled:=(Find in array:C230($tt_components;"4D Progress")>0)
		ARRAY TEXT:C222($tt_components;0)
	End if 
	
	C_TEXT:C284($vt_prefDir)
	$vt_prefDir:=CURL__prefDirPathGet 
	
	Use (Storage:C1525)
		
		If (Not:C34(OB Is defined:C1231(Storage:C1525;"curl")))
			
			Storage:C1525.curl:=New shared object:C1526(\
				"init";False:C215)
			
		End if 
		
		Use (Storage:C1525.curl)
			Storage:C1525.curl.useLogsSaveDebug:=$vb_useLogsSaveDebug
			Storage:C1525.curl.dbgMethodName:=$vt_dbgMethodName
			Storage:C1525.curl.progressComponentInstalled:=$vb_progressComponentInstalled
			Storage:C1525.curl.prefsDirPath:=$vt_prefDir
			Storage:C1525.curl.caPath:=""
			Storage:C1525.curl.init:=True:C214
			  //<Modif> Bruno LEGAY (BLE) (12/01/2021)
			Storage:C1525.curl.debugDirPath:=""
			  //<Modif> 
		End use 
		
	End use 
	
	CURL_caRefresh 
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"curl component version "+CURL_componentVersionGet +" inited...")
	
	  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
	C_OBJECT:C1216($vo_curlVersion)
	$vo_curlVersion:=cURL_VersionInfo 
	
	C_TEXT:C284($vt_curlVersion)
	$vt_curlVersion:=$vo_curlVersion.version
	
	  //C_TEXT($vt_curlVersionJson;$vt_curlVersion)
	  //$vt_curlVersionJson:=cURL_VersionInfo ()
	
	  //C_OBJECT($vo_curlVersion)
	  //$vo_curlVersion:=JSON Parse($vt_curlVersionJson)
	
	  //$vt_curlVersion:=$vo_curlVersion.version
	  //<Modif>
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"curl executable version : "+$vt_curlVersion+"\r"+JSON Stringify:C1217($vo_curlVersion;*))
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"curl infos :\r"+JSON Stringify:C1217(Storage:C1525.curl;*))
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"curl version infos :\r"+JSON Stringify:C1217($vo_curlVersion;*))
	
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
	
End if 