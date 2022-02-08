//%attributes = {"invisible":true,"shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : DAT_rfc1123ToDatTimeZone
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[1-IN-rfc1123-TEXT] : date/time timestamp in rfc1123 format (e.g. "Fri, 10 Feb 2017 04:52:24 GMT"
  //@parameter[2-IN-datePtr-POINTER] : date pointer (optional, modified)
  //@parameter[3-OUT-timePtr-POINTER] : time pointer (optional, modified)
  //@parameter[4-OUT-zonePtr-POINTER] : zone text pointer (optional, modified)
  //@notes :
  //@example : DAT_rfc1123ToDatTimeZone 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/09/2017, 14:30:36 - v1.00.00
  //@xdoc-
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_rfc1123)
C_POINTER:C301($2;$vp_datePtr)
C_POINTER:C301($3;$vp_timePtr)
C_POINTER:C301($4;$vp_zonePtr)

$vb_ok:=False:C215

ASSERT:C1129(Count parameters:C259>1;"requires 2 or more paramters")
C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	
	$vt_rfc1123:=$1
	$vp_datePtr:=$2
	Case of 
		: ($vl_nbParam=2)
		: ($vl_nbParam=3)
			$vp_timePtr:=$3
			
		: ($vl_nbParam=4)
			$vp_timePtr:=$3
			$vp_zonePtr:=$4
	End case 
	
	C_DATE:C307($vd_date)
	C_TIME:C306($vh_time)
	C_TEXT:C284($vt_timezone)
	
	C_TEXT:C284($vt_regex)
	$vt_regex:="^(?:Sun|Mon|Tue|Wed|Thu|Fri|Sat), (\\d{2}) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) (\\d{4}) (\\d{2}:\\d{2}:\\d{2}) (GMT|UT|Z|M|N|Y|EST|EDT|CST|CDT|MST|MDT|PST|PDT|[\\+\\-]\\d{4})$"
	  //$vt_regex:="^(?:Sun|Mon|Tue|Wed|Thu|Fri|Sat), (\\d{2}) (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) (\\d{4}) (\\d{2}:\\d{2}:\\d{2}) (.*)$"
	
	  // "Fri, 10 Feb 2017 04:52:24 GMT" =>  "2017-02-10T04:52:24Z"
	
	  //"Sun|Mon|Tue|Wed|Thu|Fri|Sat"
	  //"Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec"
	
	If (Length:C16($vt_rfc1123)>0)
		C_LONGINT:C283($vl_start)
		$vl_start:=1
		ARRAY LONGINT:C221($tl_pos;0)
		ARRAY LONGINT:C221($tl_length;0)
		
		$vb_ok:=Match regex:C1019($vt_regex;$vt_rfc1123;$vl_start;$tl_pos;$tl_length)
		If ($vb_ok)
			
			  //TABLEAU TEXTE($tt_americanDayString;7)
			  //$tt_americanDayString{Dimanche}:="Sun"  //1
			  //$tt_americanDayString{Lundi}:="Mon"  //2
			  //$tt_americanDayString{Mardi}:="Tue"  //3
			  //$tt_americanDayString{Mercredi}:="Wed`4"
			  //$tt_americanDayString{Jeudi}:="Thu"  //5
			  //$tt_americanDayString{Vendredi}:="Fri"  //6
			  //$tt_americanDayString{Samedi}:="Sat"  //7
			
			ARRAY TEXT:C222($tt_americanMonthString;12)
			$tt_americanMonthString{January:K10:1}:="Jan"  //1
			$tt_americanMonthString{February:K10:2}:="Feb"  //2
			$tt_americanMonthString{March:K10:3}:="Mar"  //3
			$tt_americanMonthString{April:K10:4}:="Apr"  //4
			$tt_americanMonthString{May:K10:5}:="May"  //5
			$tt_americanMonthString{June:K10:6}:="Jun"  //6
			$tt_americanMonthString{July:K10:7}:="Jul"  //7
			$tt_americanMonthString{August:K10:8}:="Aug"  //8
			$tt_americanMonthString{September:K10:9}:="Sep"  //9
			$tt_americanMonthString{October:K10:10}:="Oct"  //10
			$tt_americanMonthString{November:K10:11}:="Nov"  //11
			$tt_americanMonthString{December:K10:12}:="Dec"  //12
			
			C_TEXT:C284($vt_year)
			$vt_year:=Substring:C12($vt_rfc1123;$tl_pos{3};$tl_length{3})
			  // e.g. "2017"
			
			C_TEXT:C284($vt_monthStr;$vt_month)
			$vt_monthStr:=Substring:C12($vt_rfc1123;$tl_pos{2};$tl_length{2})
			  // e.g. "Feb"
			
			C_LONGINT:C283($vl_month)
			$vl_month:=Find in array:C230($tt_americanMonthString;$vt_monthStr)
			ASSERT:C1129($vl_month>0;"month \""+$vt_monthStr+"\"not found")
			$vt_month:=String:C10($vl_month;"00")
			  // e.g. "02"
			
			C_TEXT:C284($vt_day)
			$vt_day:=Substring:C12($vt_rfc1123;$tl_pos{1};$tl_length{1})
			  // e.g. "10"
			
			
			C_TEXT:C284($vt_time)
			$vt_time:=Substring:C12($vt_rfc1123;$tl_pos{4};$tl_length{4})
			  // e.g. "04:52:24"
			
			$vd_date:=Add to date:C393(!00-00-00!;Num:C11($vt_year);$vl_month;Num:C11($vt_day))
			
			C_TIME:C306($vh_time)
			$vh_time:=Time:C179($vt_time)
			
			$vt_timezone:=Substring:C12($vt_rfc1123;$tl_pos{5};$tl_length{5})
			
		End if 
		
	End if 
	
	$vp_datePtr->:=$vd_date
	Case of 
		: ($vl_nbParam=2)
		: ($vl_nbParam=3)
			$vp_timePtr->:=$vh_time
			
		: ($vl_nbParam=4)
			$vp_timePtr->:=$vh_time
			$vp_zonePtr->:=$vt_timezone
	End case 
	
	
End if 
$0:=$vb_ok