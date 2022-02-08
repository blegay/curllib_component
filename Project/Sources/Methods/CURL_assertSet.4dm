//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_assertSet
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This method will allow to test the assertions for all process in the CURL component
  //@parameter[1-IN-assertion-BOOLEAN] : if TRUE, assertions will be enabled for all process in the component
  //@notes : 
  //@example : CURL_assertSet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/04/2021, 17:01:16 - 2.00.05
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($1;$vb_assertion)

$vb_assertion:=$1

If (Get assert enabled:C1130#$vb_assertion)
	
	SET ASSERT ENABLED:C1131($vb_assertion)
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"assertions activated in CURL component (for all processes)")
	
End if 
