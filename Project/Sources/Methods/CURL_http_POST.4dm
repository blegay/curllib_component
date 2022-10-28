//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_http_POST
//@scope : public
//@deprecated : no
//@description : This function uses curl plugin to do a http POST
//@parameter[0-OUT-error-LONGINT] : error code (0 = no error)
//@parameter[1-IN-$vt_url-TEXT] : url
//@parameter[2-IN-options-OBJECT] : option object
//@parameter[3-OUT-requestBodyPtr-POINTER] : response body blob pointer (modified)
//@parameter[4-IN-contentType-TEXTE] : content-type
//@parameter[5-OUT-responseBodyPtr-POINTER] : response body blob pointer (modified)
//@parameter[6-INOUT-httpHeaders-POINTER] : pointer to a text array for headers (optional)
//@notes : 
//@example : CURL_http_POST
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:45:28 - 1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_error)
C_TEXT:C284($1; $vt_url)
C_OBJECT:C1216($2; $vo_curlOptions)
C_POINTER:C301($3; $vp_httpRequestBodyPtr)
C_TEXT:C284($4; $vt_contentType)
C_POINTER:C301($5; $vp_httpResponseBodyPtr)
C_POINTER:C301($6; $vp_extraHttpHeaderLinesArrayPtr)
C_LONGINT:C283($vl_nbParam)

$vl_error:=-1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>4)
	$vt_url:=$1
	$vo_curlOptions:=$2
	$vp_httpRequestBodyPtr:=$3
	$vt_contentType:=$4
	$vp_httpResponseBodyPtr:=$5
	
	Case of 
		: ($vl_nbParam=5)
		Else 
			ASSERT:C1129(Type:C295($6->)=Text array:K8:16; "$6 should be a text array pointer")
			$vp_extraHttpHeaderLinesArrayPtr:=$6
	End case 
	
	CURL__init
	
	If ($vo_curlOptions=Null:C1517)
		$vo_curlOptions:=New object:C1471
	End if 
	
	CURL__httpRequestObjPrep($vo_curlOptions; $vt_url; "POST"; $vp_extraHttpHeaderLinesArrayPtr; $vt_contentType)
	
	$vl_error:=CURL__httpRequestObj($vo_curlOptions; $vp_httpRequestBodyPtr; $vp_httpResponseBodyPtr; $vp_extraHttpHeaderLinesArrayPtr)
	
End if 
$0:=$vl_error
