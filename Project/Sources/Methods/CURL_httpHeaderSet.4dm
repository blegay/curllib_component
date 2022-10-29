//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_httpHeaderSet
  //@scope : public
  //@deprecated : no
  //@description : This method sets a header to a request object from a http object
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-httpRequestObj-OBJET] : http.request object
  //@parameter[2-IN-key-TEXT] : key
  //@parameter[3-IN-value-TEXT] : value
  //@notes : 
  //@example : 
  //
  //  C_OBJECT($vo_httpObj)
  //  $vo_httpObj:=CURL_httpRequestNew 
  //
  //  OB SET($vo_httpObj;"url";"https://curl.haxx.se/ca/cacert.pem")
  //  OB SET($vo_httpObj;"verb";"GET")
  //
  //  C_OBJECT($vo_httpRequestObj)
  //  $vo_httpRequestObj:=OB Get($vo_httpObj;"request";Est un objet)
  //  CURL_httpHeaderSet ($vo_httpRequestObj;"Accept";"application/x-pem-file")
  //
  // // OR
  //
  //  C_OBJECT($vo_httpObj)
  //  $vo_httpObj:=CURL_httpRequestNew 
  //
  //  $vo_httpObj.url:="https://curl.haxx.se/ca/cacert.pem"
  //  $vo_httpObj.verb:="GET"
  //
  //  CURL_httpHeaderSet ($vo_httpObj.request;"Accept";"application/x-pem-file")
  //
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:57:50 - 1.00.08
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($1;$vo_httpRequestObj)
C_TEXT:C284($2;$vt_key)
C_TEXT:C284($3;$vt_value)

$vo_httpRequestObj:=$1
$vt_key:=$2
$vt_value:=$3

ASSERT:C1129(OB Is defined:C1231($vo_httpRequestObj;"headers");"headers object missing")

C_OBJECT:C1216($vo_headers;0)
$vo_headers:=OB Get:C1224($vo_httpRequestObj;"headers";Is object:K8:27)

ARRAY TEXT:C222($tt_propertiesName;0)

OB GET PROPERTY NAMES:C1232($vo_headers;$tt_propertiesName)

C_LONGINT:C283($vl_found)
$vl_found:=Find in array:C230($tt_propertiesName;$vt_key)
If ($vl_found#-1)
	OB SET:C1220($vo_headers;$tt_propertiesName{$vl_found};$vt_value)
Else 
	OB SET:C1220($vo_headers;$vt_key;$vt_value)
End if 
OB SET:C1220($vo_httpRequestObj;"headers";$vo_headers)

ARRAY TEXT:C222($tt_propertiesName;0)

ARRAY OBJECT:C1221($to_headers;0)