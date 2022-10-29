//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : HTTP__range
  //@scope : public
  //@deprecated : no
  //@description : This function returns a range http header
  //@parameter[0-OUT-rangeHeader-TEXT] : range header (e.g. : "Range: bytes=0-499")
  //@parameter[1-IN-offset-REAL] : offset
  //@parameter[2-IN-bufferSize-REAL] : range size
  //@parameter[3-IN-maxSize-REAL] : max size
  //@notes : 
  //@example : HTTP__range
  //@see : http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 18/09/2017, 19:36:02 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_rangeHeader)
C_REAL:C285($1;$vr_offset)
C_REAL:C285($2;$vr_bufferSize)
C_REAL:C285($3;$vr_maxSize)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")

$vr_offset:=$1
$vr_bufferSize:=$2
$vr_maxSize:=$3

C_REAL:C285($vr_startOffset;$vr_endOffset)
$vr_startOffset:=$vr_offset
$vr_endOffset:=$vr_startOffset+$vr_bufferSize-1

If ($vr_endOffset<$vr_maxSize)
	$vt_rangeHeader:="Range: bytes="+String:C10($vr_offset)+"-"+String:C10($vr_endOffset)
Else 
	$vt_rangeHeader:="Range: bytes="+String:C10($vr_offset)+"-"
End if 

  //AWS__log(Current method name+" offset : "+String($vr_offset)+", range size : "+String($vr_bufferSize)+", max size : "+String($vr_maxSize)+" => \""+$vt_rangeHeader+"\"")

$0:=$vt_rangeHeader