//%attributes = {"invisible":true,"shared":false}
  //CURL__debugMilliseconds
C_TEXT:C284($0;$vt_msDebug)
C_LONGINT:C283($1;$vl_ms)

ASSERT:C1129(Count parameters:C259>0;"expecting 1 parameter")

$vt_msDebug:=""
$vl_ms:=$1

$vt_msDebug:=String:C10($vl_ms/1000;"# ### ### ##0.000")+"s"

$0:=$vt_msDebug