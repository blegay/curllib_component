//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_TEXT:C284($0;$vt_json)
C_OBJECT:C1216($1;$vo_curlOptions)
C_BOOLEAN:C305($2;$vb_indent)

ASSERT:C1129(Count parameters:C259>0;"requires 1 parameter")

If (Count parameters:C259>1)
	$vb_indent:=$2
Else 
	$vb_indent:=True:C214
End if 

$vt_json:=""
If ($1#Null:C1517)
	
	$vo_curlOptions:=OB Copy:C1225($1)  // do not modify original object
	
	C_COLLECTION:C1488($co_passwordProp)
	$co_passwordProp:=New collection:C1472("PASSWORD";"PROXYUSERPWD";"KEYPASSWD";"TLSAUTH_PASSWORD")
	
	  // makes a password safe (for logs)
	  // "veryComplicated" =>  "ve***********ed"
	CURL__debugObjectJsonSub ($vo_curlOptions;$co_passwordProp)
	
	If ($vb_indent)
		$vt_json:=JSON Stringify:C1217($vo_curlOptions;*)
	Else 
		$vt_json:=JSON Stringify:C1217($vo_curlOptions)
	End if 
	
	CLEAR VARIABLE:C89($vo_curlOptions)
	
End if 
$0:=$vt_json