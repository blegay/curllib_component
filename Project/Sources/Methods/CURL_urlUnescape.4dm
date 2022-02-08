//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_urlUnescape
  //@scope : public
  //@deprecated : no
  //@description : This function returns an unescaped url
  //@parameter[0-OUT-urlUnescaped-TEXT] : url unescaped
  //@parameter[1-IN-url-TEXT] : url
  //@notes : 
  //@example : CURL_urlUnescape
  //@see : see "cURL Unescape url"
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 16:16:39 - 1.00.08
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_urlUnescaped)
C_TEXT:C284($1;$vt_urlEscaped)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

$vt_urlUnescaped:=""
$vt_urlEscaped:=$1

If (Length:C16($vt_urlEscaped)>0)
	$vt_urlUnescaped:=cURL_Unescape ($vt_urlEscaped)
	  //$vt_urlUnescaped:=cURL Unescape url($vt_urlEscaped)
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url (escaped) : \""+$vt_urlEscaped+"\" => url (unescaped) : \""+$vt_urlUnescaped+"\"")
End if 

$0:=$vt_urlUnescaped