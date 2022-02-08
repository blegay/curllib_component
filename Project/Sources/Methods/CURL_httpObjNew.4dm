//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_httpObjNew
  //@scope : public
  //@deprecated : no
  //@description : This function creates an http object for a curl http request
  //@parameter[0-OUT-httpObject-OBJECT] : http object
  //@parameter[1-IN-verb-TEXT] : http verb (e.g. "GET", POST", "PUT", "DELETE", HEAD", optional, default "GET)
  //@parameter[2-IN-url-TEXT] : url (optional, default "http://")
  //@notes : 
  //@example : CURL_httpObjNew
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:55:40 - 1.00.08
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($0;$vo_httpObject)
C_TEXT:C284($1;$vt_verb)
C_TEXT:C284($2;$vt_url)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
Case of 
	: ($vl_nbParam=0)
		$vt_verb:=HTTP GET method:K71:1  //"GET"
		$vt_url:="http://"
		
	: ($vl_nbParam=1)
		$vt_verb:=$1
		$vt_url:="http://"
		
	Else 
		  //: ($vl_nbParam=2)
		$vt_verb:=$1
		$vt_url:=$2
		
End case 

CURL__init 
  //CURL__initG 

  //<Modif> Bruno LEGAY (BLE) (02/06/2020)
$vo_httpObject:=New object:C1471

$vo_httpObject.verb:=$vt_verb
$vo_httpObject.url:=$vt_url

  //$vo_httpObject.url:="http://"
  //$vo_httpObject.verb:="GET"

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
  //OB SET NULL($vo_requestObject;"headers")
$vo_requestObject:=New object:C1471
$vo_requestObject.headers:=New collection:C1472

  //C_OBJET($vo_responseHeaders;0)
  //OB FIXER($vo_responseObject;"headers";$vo_responseHeaders)
  //OB SET NULL($vo_responseObject;"headers")
$vo_responseObject:=New object:C1471
$vo_responseObject.headers:=New collection:C1472

$vo_httpObject.request:=$vo_requestObject
$vo_httpObject.response:=$vo_responseObject
  //OB SET($vo_httpObject;"request";$vo_requestObject)
  //OB SET($vo_httpObject;"response";$vo_responseObject)

$vo_httpObject.request.curlOptions:=New object:C1471
$vo_httpObject.request.curlOptions.PRIVATE:=JSON Stringify:C1217(New object:C1471("progressId";0))

  //$vo_httpObject.request.curlOptions.userInfo:=New object


  //C_OBJECT($vo_curlOptions)
  //OB SET($vo_requestObject;"curlOptions";$vo_curlOptions)

  //ARRAY OBJECT($to_options;0)
  //OB SET ARRAY($vo_requestObject;"curlOptions";$to_options)
  //OB SET ARRAY($vo_httpObject;"curlOptions";$to_options)

$0:=$vo_httpObject