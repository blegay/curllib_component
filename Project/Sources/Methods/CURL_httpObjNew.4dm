//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjNew
//@scope : public
//@deprecated : no
//@description : This function creates an http object for a curl http request
//@parameter[0-OUT-httpObject-OBJECT] : http object
//@notes : 
//@example : CURL_httpObjNew
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:55:40 - 1.00.08
//@xdoc-end
//================================================================================

C_OBJECT:C1216($0; $vo_httpObject)

CURL__init
//CURL__initG 

//<Modif> Bruno LEGAY (BLE) (02/06/2020)
$vo_httpObject:=New object:C1471

$vo_httpObject.url:="http://"
$vo_httpObject.verb:="GET"

$vo_httpObject.status:=0
$vo_httpObject.error:=0

$vo_httpObject.timeoutConnectSecs:=120
$vo_httpObject.timeoutSecs:=240

$vo_httpObject.followRedirect:=True:C214

$vo_httpObject.progressShow:=False:C215
$vo_httpObject.progressTitle:=""
$vo_httpObject.progressAbortable:=False:C215

//OB SET($vo_httpObject;"url";"http://")
//OB SET($vo_httpObject;"verb";"GET")

//OB SET($vo_httpObject;"status";0)
//OB SET($vo_httpObject;"error";0)

//OB SET($vo_httpObject;"timeoutConnectSecs";120)
//OB SET($vo_httpObject;"timeoutSecs";240)

//<Modif>

C_OBJECT:C1216($vo_requestObject)
C_OBJECT:C1216($vo_responseObject)


//C_OBJET($vo_requestHeaders;0)
//OB FIXER($vo_requestObject;"headers";$vo_requestHeaders)
OB SET NULL:C1233($vo_requestObject; "headers")

//C_OBJET($vo_responseHeaders;0)
//OB FIXER($vo_responseObject;"headers";$vo_responseHeaders)
OB SET NULL:C1233($vo_responseObject; "headers")

OB SET:C1220($vo_httpObject; "request"; $vo_requestObject)
OB SET:C1220($vo_httpObject; "response"; $vo_responseObject)

C_OBJECT:C1216($vo_curlOptions)
OB SET:C1220($vo_requestObject; "curlOptions"; $vo_curlOptions)

//ARRAY OBJECT($to_options;0)
//OB SET ARRAY($vo_requestObject;"curlOptions";$to_options)
//OB SET ARRAY($vo_httpObject;"curlOptions";$to_options)

$0:=$vo_httpObject