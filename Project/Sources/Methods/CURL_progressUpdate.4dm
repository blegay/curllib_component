//%attributes = {"invisible":false,"preemptive":"incapable","shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_progressUpdate
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-aborted-BOOLEAN] : aborted
  //@parameter[1-IN-progressId-LONGINT] : progressId
  //@parameter[2-IN-progress-REAL] : progress value
  //@parameter[3-IN-message-TEXT] : message
  //@notes : 
  //@example : CURL_progressUpdate
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/04/2022, 14:20:58 - 3.00.03
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_aborted)
C_LONGINT:C283($1;$vl_progressId)
C_REAL:C285($2;$vr_progress)
C_TEXT:C284($3;$vt_message)

$vb_aborted:=False:C215
$vl_progressId:=$1
$vr_progress:=$2
$vt_message:=$3

Progress SET PROGRESS ($vl_progressId;$vr_progress;$vt_message)
$vb_aborted:=Progress Stopped ($vl_progressId)

$0:=$vb_aborted