//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjResponseBodyGet
//@scope : public
//@deprecated : yes
//@description : This methods retrieves the response body (from the object if stored as base64)
//@parameter[1-IN-httpObj-OBJECT] : http object
//@parameter[2-OUT-bodyPtr-POINTER] : response blody blob pointer (modified)
//@notes : 
//@example : CURL_httpObjResponseBodyGet
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION :  - 19/11/2019, 14:16:32 - 1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_httpObj)
C_POINTER:C301($2; $vp_bodyPtr)

ASSERT:C1129(OB Is defined:C1231($1; "response"); "response object is undefined/missing")
ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12; "$2 should be a blob pointer")

$vo_httpObj:=$1
$vp_bodyPtr:=$2

C_OBJECT:C1216($vo_httpObjResponse)
ASSERT:C1129(OB Is defined:C1231($vo_httpObj; "response"); "response object is undefined/missing")
$vo_httpObjResponse:=OB Get:C1224($vo_httpObj; "response"; Is object:K8:27)

C_TEXT:C284($vt_base64)
$vt_base64:=OB Get:C1224($vo_httpObjResponse; "bodyBase64"; Is text:K8:3)
If (Length:C16($vt_base64)>0)
	BASE64 DECODE:C896($vt_base64; $vp_bodyPtr->)
	$vt_base64:=""
End if 
