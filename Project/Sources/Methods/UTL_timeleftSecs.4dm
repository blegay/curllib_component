//%attributes = {"shared":false,"invisible":true}
C_LONGINT:C283($0;$vl_timeleftSecs)
C_REAL:C285($1;$vr_bufferSize)
C_LONGINT:C283($2;$vl_bufferDurationMs)
C_REAL:C285($3;$vr_sizeLeftToSend)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
$vl_timeleftSecs:=0
$vr_bufferSize:=$1
$vl_bufferDurationMs:=$2
$vr_sizeLeftToSend:=$3

If ($vr_bufferSize>0)
	
	C_REAL:C285($vr_estimatedTimeRemainMs)
	$vr_estimatedTimeRemainMs:=($vl_bufferDurationMs*$vr_sizeLeftToSend)/$vr_bufferSize
	
	$vl_timeleftSecs:=Round:C94($vr_estimatedTimeRemainMs/1000;0)
End if 

$0:=$vl_timeleftSecs