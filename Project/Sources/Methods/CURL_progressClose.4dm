//%attributes = {"invisible":false,"shared":true,"preemptive":"incapable"}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_progressClose
  //@scope : public 
  //@deprecated : no
  //@description : This method is a wapper on "Progress QUIT"
  //@parameter[1-IN-progressId-LONGINT] : progressId
  //@notes : 
  //@example : CURL_progressClose
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/04/2022, 14:18:19 - 3.00.03
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($1;$vl_progressId)

$vl_progressId:=$1

Progress QUIT ($vl_progressId)

