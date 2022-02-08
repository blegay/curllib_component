//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_assertGet
  //@scope : public 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns TRUE if the assertions are actiavted for all process in the CURL component
  //@parameter[0-OUT-assertion-BOOLEAN] : if TRUE, assertions are enabled for all process in the component
  //@notes : 
  //@example : CURL_assertGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/04/2021, 17:02:48 - 2.00.05
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_assertion)

$vb_assertion:=Get assert enabled:C1130

$0:=$vb_assertion
