//%attributes = {"shared":true,"preemptive":"capable"}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_http_HEAD
  //@scope : public
  //@deprecated : no
  //@description : This function uses curl plugin to do a http HEAD
  //@parameter[0-OUT-error-LONGINT] : error code (0 = no error)
  //@parameter[1-IN-$vt_url-TEXT] : url
  //@parameter[2-IN-options-OBJET] : option object
  //@parameter[3-INOUT-httpHeaders-POINTER] : pointer to a text array for headers (optional)
  //@notes :
  //@example : CURL_http_HEAD 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/09/2017, 17:31:45 - v1.00.00
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_error)
C_TEXT:C284($1;$vt_url)
C_OBJECT:C1216($2;$vo_curlOptions)
C_POINTER:C301($3;$vp_extraHttpHeaderLinesArrayPtr)

$vl_error:=-1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	  //If ($vl_nbParam>2)
	$vt_url:=$1
	
	Case of 
		: ($vl_nbParam=2)
			$vo_curlOptions:=$2
			
		Else 
			$vo_curlOptions:=$2
			
			ASSERT:C1129(Type:C295($3->)=Text array:K8:16;"$3 should be a text array pointer")
			$vp_extraHttpHeaderLinesArrayPtr:=$3
	End case 
	
	  //CURL__init 
	
	  //ARRAY LONGINT($tl_keys;0)
	  //ARRAY TEXT($tt_values;0)
	
	  //APPEND TO ARRAY($tl_keys;CURLOPT_NOBODY)
	  //APPEND TO ARRAY($tt_values;"1")
	
	  //CURL__optionsFromObject(->$tl_keys;->$tt_values;$vo_options)
	
	C_LONGINT:C283($vl_error)
	C_BLOB:C604($vx_requestBody;$vx_responseBody)
	SET BLOB SIZE:C606($vx_requestBody;0)
	SET BLOB SIZE:C606($vx_responseBody;0)
	
	If ($vo_curlOptions=Null:C1517)
		$vo_curlOptions:=New object:C1471
	End if 
	CURL__httpRequestObjPrep ($vo_curlOptions;$vt_url;"HEAD";$vp_extraHttpHeaderLinesArrayPtr)
	
	If ($vl_nbParam=2)
		$vl_error:=CURL__httpRequestObj ($vo_curlOptions;->$vx_requestBody;->$vx_responseBody)
	Else 
		$vl_error:=CURL__httpRequestObj ($vo_curlOptions;->$vx_requestBody;->$vx_responseBody;$vp_extraHttpHeaderLinesArrayPtr)
	End if 
	
	SET BLOB SIZE:C606($vx_requestBody;0)
	SET BLOB SIZE:C606($vx_responseBody;0)
	
End if 
$0:=$vl_error