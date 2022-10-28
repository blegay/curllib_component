//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjRequestBodySet
//@scope : public
//@deprecated : no
//@description : This method sets the body for the request of an http object
//@parameter[1-IN-httpObj-OBJECT] : http object (modified)
//@parameter[2-IN-bodyPtr-POINTER] : request body blob pointer (not modified)
//@notes :
//@example : CURL_httpObjRequestBodySet¬†
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:06:48 - v1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_httpObj)
C_POINTER:C301($2; $vp_bodyPtr)

ASSERT:C1129(OB Is defined:C1231($1; "request"); "request object is undefined/missing")
ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12; "$2 should be a blob pointer")

$vo_httpObj:=$1
$vp_bodyPtr:=$2

C_OBJECT:C1216($vo_httpObjRequest)
ASSERT:C1129(OB Is defined:C1231($vo_httpObj; "request"); "request object is undefined/missing")
$vo_httpObjRequest:=OB Get:C1224($vo_httpObj; "request"; Is object:K8:27)

C_TEXT:C284($vt_base64)
$vt_base64:=""
C_LONGINT:C283($vl_size)
$vl_size:=BLOB size:C605($vp_bodyPtr->)
If ($vl_size>0)
	BASE64 ENCODE:C895($vp_bodyPtr->; $vt_base64)
End if 

OB SET:C1220($vo_httpObjRequest; "bodyBase64"; $vt_base64)
OB SET:C1220($vo_httpObjRequest; "bodySize"; $vl_size)
