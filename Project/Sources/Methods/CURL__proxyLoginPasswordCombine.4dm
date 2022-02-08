//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__proxyLoginPasswordCombine
  //@scope : public
  //@deprecated : no
  //@description : This function combines a login and password for curl option values
  //@parameter[0-OUT-loginPassword-TEXT] : login and password combined
  //@parameter[1-IN-login-TEXT] : login
  //@parameter[2-IN-password-TEXT] : password
  //@notes : 
  //@example : CURL__proxyLoginPasswordCombine
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:18:50 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_loginPassword)
C_TEXT:C284($1;$vt_login)
C_TEXT:C284($2;$vt_password)

ASSERT:C1129(Count parameters:C259>0;"requires 2 parameters")

$vt_login:=$1
$vt_password:=$2

$vt_loginPassword:=CURL__escape ($vt_login)+":"+CURL__escape ($vt_password)

$0:=$vt_loginPassword