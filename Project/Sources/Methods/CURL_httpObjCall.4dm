//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

//================================================================================
//@xdoc-start : en
//@name : CURL_httpObjCall
//@scope : public
//@deprecated : no
//@description : This function will make an http request
//@parameter[0-OUT-error-LONGINT] : error code (0 if no error)
//@parameter[1-IN-httpObj-OBJECT] : ParamDescription
//@parameter[2-IN-requestBodyBlobPtr-POINTER] : request body blob pointer (modified, optional)
//@parameter[3-IN-responseBodyBlobPtr-POINTER] : response body blob (modified, optional)
//@notes :
//@example : CURL_httpObjCall
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:09:00 - v1.00.08
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_error)
C_OBJECT:C1216($1; $vo_httpObj)
C_POINTER:C301($2; $vp_requestBodyBlobPtr)
C_POINTER:C301($3; $vp_responseBodyBlobPtr)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If (Count parameters:C259>0)
	$vo_httpObj:=$1
	
	Case of 
			//: ($vl_nbParam=0)
		: ($vl_nbParam=1)
			
		: ($vl_nbParam=2)
			ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12; "$2 should be a blob pointer")
			
			$vp_requestBodyBlobPtr:=$2
			
		Else 
			// : ($vl_nbParam=3)
			ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12; "$2 should be a blob pointer")
			ASSERT:C1129(Type:C295($3->)=Is BLOB:K8:12; "$3 should be a blob pointer")
			
			$vp_requestBodyBlobPtr:=$2
			$vp_responseBodyBlobPtr:=$3
	End case 
	
	CURL__init
	//CURL__initG 
	
	ASSERT:C1129(OB Is defined:C1231($vo_httpObj; "verb"); "\"verb\" property is undefied or missing")
	ASSERT:C1129(OB Is defined:C1231($vo_httpObj; "url"); "\"url\" property is undefied or missing")
	
	C_TEXT:C284($vt_verb; $vt_url)
	$vt_verb:=OB Get:C1224($vo_httpObj; "verb"; Is text:K8:3)
	$vt_url:=OB Get:C1224($vo_httpObj; "url"; Is text:K8:3)
	
	ARRAY TEXT:C222($tt_headers; 0)
	CURL__httpRequestObjPrep($vo_httpObj; $vt_url; $vt_verb; ->$tt_headers)
	
	
	$vl_error:=CURL__httpRequestObj($vo_httpObj; $vp_requestBodyBlobPtr; $vp_responseBodyBlobPtr)  //;$vp_extraHttpHeaderLinesArrayPtr)
	
	
	
	//C_LONGINT($vl_error)
	//C_BLOB($vx_requestBody)
	//SET BLOB SIZE($vx_requestBody;0)
	
	//C_BLOB($vx_responseBody)
	//SET BLOB SIZE($vx_responseBody;0)
	
	//C_OBJECT($vo_httpRequestObj;$vo_httpObjResponse)
	//ASSERT(OB Is defined($vo_httpObj;"request");"request object is undefined/missing")
	//$vo_httpRequestObj:=OB Get($vo_httpObj;"request";Is object)
	
	
	//Case of 
	//: (OB Is defined($vo_httpRequestObj;"bodyBase64"))
	
	//C_TEXT($vt_base64)
	//$vt_base64:=OB Get($vo_httpRequestObj;"bodyBase64";Is text)
	//If (Length($vt_base64)>0)
	//BASE64 DECODE($vt_base64;$vx_requestBody)
	//$vt_base64:=""
	//End if 
	
	//: (Type($vp_requestBodyBlobPtr->)=Is BLOB)
	//$vx_requestBody:=$vp_requestBodyBlobPtr->
	
	//End case 
	
	//OB SET($vo_httpRequestObj;"bodySize";BLOB size($vx_requestBody))
	
	//C_TEXT($vt_curlInfosJson)
	
	
	//ARRAY TEXT($tt_httpHeaderCombined;0)
	//  //CURL_httpObjHeaderToArrCombined ($vo_httpRequestObj;->$tt_httpHeaderCombined)
	
	//CURL__moduleDebugDateTimeLine (4;Current method name;$vt_verb+" \""+$vt_url+"\", request body size : "+String(BLOB size($vx_requestBody))+"...")
	
	//C_LONGINT($vl_durationMs)
	//$vl_durationMs:=Milliseconds
	
	//C_LONGINT($vl_error)
	//$vl_error:=CURL__httpRequestObj ($vo_curlOptions;->$vx_requestBody;->$vx_responseBody;->$tt_httpHeaderCombined;->$vt_curlInfosJson)
	//  //$vl_error:=CURL__httpRequest ($vt_url;->$tl_keys;->$tt_values;->$vx_requestBody;->$vx_responseBody;->$tt_httpHeaderCombined;->$vt_curlInfosJson)
	
	//$vl_durationMs:=LONG_durationDifference ($vl_durationMs;Milliseconds)
	
	
	//If (Length($vt_curlInfosJson)>0)
	//C_OBJECT($vo_curlInfos)
	//$vo_curlInfos:=JSON Parse($vt_curlInfosJson)
	//OB SET($vo_httpObj;"curlInfos";$vo_curlInfos)
	//End if 
	
	//OB SET($vo_httpObj;"durationMs";$vl_durationMs)
	//OB SET($vo_httpObj;"error";$vl_error)
	
	//C_LONGINT($vl_httpStatus)
	//$vl_httpStatus:=0
	
	//If ($vl_error=0)
	
	
	//C_TEXT($vt_httpStatusLine)
	//$vt_httpStatusLine:=CURL__httpRequestCleanHeaders (->$tt_httpHeaderCombined)
	
	//$vl_httpStatus:=CURL__httpStatusLineToStatus ($vt_httpStatusLine)
	//OB SET($vo_httpObj;"status";$vl_httpStatus)
	
	//C_OBJECT($vo_headers)
	
	//C_LONGINT($i)
	//For ($i;1;Size of array($tt_httpHeaderCombined))
	//C_TEXT($vt_key;$vt_value)
	//If (CURL__headerLineSplit ($tt_httpHeaderCombined{$i};->$vt_key;->$vt_value))
	//OB SET($vo_headers;$vt_key;$vt_value)
	//End if 
	//End for 
	
	//C_OBJECT($vo_httpResponseObj)
	//ASSERT(OB Is defined($vo_httpObj;"response");"request object is undefined/missing")
	//$vo_httpResponseObj:=OB Get($vo_httpObj;"response";Is object)
	
	//OB SET($vo_httpResponseObj;"headers";$vo_headers)
	//OB SET($vo_httpResponseObj;"bodySize";BLOB size($vx_responseBody))
	
	//Case of 
	//: (Type($vp_responseBodyBlobPtr->)=Is BLOB)
	//$vp_responseBodyBlobPtr->:=$vx_responseBody
	
	//Else 
	
	//C_TEXT($vt_base64)
	//$vt_base64:=""
	//If (BLOB size($vx_responseBody)>0)
	//BASE64 ENCODE($vx_responseBody;$vt_base64)
	//End if 
	//OB SET($vo_httpResponseObj;"bodyBase64";$vt_base64)
	//$vt_base64:=""
	
	//End case 
	
	//Else 
	//OB SET($vo_httpObj;"status";0)
	//End if 
	
	//CURL__moduleDebugDateTimeLine (4;Current method name;$vt_verb+" \""+$vt_url+"\", status : "+String($vl_httpStatus)+", error : "+String($vl_error)+", duration : "+String($vl_durationMs/1000))
	
	//ARRAY TEXT($tt_httpHeaderCombined;0)
	
	//SET BLOB SIZE($vx_requestBody;0)
	//SET BLOB SIZE($vx_responseBody;0)
	
End if 
$0:=$vl_error