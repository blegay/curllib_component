//%attributes = {"shared":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : CURL_http_GET
//@scope : public
//@deprecated : no
//@description : This function uses curl plugin to do a http GET
//@parameter[0-OUT-error-LONGINT] : error code (0 = no error)
//@parameter[1-IN-$vt_url-TEXT] : url
//@parameter[2-IN-options-OBJECT] : option object
//@parameter[3-OUT-responseBodyPtr-POINTER] : response body blob pointer (modified)
//@parameter[4-INOUT-httpHeaders-POINTER] : pointer to a text array for headers (optional)
//@notes : 
//@example : CURL_http_GET
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:31:18 - 1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_error)
C_TEXT:C284($1; $vt_url)
C_OBJECT:C1216($2; $vo_curlOptions)
C_POINTER:C301($3; $vp_httpResponseBodyPtr)
C_POINTER:C301($4; $vp_extraHttpHeaderLinesArrayPtr)

$vl_error:=-1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vt_url:=$1
	$vo_curlOptions:=$2
	$vp_httpResponseBodyPtr:=$3
	
	Case of 
		: ($vl_nbParam=3)
		Else 
			ASSERT:C1129(Type:C295($4->)=Text array:K8:16; "$4 should be a text array pointer")
			$vp_extraHttpHeaderLinesArrayPtr:=$4
	End case 
	
	C_LONGINT:C283($vl_error)
	C_BLOB:C604($vx_requestBody)
	SET BLOB SIZE:C606($vx_requestBody; 0)
	
	If ($vo_curlOptions=Null:C1517)
		$vo_curlOptions:=New object:C1471
	End if 
	
	CURL__httpRequestObjPrep($vo_curlOptions; $vt_url; "GET"; $vp_extraHttpHeaderLinesArrayPtr)
	
	If ($vl_nbParam=3)
		$vl_error:=CURL__httpRequestObj($vo_curlOptions; ->$vx_requestBody; $vp_httpResponseBodyPtr)
	Else 
		$vl_error:=CURL__httpRequestObj($vo_curlOptions; ->$vx_requestBody; $vp_httpResponseBodyPtr; $vp_extraHttpHeaderLinesArrayPtr)
	End if 
	
	SET BLOB SIZE:C606($vx_requestBody; 0)
	
End if 
$0:=$vl_error