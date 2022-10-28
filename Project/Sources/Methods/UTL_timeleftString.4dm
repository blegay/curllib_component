//%attributes = {"invisible":true,"preemptive":"capable"}
C_TEXT:C284($0; $vt_timeleftString)
C_LONGINT:C283($1; $vl_timeleftSecs)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")
$vt_timeleftString:=""
$vl_timeleftSecs:=$1

If ($vl_timeleftSecs>0)
	
	C_LONGINT:C283($vl_nbSecsInADay; $vl_nbSecsInAnHour; $vl_nbSecsInAMinute)
	$vl_nbSecsInADay:=86400
	$vl_nbSecsInAnHour:=3600
	$vl_nbSecsInAMinute:=60
	
	Case of 
		: ($vl_timeleftSecs>($vl_nbSecsInADay*10))
			$vt_timeleftString:=String:C10($vl_timeleftSecs\$vl_nbSecsInADay)+"d"
			
		: ($vl_timeleftSecs>$vl_nbSecsInADay)
			$vt_timeleftString:=String:C10($vl_timeleftSecs\$vl_nbSecsInADay)+"d "+String:C10(($vl_timeleftSecs%$vl_nbSecsInADay)\$vl_nbSecsInAnHour)+"h"
			
		: ($vl_timeleftSecs>$vl_nbSecsInAnHour)
			$vt_timeleftString:=String:C10($vl_timeleftSecs\$vl_nbSecsInAnHour)+"h "+String:C10(($vl_timeleftSecs%$vl_nbSecsInAnHour)\$vl_nbSecsInAMinute)+"m"
			
		: ($vl_timeleftSecs>$vl_nbSecsInAMinute)
			$vt_timeleftString:=String:C10($vl_timeleftSecs\$vl_nbSecsInAMinute)+"m "+String:C10($vl_timeleftSecs%$vl_nbSecsInAMinute)+"s"
			
		Else 
			$vt_timeleftString:=String:C10($vl_timeleftSecs)+"s"
	End case 
	
End if 

$0:=$vt_timeleftString