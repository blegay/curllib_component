//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP_responseOk
  //@scope : private
  //@deprecated : no
  //@description : This function returns TRUE if the http status is SUCCESS (200 => 299)
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE of ok, FALSE otherwise
  //@parameter[1-IN-httpResponseStatus-LONGINT] : http status
  //@notes : 
  //@example : HTTP_responseOk 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2018
  //@history : CREATION : Bruno LEGAY (BLE) - 25/04/2016, 19:40:58 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_LONGINT:C283($1;$vl_httpResponseStatus)  // 200, 204

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")
$vl_httpResponseStatus:=$1

$vb_ok:=(($vl_httpResponseStatus>=200) & ($vl_httpResponseStatus<=299))

$0:=$vb_ok