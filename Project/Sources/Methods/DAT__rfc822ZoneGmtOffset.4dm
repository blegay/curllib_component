//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
// see http://www.w3.org/Protocols/rfc822/#z28

C_TIME:C306($0; $vh_gmtTimeShift)
C_TEXT:C284($1; $vt_zone)

$vh_gmtTimeShift:=?00:00:00?
If (Count parameters:C259>0)
	$vt_zone:=$1
	
	If (Length:C16($vt_zone)>0)
		
		Case of 
			: ($vt_zone="GMT")  // Greenwich meridian time
			: ($vt_zone="UT")  // Universal Time
			: ($vt_zone="Z")  // Military "zulu" = UT
				
			: ($vt_zone="M")  // Military M:-12
				$vh_gmtTimeShift:=?00:00:00?-?12:00:00?
				
			: ($vt_zone="N")  // Military N:+1
				$vh_gmtTimeShift:=?01:00:00?
				
			: ($vt_zone="Y")  // Military Y:+12
				$vh_gmtTimeShift:=?12:00:00?
				
			: ($vt_zone="EST")  // Eastern Standard Time : -5
				$vh_gmtTimeShift:=?00:00:00?-?05:00:00?
			: ($vt_zone="EDT")  // Eastern Daylight Time : -4
				$vh_gmtTimeShift:=?00:00:00?-?04:00:00?
				
			: ($vt_zone="CST")  // Central Standard Time : -6
				$vh_gmtTimeShift:=?00:00:00?-?06:00:00?
			: ($vt_zone="CDT")  // Central Daylight Time : -5
				$vh_gmtTimeShift:=?00:00:00?-?05:00:00?
				
			: ($vt_zone="MST")  // Mountain Standard Time : -7
				$vh_gmtTimeShift:=?00:00:00?-?07:00:00?
			: ($vt_zone="MDT")  // Mountain Daylight Time : -6
				$vh_gmtTimeShift:=?00:00:00?-?06:00:00?
				
			: ($vt_zone="PST")  // Pacific Standard Time : -8
				$vh_gmtTimeShift:=?00:00:00?-?08:00:00?
			: ($vt_zone="PDT")  // Pacific Daylight Time : -7
				$vh_gmtTimeShift:=?00:00:00?-?07:00:00?
				
			: (Length:C16($vt_zone)>4)
				C_TEXT:C284($vt_gmtTimeShift)
				$vt_gmtTimeShift:=Substring:C12($vt_zone; 1; 5)
				
				C_TEXT:C284($vt_regex)
				$vt_regex:="^[\\+\\-]\\d{4}$"  // a string starting with "+" or "-" followed by 4 digits
				//$vt_regex:="^(?:\\+|\\-)\\d{4}$"  // a string starting with "+" or "-" followed by 4 digits (achieved with non matching group and a "or")
				If (Match regex:C1019($vt_regex; $vt_gmtTimeShift))
					//Si (($vt_gmtTimeShift‚â§1‚â•="+") | ($vt_gmtTimeShift‚â§1‚â•="-"))
					
					$vh_gmtTimeShift:=Time:C179(Substring:C12($vt_gmtTimeShift; 2; 2)+":"+Substring:C12($vt_gmtTimeShift; 4; 2)+":00")
					
					If ($vt_gmtTimeShift[[1]]="-")
						$vh_gmtTimeShift:=?00:00:00?-$vh_gmtTimeShift
					End if 
				End if 
				
			Else 
				ASSERT:C1129(False:C215; "invalid time zone for RFC 822 "+$vt_zone)
		End case 
		
	End if 
	
End if 
$0:=$vh_gmtTimeShift