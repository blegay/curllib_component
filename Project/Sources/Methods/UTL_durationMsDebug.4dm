//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : UTL_durationMsDebug
  //@scope : private
  //@deprecated : no
  //@description : This function returns the duration from a miliseconds duration for debug purposes
  //@parameter[0-OUT-durationMsDebug-TEXT] : duration text for debug (e.g. "0,020s")
  //@parameter[1-IN-durationMs-LONGINT] : duration in milliseconds
  //@notes : 
  //@example : UTL_durationMsDebug(20) => "0,020s"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2018
  //@history : CREATION : Bruno LEGAY (BLE) - 17/04/2016, 09:34:36 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_durationMsDebug)
C_LONGINT:C283($1;$vl_durationMs)

ASSERT:C1129(Count parameters:C259>0;"$1 is expected")
$vl_durationMs:=$1

$vt_durationMsDebug:=String:C10($vl_durationMs/1000;"# ### ### ##0.000")+"s"

$0:=$vt_durationMsDebug