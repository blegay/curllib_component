//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__userAgent
//@scope : public
//@deprecated : no
//@description : This function returns a default user-agent string 
//@parameter[0-OUT-userAgent-TEXT] : default user-agent string
//@notes : 
//@example : CURL__userAgent => 
// "4D-curlComponent/2.00.05 (macOS 10.14.6 (18G103)) 4D/v17.4Final-build248004 libcurl/7.62.0 OpenSSL/1.1.0g zlib/1.2.11 libssh2/1.8.0"
// "4D-curlComponent/2.00.00 (macOS 10.12.6 (16G29)) 4D/v18.0Final-build246707 libcurl/7.62.0 OpenSSL/1.1.0g zlib/1.2.11 libssh2/1.8.0"
// "4D-curlComponent/1.01.00 (Macintosh; OS X version 10.9.5) 4D/v15.3Final-build205412 libcurl/7.40.0 OpenSSL/1.0.2k zlib/1.2.8 libidn/1.29 libssh2/1.8.0"
// "4D-curlComponent/4.01.04 (macOS 12.7.4 (21H1123)) 4D/v19.5Final-build283893 cURL/4.7.1 libcurl/8.7.1 (SecureTransport) OpenSSL/3.3.0 zlib/1.2.11 libssh2/1.11.0"
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:15:20 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_userAgent)

//<Modif> Bruno LEGAY (BLE) (09/04/2021) - v2.00.05
// cache the infos in Storage
If (Storage:C1525.curl.userAgent=Null:C1517)
	//<Modif>
	
	C_TEXT:C284($vt_4dVersion)
	$vt_4dVersion:=ENV_versionStr  //"4D v12.5 Final (Build 122263)" / "4D v18.0 Final (Build 246707)"
	$vt_4dVersion:=Substring:C12($vt_4dVersion; 4)  //"v12.5 Final (Build 122263)"
	$vt_4dVersion:=Replace string:C233($vt_4dVersion; " "; "")  //"v12.5Final(Build122263)"
	$vt_4dVersion:=Replace string:C233($vt_4dVersion; "(B"; "-b")  //"v12.5Final-build122263)"
	$vt_4dVersion:=Replace string:C233($vt_4dVersion; ")"; "")  //"v12.5Final-build122263"
	
	// "v18.0Final-build246707"
	
	C_TEXT:C284($vt_plateformeVersStr)
	$vt_plateformeVersStr:=ENV_plateformeStr  // "OS X version 10.8.5" "macOS 10.14.6 (18G103)"
	
	$vt_userAgent:="4D-curlComponent/"+CURL_componentVersionGet+" ("+$vt_plateformeVersStr+") 4D/"+$vt_4dVersion+" "+CURL_pluginVersionGet(True:C214)  //$vt_curlVersion
	
	//<Modif> Bruno LEGAY (BLE) (09/04/2021) - v2.00.05
	Use (Storage:C1525.curl)
		Storage:C1525.curl.userAgent:=$vt_userAgent
	End use 
	
Else 
	$vt_userAgent:=Storage:C1525.curl.userAgent
End if 
//<Modif>


//C_TEXT($vt_curlVersion)

//C_TEXT($vt_curlVersionJson)
//$vt_curlVersionJson:=cURL_VersionInfo 
//C_OBJECT($vo_curlVersion)
//$vo_curlVersion:=JSON Parse($vt_curlVersionJson)
//$vt_curlVersion:=$vo_curlVersion.version
//$vt_userAgent:="4D-curlComponent/"+CURL_componentVersionGet +" ("+$vt_plateformStr+"; "+$vt_plateformeVersStr+") 4D/"+$vt_4dVersion+" "+$vt_curlVersion

// 4D-curlComponent/1.01.00 (Macintosh; OS X version 10.9.5) 4D/v15.3Final-build205412 libcurl/7.40.0 OpenSSL/1.0.2k zlib/1.2.8 libidn/1.29 libssh2/1.8.0

// 4D-curlComponent/2.00.05 (macOS 10.14.6 (18G103)) 4D/v17.4Final-build248004 libcurl/7.62.0 OpenSSL/1.1.0g zlib/1.2.11 libssh2/1.8.0

$0:=$vt_userAgent