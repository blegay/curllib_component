//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__httpStatusLineToStatus
//@scope : private
//@deprecated : no
//@description : This function returns the status from an http status line header
//@parameter[0-OUT-status-LONGINT] : http status (e.g. 200)
//@parameter[1-IN-statusLine-TEXT] : status line (e.g. "HTTP/1.1 200 OK")
//@notes :
//@example : 
// ASSERT(CURL__httpStatusLineToStatus ("HTTP/1.1 200 OK")=200)
// ASSERT(CURL__httpStatusLineToStatus ("HTTP/1.0 503")=503)
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 27/09/2017, 15:17:59 - v1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_httpStatus)
C_TEXT:C284($1; $vt_statusLine)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")
ASSERT:C1129(Length:C16($1)>0; "empty http status line")

$vl_httpStatus:=0
$vt_statusLine:=$1

// "HTTP/1.0 503"
// "HTTP/2 200"
C_TEXT:C284($vt_regex)
$vt_regex:="^HTTP/.+ ([0-9]{3}).*$"

C_LONGINT:C283($vl_start)
$vl_start:=1

ARRAY LONGINT:C221($tl_pos; 0)
ARRAY LONGINT:C221($tl_length; 0)

If (Match regex:C1019($vt_regex; $vt_statusLine; $vl_start; $tl_pos; $tl_length; *))
	$vl_httpStatus:=Num:C11(Substring:C12($vt_statusLine; $tl_pos{1}; $tl_length{1}))
End if 

ARRAY LONGINT:C221($tl_pos; 0)
ARRAY LONGINT:C221($tl_length; 0)

$0:=$vl_httpStatus