//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__escape
  //@scope : public
  //@deprecated : no
  //@description : This function returns text url escaped (using curl plugin)
  //@parameter[0-OUT-urlEscaped-TEXT] : url escaped
  //@parameter[1-IN-urlUnescaped-TEXT] : url unescaped
  //@notes : 
  //@example : CURL__escape
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:34:42 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_urlEscaped)
C_TEXT:C284($1;$vt_urlUnescaped)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
$vt_urlUnescaped:=$1

$vt_urlEscaped:=cURL_Escape ($vt_urlUnescaped)
  //$vt_urlEscaped:=cURL Escape url($vt_urlUnescaped)

$0:=$vt_urlEscaped

