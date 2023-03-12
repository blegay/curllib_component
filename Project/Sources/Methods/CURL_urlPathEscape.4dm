//%attributes = {"shared":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : CURL_urlPathEscape
//@scope : private 
//@deprecated : no
//@description : This method/function returns 
//@parameter[0-OUT-urlPathEscaped-TEXT] : url path escaped
//@parameter[1-IN-urlPathUnescaped-OBJECT] : url path unescaped
//@notes : 
//@example : CURL_urlEscapePath ("/A&C livraisons/nightly builds/test.zip") => "/A%26C%20livraisons/nightly%20builds/test.zip"
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 12/03/2023, 10:18:02 - 4.00.01
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_urlPathEscaped)
C_TEXT:C284($1; $vt_urlPathUnescaped)

$vt_urlPathUnescaped:=$1
$vt_urlPathEscaped:=""

C_COLLECTION:C1488($c_pathParts)
$c_pathParts:=Split string:C1554($vt_urlPathUnescaped; "/")

C_TEXT:C284($vt_part)
C_LONGINT:C283($vl_count; $vl_parIndex)
$vl_count:=$c_pathParts.length
$vl_parIndex:=0
For each ($vt_part; $c_pathParts)
	$vl_parIndex:=$vl_parIndex+1
	
	$vt_urlPathEscaped:=$vt_urlPathEscaped+cURL_Escape($vt_part)+Choose:C955($vl_parIndex<$vl_count; "/"; "")
	
End for each 

CURL__moduleDebugDateTimeLine(4; Current method name:C684; "url path (unescaped) : \""+$vt_urlPathUnescaped+"\" => url path (escaped) : \""+$vt_urlPathEscaped+"\"")

$0:=$vt_urlPathEscaped