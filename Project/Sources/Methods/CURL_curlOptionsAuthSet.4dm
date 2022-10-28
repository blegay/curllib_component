//%attributes = {"shared":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : CURL_curlOptionsAuthSet
//@scope : private 
//@attributes :    
//@deprecated : no
//@description : This method will set the auth parameters in a curl options object
//@parameter[1-INOUT-curlOptions-OBJECT] : curl options object
//@parameter[2-IN-login-TEXT] : login
//@parameter[3-IN-password-TEXT] : password
//@parameter[4-IN-auth-TEXT] : auth method
//@notes : 
// ("NONE", "BASIC", DIGEST", "NEGOTIATE", "NTLM", "DIGEST_IE", "NTLM_WB", "BEARER", "ONLY")
//@example : CURL_curlOptionsAuthSet
//@see : 
// https://github.com/curl/curl/blob/master/include/curl/curl.h
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 27/05/2020, 23:02:03 - 2.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_curlOptions)
C_TEXT:C284($2; $vt_login)
C_TEXT:C284($3; $vt_password)
C_TEXT:C284($4; $vt_authMethod)

ASSERT:C1129(Count parameters:C259>2; "requires 3 parameters")
//ASSERT(Type($1->)=Is object;"$1-> should be an object pointer")
ASSERT:C1129($1#Null:C1517; "$1/curlOptions object is null")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vo_curlOptions:=$1
	$vt_login:=$2
	$vt_password:=$3
	
	If ($vl_nbParam=2)
		$vt_authMethod:="BASIC"
	Else 
		$vt_authMethod:=$4
	End if 
	
	C_LONGINT:C283($vl_auth)
	Case of 
		: (($vt_authMethod="NONE") | ($vt_authMethod="CURLAUTH_NONE") | ($vt_authMethod=""))
			$vl_auth:=0
			
		: (($vt_authMethod="BASIC") | ($vt_authMethod="CURLAUTH_BASIC"))
			$vl_auth:=1
			
		: (($vt_authMethod="DIGEST") | ($vt_authMethod="CURLAUTH_DIGEST"))
			$vl_auth:=1 << 1
			
		: (($vt_authMethod="NEGOTIATE") | ($vt_authMethod="CURLAUTH_NEGOTIATE"))
			$vl_auth:=1 << 2
			
		: (($vt_authMethod="NTLM") | ($vt_authMethod="CURLAUTH_NTLM"))
			$vl_auth:=1 << 3
			
		: (($vt_authMethod="DIGEST_IE") | ($vt_authMethod="CURLAUTH_DIGEST_IE"))
			$vl_auth:=1 << 4
			
		: (($vt_authMethod="NTLM_WB") | ($vt_authMethod="CURLAUTH_NTLM_WB"))
			$vl_auth:=1 << 5
			
		: (($vt_authMethod="BEARER") | ($vt_authMethod="CURLAUTH_BEARER"))
			$vl_auth:=1 << 6
			
		: (($vt_authMethod="ONLY") | ($vt_authMethod="CURLAUTH_ONLY"))
			$vl_auth:=1 << 31
			
	End case 
	
	//   #define CURLAUTH_NONE         ((unsigned long)0)
	//   #define CURLAUTH_BASIC        (((unsigned long)1)<<0)
	//   #define CURLAUTH_DIGEST       (((unsigned long)1)<<1)
	//   #define CURLAUTH_NEGOTIATE    (((unsigned long)1)<<2)
	//   /* Deprecated since the advent of CURLAUTH_NEGOTIATE */
	//   #define CURLAUTH_GSSNEGOTIATE CURLAUTH_NEGOTIATE
	//   /* Used for CURLOPT_SOCKS5_AUTH to stay terminologically correct */
	//   #define CURLAUTH_GSSAPI CURLAUTH_NEGOTIATE
	//   #define CURLAUTH_NTLM         (((unsigned long)1)<<3)
	//   #define CURLAUTH_DIGEST_IE    (((unsigned long)1)<<4)
	//   #define CURLAUTH_NTLM_WB      (((unsigned long)1)<<5)
	//   #define CURLAUTH_BEARER       (((unsigned long)1)<<6)
	//   #define CURLAUTH_ONLY         (((unsigned long)1)<<31)
	//   #define CURLAUTH_ANY          (~CURLAUTH_DIGEST_IE)
	//   #define CURLAUTH_ANYSAFE      (~(CURLAUTH_BASIC|CURLAUTH_DIGEST_IE))
	
	CURL__init
	
	$vo_curlOptions.USERNAME:=$vt_login
	$vo_curlOptions.PASSWORD:=$vt_password
	$vo_curlOptions.HTTPAUTH:=$vl_auth
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "USERNAME : \""+$vt_login+"\""+\
		", PASSWORD : \""+DBG_passwordDebug($vt_password)+"\""+\
		", HTTPAUTH : "+String:C10($vl_auth)+" (\""+DBG_passwordDebug($vt_authMethod)+"\")")
	
End if 
