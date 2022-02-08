//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_curlOptionsProxySet
  //@scope : public
  //@deprecated : no
  //@description : This method will set the proxy configuration parameters in the "option" object
  //@parameter[1-INOUT-optionPtr-POINTER] : option object pointer (modified)
  //@parameter[2-IN-proxyServer-TEXT] : proxy server (e.g. "myProxy.local" or "192.168.1.250")
  //@parameter[3-IN-proxyPort-LONGINT] : proxy port (e.g. 8080)
  //@parameter[4-IN-proxyLogin-TEXT] : login for proxy server (optional)
  //@parameter[5-IN-proxyPassword-TEXT] : password for proxy server (optional)
  //@notes : 
  //@example : CURL_curlOptionsProxySet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:55:33 - 1.00.00
  //@xdoc-end
  //================================================================================

ASSERT:C1129(Count parameters:C259>2;"requires 3 or more parameters")
  //ASSERT(Type($1->)=Is object;"$1-> should be an object pointer")

C_OBJECT:C1216($1;$vo_curlOptions)
C_TEXT:C284($2;$vt_proxyServer)
C_LONGINT:C283($3;$vl_proxyPort)
C_TEXT:C284($4;$vt_login)
C_TEXT:C284($5;$vt_password)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vo_curlOptions:=$1
	$vt_proxyServer:=$2
	$vl_proxyPort:=$3
	
	If ($vl_nbParam>4)
		$vt_login:=$4
		$vt_password:=$5
	End if 
	
	CURL__init 
	
	  // configuration du proxy
	  //ARRAY LONGINT($tl_keys;0)
	  //ARRAY TEXT($tt_values;0)
	
	CURL__httpProxyConfig ($vo_curlOptions;$vt_proxyServer;$vl_proxyPort;$vt_login;$vt_password)
	
	  //ARRAY OBJECT($to_options;0)
	  //If (OB Is defined($vp_optionPtr->;"curlOptions"))
	  //OB GET ARRAY($vp_optionPtr->;"curlOptions";$to_options)
	  //End if 
	
	  //C_OBJECT($vo_object)
	  //C_LONGINT($i)
	  //For ($i;1;Size of array($tl_keys))
	  //OB SET($vo_object;"key";$tl_keys{$i})
	  //OB SET($vo_object;"value";$tt_values{$i})
	
	  //APPEND TO ARRAY($to_options;$vo_object)
	  //CLEAR VARIABLE($vo_object)
	  //End for 
	  //OB SET ARRAY($vp_optionPtr->;"curlOptions";$to_options)
	
	  //ARRAY LONGINT($tl_keys;0)
	  //ARRAY TEXT($tt_values;0)
	
End if 
