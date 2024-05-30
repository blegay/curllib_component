//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : curl_pluginVersionInfo
//@scope : private 
//@deprecated : no
//@description : This function returns an object with plugin version info
//@parameter[0-OUT-curlVersionInfos-TEXT] : curl version infos object
//@notes : wrapper on cURL_VersionInfo + extracts plugin version from "Info.plist" file (adds .pluginVersion)
//@example : 
//
//  var $curlVersion: Object
//  $curlVersion:=curl_pluginVersionInfo
//  ALERT("curl plugin version : "+$curlVersion.pluginVersion+"\rcurl library version : "+$curlVersion.version)
//
// curl_pluginVersionInfo
// {
//   "version": "8.7.1",
//   "version_num": 526081,
//   "host": "x86_64-apple-darwin21.6.0",
//   "features": 1441743773,
//   "ssl_version": "(SecureTransport) OpenSSL/3.3.0",
//   "libz_version": "1.2.11",
//   "protocols": [
//     "dict",
//     "file",
//     "ftp",
//     "ftps",
//     "gopher",
//     "gophers",
//     "http",
//     "https",
//     "imap",
//     "imaps",
//     "ldap",
//     "ldaps",
//     "mqtt",
//     "pop3",
//     "pop3s",
//     "rtmp",
//     "rtmpe",
//     "rtmps",
//     "rtmpt",
//     "rtmpte",
//     "rtmpts",
//     "rtsp",
//     "scp",
//     "sftp",
//     "smb",
//     "smbs",
//     "smtp",
//     "smtps",
//     "telnet",
//     "tftp"
//   ],
//   "libssh_version": "libssh2/1.11.0",
//   "brotli_version": "1.0.9",
//   "nghttp2_version": "1.58.0",
//   "zstd_version": "1.5.2",
//   "pluginVersion": "4.7.1"
// }
//
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2024
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 30/05/2024, 09:54:38 - 4.01.05
//@xdoc-end
//================================================================================

#DECLARE()->$curlVersionInfos : Object

If (Storage:C1525.curl.pluginVersionInfo#Null:C1517)
	$curlVersionInfos:=Storage:C1525.curl.pluginVersionInfo
Else 
	
	$curlVersionInfos:=cURL_VersionInfo
	
	// add .pluginVersion to object
	If ($curlVersionInfos#Null:C1517)
		
		$curlVersionInfos.pluginVersion:=""
		
		var $pluginName : Text
		$pluginName:="cURL"
		
		var $pluginDir : 4D:C1709.Folder
		//$pluginDir:=Folder(Folder(fk resources folder).platformPath; fk platform path).parent.folder("Plugins")
		$pluginDir:=Folder:C1567(fk database folder:K87:14).folder("Plugins")
		If ($pluginDir.exists)
			
			var $curlPluginDir : 4D:C1709.Folder
			$curlPluginDir:=$pluginDir.folder($pluginName+".bundle")
			
			var $plistFile : 4D:C1709.File
			$plistFile:=$curlPluginDir.folder("Contents").file("Info.plist")
			If ($plistFile.exists)
				
				var $xmlBlob : Blob
				$xmlBlob:=$plistFile.getContent()
				
				var $domRootRef : Text
				$domRootRef:=DOM Parse XML variable:C720($xmlBlob)
				If (ok=1)
					// works if use "standard xpath"
					var $xpath : Text
					$xpath:="/plist/dict/key[text()='CFBundleShortVersionString']"
					
					var $domElementRef : Text
					$domElementRef:=DOM Find XML element:C864($domRootRef; $xpath)
					If (ok=1)
						var $name; $value : Text
						$domElementRef:=DOM Get next sibling XML element:C724($domElementRef; $name; $value)
						If (ok=1) & ($name="string")
							$curlVersionInfos.pluginVersion:=$value
						End if 
					End if 
					
					DOM CLOSE XML:C722($domRootRef)
				End if 
				
			End if 
			
		End if 
		
		//If (False)
		//SET TEXT TO PASTEBOARD(JSON Stringify($curlVersionInfos; *))
		//End if 
		
		// do not call CURL__moduleDebugDateTimeLine because dbg component may not be inited
		//CURL__moduleDebugDateTimeLine(4; Current method name; "version infos : "+JSON Stringify($curlVersionInfos))
	End if 
End if 
