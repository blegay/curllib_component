//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_urlEscape
  //@scope : public
  //@deprecated : no
  //@description : This function returns an escaped url
  //@parameter[0-OUT-urlEscaped-TEXT] : url escaped
  //@parameter[1-IN-url-TEXT] : url
  //@notes : wrapper on cURL_Escape
  //@example : CURL_urlEscape
  //@see : see "cURL Escape url"
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 16:16:31 - 1.00.08
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_urlEscaped)
C_TEXT:C284($1;$vt_urlUnescaped)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_urlEscaped:=""
$vt_urlUnescaped:=$1

If (Length:C16($vt_urlUnescaped)>0)
	$vt_urlEscaped:=cURL_Escape ($vt_urlUnescaped)
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url (unescaped) : \""+$vt_urlUnescaped+"\" => url (escaped) : \""+$vt_urlEscaped+"\"")
End if 

$0:=$vt_urlEscaped