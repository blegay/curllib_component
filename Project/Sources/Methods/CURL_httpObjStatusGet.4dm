//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjStatusGet
//@scope : public
//@deprecated : no
//@description : This function returns the http status from an http object
//@parameter[0-OUT-status-LONGINT] : http status (e.g. 200)
//@parameter[1-IN-httpObj-OBJECT] : curl http object (not modified)
//@notes :
//@example : 
//
// If (CURL_httpObjStatusGet ($vo_httpObj)=200)
//
// If ($vo_httpObj.status=200)
//
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:31:35 - v1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_status)
C_OBJECT:C1216($1; $vo_httpObj)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")
ASSERT:C1129(OB Is defined:C1231($1; "status"); "status property is undefined/missing")

$vl_status:=0
$vo_httpObj:=$1

//<Modif> Bruno LEGAY (BLE) (02/06/2020)
$vl_status:=$vo_httpObj.status
//<Modif>

$0:=$vl_status
