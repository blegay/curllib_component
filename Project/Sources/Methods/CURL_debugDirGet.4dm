//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_debugDirGet
  //@scope : public 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns the debug dir path
  //@parameter[0-OUT-debugDirPath-TEXT] : debug dir path
  //@notes : this applies to all processes
  //@example : CURL_debugDirGet
  //@see : CURL_debugDirSet
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 12/01/2021, 12:36:40 - 2.00.03
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_debugDirPath)

$vt_debugDirPath:=""

CURL__init 

$vt_debugDirPath:=Storage:C1525.curl.debugDirPath

$0:=$vt_debugDirPath