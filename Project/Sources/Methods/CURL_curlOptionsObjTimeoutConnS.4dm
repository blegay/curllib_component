//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_curlOptionsObjTimeoutConnS
//@scope : public
//@deprecated : no
//@description : This method will set the connect timeout in the "option" object
//@parameter[1-INOUT-curlOptions-OBJECT] : curl options object (modified)
//@parameter[2-IN-timeoutSecs-TEXT] : timeout in seconds
//@notes : this is the transfer timeout (default 300 seconds = 5 minutes)
//@example : CURL_curlOptionsObjTimeoutConnS
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:05:09 - 1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_curlOptions)
C_LONGINT:C283($2; $vl_timeoutSecs)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vo_curlOptions:=$1
	$vl_timeoutSecs:=$2
	
	//CURL__init 
	EXECUTE METHOD:C1007("CURL__init")
	
	If ($vl_timeoutSecs>0)
		
		// https://curl.se/libcurl/c/CURLOPT_CONNECTTIMEOUT.html
		// Pass a long. It should contain the maximum time in seconds that you allow the connection phase to the server to take. 
		// This only limits the connection phase, it has no impact once it has connected. Set to zero to switch to the default built-in connection timeout - 300 seconds.
		CURL__optionsObjLong($vo_curlOptions; "CONNECTTIMEOUT"; $vl_timeoutSecs)
		
	End if 
	
End if 
