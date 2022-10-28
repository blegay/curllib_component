//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

//================================================================================
//@xdoc-start : en
//@name : DAT__dateTimeZoneOffsetApply
//@scope : public
//@deprecated : no
//@description : This method applies a time offset (in seconds) to a date and time
//@parameter[1-INOUT-datePtr-POIINTER] : date pointer (modified)
//@parameter[2-INOUT-timePtr-POINTER] : time pointer (modified)
//@parameter[3-IN-timeOffsetSeconds-LONGINT] : offset in seconds
//@notes :
//@example : DAT__dateTimeZoneOffsetApply¬†
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 25/08/2015, 11:14:39 - v1.00.00
//@xdoc-end
//================================================================================

C_POINTER:C301($1; $vp_datePtr)
C_POINTER:C301($2; $vp_timePtr)
C_LONGINT:C283($3; $vl_timeOffsetSeconds)

If (Count parameters:C259>2)
	$vp_datePtr:=$1
	$vp_timePtr:=$2
	$vl_timeOffsetSeconds:=$3
	
	ASSERT:C1129(Type:C295($vp_datePtr->)=Is date:K8:7)
	ASSERT:C1129(Type:C295($vp_timePtr->)=Is time:K8:8)
	
	If ($vl_timeOffsetSeconds#0)
		
		C_DATE:C307($vd_date)
		C_TIME:C306($vh_time)
		$vd_date:=$vp_datePtr->
		$vh_time:=$vp_timePtr->
		
		C_LONGINT:C283($vl_temp)
		$vl_temp:=$vl_timeOffsetSeconds+$vh_time
		
		//86400 = 24*60*60 
		$vd_date:=$vd_date+($vl_temp\86400)
		If ($vl_temp>=0)
			$vh_time:=($vl_temp%86400)
		Else 
			$vh_time:=86400+($vl_temp%86400)
		End if 
		
		$vp_datePtr->:=$vd_date
		$vp_timePtr->:=$vh_time
		
	End if 
	
End if 

