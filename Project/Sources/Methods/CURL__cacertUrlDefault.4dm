//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__cacertUrlDefault
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns the cacert.pem url
  //@parameter[0-OUT-paramName-TEXT] : carcert url (e.g. "https://curl.se/ca/cacert.pem")
  //@notes : 
  //@example : CURL__cacertUrlDefault
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 09/04/2021, 17:09:06 - 2.00.05
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_url)

$vt_url:="https://curl.se/ca/cacert.pem"

$0:=$vt_url