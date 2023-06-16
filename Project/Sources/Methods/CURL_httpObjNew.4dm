//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjNew
//@scope : public
//@deprecated : yes
//@description : This function creates an http object for a curl http request
//@parameter[0-OUT-httpObject-OBJECT] : http object
//@notes : 
//@example : CURL_httpObjNew
// {
//     "url": "http://",
//     "verb": "GET",
//     "status": 0,
//     "error": 0,
//     "timeoutConnectSecs": 120,
//     "timeoutSecs": 240,
//     "followRedirect": true,
//     "progressShow": false,
//     "progressTitle": "",
//     "progressAbortable": false,
//     "request": {
//         "headers": [],
//         "curlOptions": {}
//     },
//     "response": {
//         "headers": []
//     }
// }
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:55:40 - 1.00.08
//@xdoc-end
//================================================================================

C_OBJECT:C1216($0; $vo_httpObject)

CURL__init

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

$vo_httpObject.request:=New object:C1471("headers"; New collection:C1472; "curlOptions"; New object:C1471)
$vo_httpObject.response:=New object:C1471("headers"; New collection:C1472)

$0:=$vo_httpObject