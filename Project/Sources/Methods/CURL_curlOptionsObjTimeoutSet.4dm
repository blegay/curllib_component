//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_curlOptionsObjTimeoutSet
  //@scope : public
  //@deprecated : no
  //@description : This method will set the transfer timeout in the "option" object
  //@parameter[1-INOUT-curlOptions-OBJECT] : curl options object (modified)
  //@parameter[2-IN-timeoutSecs-TEXT] : timeout in seconds
  //@notes : this is the transfer timeout (0 = never times out)
  //@example : CURL_curlOptionsObjTimeoutSet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:05:09 - 1.00.00
  //@xdoc-end
  //================================================================================

C_OBJECT:C1216($1;$vo_curlOptions)
C_LONGINT:C283($2;$vl_timeoutSecs)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vo_curlOptions:=$1
	$vl_timeoutSecs:=$2
	
	CURL__init 
	
	If ($vl_timeoutSecs>0)
		
		  // https://curl.haxx.se/libcurl/c/CURLOPT_TIMEOUT.html
		  // Pass a long as parameter containing timeout - the maximum time in seconds that you allow the libcurl transfer operation to take. 
		CURL__optionsObj ($vo_curlOptions;"TIMEOUT";$vl_timeoutSecs)
		
	End if 
	
End if 
