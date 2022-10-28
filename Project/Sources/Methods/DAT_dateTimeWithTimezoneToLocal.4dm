//%attributes = {"invisible":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : DAT_dateTimeWithTimezoneToLocal
//@scope : public
//@deprecated : no
//@description : This method applies a time offset (in seconds) to a date and time
//@parameter[1-INOUT-datePtr-POIINTER] : date pointer (modified)
//@parameter[2-INOUT-timePtr-POINTER] : time pointer (modified)
//@parameter[3-IN-timezoneStr-TEXT] : source timezone (according to rfc822)
//@notes :
//   see http://www.w3.org/Protocols/rfc822/#z28
//@example : DAT_dateTimeWithTimezoneToLocal¬†
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 25/08/2015, 11:14:39 - v1.00.00
//@xdoc-end
//================================================================================

C_POINTER:C301($1; $vp_datePtr)
C_POINTER:C301($2; $vp_timePtr)
C_TEXT:C284($3; $vt_timezone)

If (Count parameters:C259>2)
	$vp_datePtr:=$1
	$vp_timePtr:=$2
	$vt_timezone:=$3
	
	ASSERT:C1129(Type:C295($vp_datePtr->)=Is date:K8:7)
	ASSERT:C1129(Type:C295($vp_timePtr->)=Is time:K8:8)
	
	C_TIME:C306($vh_sourceTimezoneOffset; $vh_localTimezoneOffset)
	$vh_sourceTimezoneOffset:=DAT__rfc822ZoneGmtOffset($vt_timezone)
	$vh_localTimezoneOffset:=DAT_localTimeZoneOffsetSeconds
	
	C_LONGINT:C283($vl_timezoneOffsetInSeconds)
	$vl_timezoneOffsetInSeconds:=$vh_localTimezoneOffset-$vh_sourceTimezoneOffset
	
	If ($vl_timezoneOffsetInSeconds#0)
		DAT__dateTimeZoneOffsetApply($vp_datePtr; $vp_timePtr; $vl_timezoneOffsetInSeconds)
	End if 
	
End if 