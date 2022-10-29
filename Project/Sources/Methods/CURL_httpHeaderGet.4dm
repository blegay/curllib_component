//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_httpHeaderGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns a header value from a header key for the response sub object
  //@parameter[0-OUT-headerValue-TEXT] : header value
  //@parameter[1-IN-httpObjReponse-OBJECT] : curl http object response subobject (not modified)
  //@parameter[2-IN-headerKey-TEXT] : header key
  //@notes :
  //@example : CURL_httpHeaderGet 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:34:00 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_headerValue)
C_OBJECT:C1216($1;$vo_response)
C_TEXT:C284($2;$vt_headerKey)

  //ASSERT(OB Est défini($1;"response");"response property is undefined/missing")
  //ASSERT(OB Est défini($1;"headers");"headers property is undefined/missing")

$vt_headerValue:=""
$vo_response:=$1
$vt_headerKey:=$2

  //C_OBJET($vo_response)
  //$vo_response:=OB Lire($vo_response;"response";Est un objet)

If (OB Is defined:C1231($vo_response;"headers"))
	C_OBJECT:C1216($vo_headers)
	$vo_headers:=OB Get:C1224($vo_response;"headers";Is object:K8:27)
	
	ARRAY TEXT:C222($tt_propertiesName;0)
	OB GET PROPERTY NAMES:C1232($vo_headers;$tt_propertiesName)
	
	C_LONGINT:C283($vl_found)
	$vl_found:=Find in array:C230($tt_propertiesName;$vt_headerKey)
	If ($vl_found#-1)
		$vt_headerValue:=OB Get:C1224($vo_headers;$tt_propertiesName{$vl_found};Is text:K8:3)
	End if 
	
	ARRAY TEXT:C222($tt_propertiesName;0)
	
End if 

$0:=$vt_headerValue
