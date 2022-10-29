//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

//================================================================================
//@xdoc-start : en
//@name : DAT_localTimeZoneOffsetSeconds
//@scope : public
//@deprecated : no
//@description : This function returns the current gmt timeshift in seconds (the difference with the GMT/UTC zone)
//@parameter[0-OUT-gmtTimeshift-LONGINT] : GMT timeshift
//@parameter[1-IN-winterTimeSummerTime-BOOLEAN] : if true, take into account winter time / summer time (using current date) otherwise use 1 jan of current year. Default True.
//@notes : 
//@example : DAT_localTimeZoneOffsetSeconds
//If local time is GMT   =>     0
//If local time is GMT+1 =>  3600 (winter time in CET/Paris zone for instance)
//If local time is GMT+2 =>  7200 (summer time in CET/Paris zone for instance)
//If local time is GMT-1 => -3600
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 25/09/2012, 08:01:52 - v1.00.00
//@xdoc-end
//================================================================================

//DAT_tsGmtShiftSeconds => 7200

C_LONGINT:C283($0; $vl_gmtShift)
C_BOOLEAN:C305($1; $vb_winterTimeSummerTime)  //winter time / summer time

If (Count parameters:C259=0)
	$vb_winterTimeSummerTime:=True:C214
Else 
	$vb_winterTimeSummerTime:=$1
End if 

C_DATE:C307($vd_dateRef)
If ($vb_winterTimeSummerTime)
	$vd_dateRef:=Current date:C33
Else 
	// 1st jan of current year (must be winter time in northern hemisphere)
	C_LONGINT:C283($vl_year)
	$vl_year:=Year of:C25(Current date:C33)
	$vd_dateRef:=Add to date:C393(!00-00-00!; $vl_year; 1; 1)  // => 1 jan of $vl_year
	
	//$vd_dateRef:=!01/01/2012!
	
	//$vd_dateRef:=Ajouter a date(!00/00/00!;Annee de(Date du jour);1;1)
End if 

C_DATE:C307($vd_localDate)
C_TIME:C306($vh_localTime)
$vd_localDate:=$vd_dateRef
$vh_localTime:=?00:00:00?

C_TEXT:C284($vt_timestampGmt)
$vt_timestampGmt:=String:C10($vd_localDate; ISO date GMT:K1:10; $vh_localTime)  // !27/05/2014!  ?09:41:16? => "2014-05-27T07:41:16Z" gmt/zulu (GMT +2:00 in paris / summer time)

$vt_timestampGmt:=Substring:C12($vt_timestampGmt; 1; 19)  //remove the "Z"

C_DATE:C307($vd_gmtDate)
C_TIME:C306($vh_gmtTime)
XML DECODE:C1091($vt_timestampGmt; $vd_gmtDate)
XML DECODE:C1091($vt_timestampGmt; $vh_gmtTime)

//C_DATE($vd_gmtDate)
//C_HEURE($vh_gmtTime)
//
//C_TEXTE($vt_gmtTimeStr)
//  //$vt_gmtTimeStr:=AP Timestamp to GMT ($vd_localDate;$vh_localTime;$vd_gmtDate;$vh_gmtTime)
//$vt_gmtTimeStr:=AP Timestamp to GMT ($vd_localDate;$vh_localTime;$vd_gmtDate;$vh_gmtTime)

//DAT_utcDateTimeGet

C_LONGINT:C283($vl_localTs; $vl_gmtTs)
//$vl_localTs:=(($vd_localDate-$vd_dateRef)*86400)+($vh_localTime-$vh_refTime)
$vl_localTs:=(($vd_localDate-$vd_dateRef)*86400)
//$vl_gmtTs:=(($vd_gmtDate-$vd_dateRef)*86400)+($vh_gmtTime-$vh_refTime)
$vl_gmtTs:=(($vd_gmtDate-$vd_dateRef)*86400)+$vh_gmtTime

$vl_gmtShift:=$vl_localTs-$vl_gmtTs

$0:=$vl_gmtShift
