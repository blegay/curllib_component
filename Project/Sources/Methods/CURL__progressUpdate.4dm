//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
C_BOOLEAN:C305($0; $vb_abort)
C_LONGINT:C283($1; $vl_progressId)
C_REAL:C285($2; $vr_progress)
C_TEXT:C284($3; $vt_message)

$vb_abort:=False:C215
$vl_progressId:=$1
$vr_progress:=$2
$vt_message:=$3

Progress SET PROGRESS($vl_progressId; $vr_progress; $vt_message)
$vb_abort:=Progress Stopped($vl_progressId)

$0:=$vb_abort