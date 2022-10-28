//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

//================================================================================
//@xdoc-start : en
//@name : DAT_rfc1123ToIso8601
//@scope : public
//@deprecated : no
//@description : This function converts a http timestamp (rfc 1123 e.g. "Fri, 10 Feb 2017 04:52:24 GMT") into iso 8601 (e.g. "2017-02-10T04:52:24Z")
//@parameter[0-OUT-iso8601-TEXT] : timestamp string in iso8601 format
//@parameter[1-IN-rfc1123-TEXT] : timestamp string in rfc1123 format
//@notes :
//@example : 
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 04:52:24 GMT")="2017-02-10T04:52:24Z")
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 04:52:24 PDT")="2017-02-10T11:52:24Z")
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 22:52:24 PDT")="2017-02-11T05:52:24Z")
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 00:52:24 +0100")="2017-02-09T23:52:24Z")
//
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 23:59:59 +0100")="2017-02-10T22:59:59Z")
//
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 23:59:59 -0100")="2017-02-11T00:59:59Z")
//
// ASSERT(DAT_rfc1123ToIso8601 ("Fri, 10 Feb 2017 23:59:59 +0000")="2017-02-10T23:59:59Z")
//
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 10/02/2017, 10:24:16 - v1.00.00
//@xdoc-
//================================================================================

C_TEXT:C284($0; $vt_iso8601)
C_TEXT:C284($1; $vt_rfc1123)

$vt_rfc1123:=$1

If (Length:C16($vt_rfc1123)>0)
	
	C_DATE:C307($vd_date)
	C_TIME:C306($vh_time)
	C_TEXT:C284($vt_timezone)
	If (DAT_rfc1123ToDatTimeZone($vt_rfc1123; ->$vd_date; ->$vh_time; ->$vt_timezone))
		
		// e.g. "GMT"
		Case of 
			: ($vt_timezone="GMT")
			: ($vt_timezone="UT")
			: ($vt_timezone="Z")
			: ($vt_timezone="+0000")
				//: ($vt_timezone="-0000")
			Else 
				C_TIME:C306($vh_timeShift)
				$vh_timeShift:=DAT__rfc822ZoneGmtOffset($vt_timezone)
				
				$vh_time:=$vh_time-$vh_timeShift
				Case of 
					: ($vh_time<?00:00:00?)  // substract a day
						$vd_date:=Add to date:C393($vd_date; 0; 0; -1)
						$vh_time:=$vh_time+86400
						
					: ($vh_time>=86400)  // add a day
						$vd_date:=Add to date:C393($vd_date; 0; 0; 1)
						$vh_time:=$vh_time-86400
						
				End case 
				
		End case 
		
		$vt_iso8601:=""
		$vt_iso8601:=$vt_iso8601+String:C10(Year of:C25($vd_date); "0000")+"-"
		$vt_iso8601:=$vt_iso8601+String:C10(Month of:C24($vd_date); "00")+"-"
		$vt_iso8601:=$vt_iso8601+String:C10(Day of:C23($vd_date); "00")+"T"
		$vt_iso8601:=$vt_iso8601+Time string:C180($vh_time)+"Z"
		
	Else 
		ASSERT:C1129(False:C215; "invalid rfc1123 format \""+$vt_rfc1123+"\"")
	End if 
End if 

$0:=$vt_iso8601