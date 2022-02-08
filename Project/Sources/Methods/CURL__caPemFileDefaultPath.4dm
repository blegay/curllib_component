//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__caPemFileDefaultPath
  //@scope : public
  //@deprecated : no
  //@description : This function returns the default ca certificates pem file stored in the component
  //@parameter[0-OUT-caPemFileDefaultPath-TEXT] : caPemFileDefaultPath
  //@notes : 
  //@example : CURL__caPemFileDefaultPath
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/09/2017, 13:48:05 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_caPemFileDefaultPath)

$vt_caPemFileDefaultPath:=Get 4D folder:C485(Current resources folder:K5:16)+"certs"+Folder separator:K24:12+"cacert.pem"

$0:=$vt_caPemFileDefaultPath