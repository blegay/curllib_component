//%attributes = {"shared":true,"invisible":false}
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

C_LONGINT:C283($0;$vl_error)
C_OBJECT:C1216($1;$vo_httpObj)
C_POINTER:C301($2;$vp_requestBodyBlobPtr)
C_POINTER:C301($3;$vp_responseBodyBlobPtr)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If (Count parameters:C259>0)
	$vo_httpObj:=$1
	
	Case of 
			  //: ($vl_nbParam=0)
		: ($vl_nbParam=1)
			
		: ($vl_nbParam=2)
			ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12;"$2 should be a blob pointer")
			
			$vp_requestBodyBlobPtr:=$2
			
		Else 
			  // : ($vl_nbParam=3)
			ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12;"$2 should be a blob pointer")
			ASSERT:C1129(Type:C295($3->)=Is BLOB:K8:12;"$3 should be a blob pointer")
			
			$vp_requestBodyBlobPtr:=$2
			$vp_responseBodyBlobPtr:=$3
	End case 
	
	CURL__init 
	  //CURL__initG 
	
	ASSERT:C1129(OB Is defined:C1231($vo_httpObj;"verb");"\"verb\" property is undefied or missing")
	ASSERT:C1129(OB Is defined:C1231($vo_httpObj;"url");"\"url\" property is undefied or missing")
	
	C_TEXT:C284($vt_verb;$vt_url)
	$vt_verb:=OB Get:C1224($vo_httpObj;"verb";Is text:K8:3)
	$vt_url:=OB Get:C1224($vo_httpObj;"url";Is text:K8:3)
	
	ARRAY TEXT:C222($tt_headers;0)
	CURL__httpRequestObjPrep ($vo_httpObj;$vt_url;$vt_verb;->$tt_headers)
	
	C_BLOB:C604($vx_dummyRequestBodyBlob;$vx_dummyResponseBodyBlob)
	SET BLOB SIZE:C606($vx_dummyRequestBodyBlob;0)
	SET BLOB SIZE:C606($vx_dummyResponseBodyBlob;0)
	
	Case of 
			  //: ($vl_nbParam=0)
		: ($vl_nbParam=1)
			
			$vl_error:=CURL__httpRequestObj ($vo_httpObj;->$vx_dummyRequestBodyBlob;->$vx_dummyResponseBodyBlob)
			
		: ($vl_nbParam=2)
			$vl_error:=CURL__httpRequestObj ($vo_httpObj;$vp_requestBodyBlobPtr;->$vx_dummyResponseBodyBlob)
			
		Else 
			  // : ($vl_nbParam=3)
			$vl_error:=CURL__httpRequestObj ($vo_httpObj;$vp_requestBodyBlobPtr;$vp_responseBodyBlobPtr)  //;$vp_extraHttpHeaderLinesArrayPtr)
	End case 
	
	SET BLOB SIZE:C606($vx_dummyRequestBodyBlob;0)
	SET BLOB SIZE:C606($vx_dummyResponseBodyBlob;0)
	
End if 
$0:=$vl_error