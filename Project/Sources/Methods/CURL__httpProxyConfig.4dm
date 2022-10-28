//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__httpProxyConfig
//@scope : public
//@deprecated : no
//@description : This method will configure the proxy
//@parameter[1-INOUT-curlOptions-OBJECT] : curl options object (modified)
//@parameter[3-IN-proxyAddress-TEXT] : proxy address (e.g. "myProxy.local" or "192.168.1.250")
//@parameter[4-IN-proxyPort-LONGINT] : proxy port (e.g. 8080)
//@parameter[5-IN-proxyLogin-TEXT] : proxy login (optional)
//@parameter[6-IN-proxyPassword-TEXT] : proxy password (optional)
//@notes : 
//@example : CURL__httpProxyConfig
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:27:35 - 1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_curlOptions)
C_TEXT:C284($2; $vt_proxyAddress)
C_LONGINT:C283($3; $vl_proxyPort)
C_TEXT:C284($4; $vt_proxyLogin)
C_TEXT:C284($5; $vt_proxyPassword)

ASSERT:C1129(Count parameters:C259>2; "requires 3 parameters")
//ASSERT(Type($1->)=LongInt array;"$1 should be a longint array pointer")
//ASSERT(Type($2->)=Text array;"$1 should be a text array pointer")
//ASSERT(Size of array($1->)=Size of array($2->);"$2-> and $2-> should be of same size")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	
	$vo_curlOptions:=$1
	$vt_proxyAddress:=$2
	$vl_proxyPort:=$3
	
	Case of 
		: ($vl_nbParam=3)
			$vt_proxyLogin:=""
			$vt_proxyPassword:=""
			
		: ($vl_nbParam=4)
			$vt_proxyLogin:=""
			$vt_proxyPassword:=""
			
		Else 
			//: ($vl_nbParam=5)
			$vt_proxyLogin:=$4
			$vt_proxyPassword:=$5
			
	End case 
	
	If ((Length:C16($vt_proxyAddress)>0) & ($vl_proxyPort>0))
		
		// https://curl.se/libcurl/c/CURLOPT_PROXY.html
		// configuration du proxy
		// Set the proxy to use for the upcoming request. 
		
		C_TEXT:C284($vt_proxyUrl)
		$vt_proxyUrl:="http://"+$vt_proxyAddress+":"+String:C10($vl_proxyPort)
		
		CURL__optionsObj($vo_curlOptions; "PROXY"; $vt_proxyUrl)
		CURL__moduleDebugDateTimeLine(6; Current method name:C684; "PROXY : \""+$vt_proxyUrl+"\"")
		//AJOUTER A TABLEAU($tl_keys;CURLOPT_PROXY)
		//AJOUTER A TABLEAU($tt_values;"http://"+$vt_proxyAddress+":"+Chaîne($vl_proxyPort))
		
		// https://curl.se/libcurl/c/CURLOPT_PROXYUSERPWD.html
		// configuration du login et mot de passe pour accéder au proxy
		// Set the login and password to use for the connection to the HTTP proxy. 
		// Both the name and the password will be URL decoded before use, so to include for example a colon in the user name you should encode it as %3A.
		If ((Length:C16($vt_proxyLogin)>0) & (Length:C16($vt_proxyPassword)>0))
			C_TEXT:C284($vt_loginPasswordCombined)
			$vt_loginPasswordCombined:=CURL__proxyLoginPasswordCombine($vt_proxyLogin; $vt_proxyPassword)
			CURL__optionsObj($vo_curlOptions; "PROXYUSERPWD"; $vt_loginPasswordCombined)
			
			//<Modif> Bruno LEGAY (BLE) (29/09/2017)
			CURL__moduleDebugDateTimeLine(6; Current method name:C684; "PROXYUSERPWD : \""+DBG_passwordDebug($vt_loginPasswordCombined)+"\"")
			//CURL__moduleDebugDateTimeLine (6;Nom méthode courante;"CURLOPT_PROXYUSERPWD : \""+$vt_loginPasswordCombined+"\"")
			//<Modif>
			
			
			//AJOUTER A TABLEAU($tl_keys;CURLOPT_PROXYUSERPWD)
			//AJOUTER A TABLEAU($tt_values;CURL__proxyLoginPasswordCombine ($vt_proxyLogin;$vt_proxyPassword))
		End if 
		
		C_BOOLEAN:C305($vb_tls)
		
		// always assume we will need a TLS connection
		// because the url can be "http://" but we may get a redirect (300) to a secured url "https://"
		
		$vb_tls:=True:C214  //(Sous chaîne($vt_url;1;8)="https://")  //($vt_url="https://@")
		
		// https://curl.se/libcurl/c/CURLOPT_HTTPPROXYTUNNEL.html
		// proxy vers une url en https => configuration du mode "TUNNEL" avec HTTP CONNECT
		// Set the tunnel parameter to 1L to make libcurl tunnel all operations through the HTTP proxy (set with CURLOPT_PROXY). 
		// There is a big difference between using a proxy and to tunnel through it.
		// Tunneling means that a HTTP CONNECT request is sent to the proxy, asking it to connect to a remote host on a specific port number 
		// and then the traffic is just passed through the proxy. 
		// Proxies tend to white-list specific port numbers it allows CONNECT requests to and often only port 80 and 443 are allowed.
		If ($vb_tls)
			CURL__optionsObjLong($vo_curlOptions; "HTTPPROXYTUNNEL"; 1)
			CURL__moduleDebugDateTimeLine(6; Current method name:C684; "HTTPPROXYTUNNEL : 1")
			//AJOUTER A TABLEAU($tl_keys;CURLOPT_HTTPPROXYTUNNEL)
			//AJOUTER A TABLEAU($tt_values;"1")
		End if 
		
	End if 
	
End if 
