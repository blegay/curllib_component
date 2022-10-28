//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
C_BOOLEAN:C305($0; $vb_ok)
C_TEXT:C284($1; $vt_headerLine)
C_POINTER:C301($2; $vp_keyPtr)
C_POINTER:C301($3; $vp_valuePtr)

ASSERT:C1129(Type:C295($2->)=Is text:K8:3; "$2 should be a text pointer")
ASSERT:C1129(Type:C295($3->)=Is text:K8:3; "$3 should be a text pointer")

$vb_ok:=False:C215
$vt_headerLine:=$1
$vp_keyPtr:=$2
$vp_valuePtr:=$3

C_TEXT:C284($vt_key; $vt_value)
If (Length:C16($vt_headerLine)>0)
	
	C_TEXT:C284($vt_regex)
	$vt_regex:="^(.+?): *(.*)$"  //make "key" non greedy so that "Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT" => "Wed, 20 Sep 2017 03:12:05 GMT"
	
	C_LONGINT:C283($vl_start)
	$vl_start:=1
	
	ARRAY LONGINT:C221($tl_pos; 0)
	ARRAY LONGINT:C221($tl_length; 0)
	
	If (Match regex:C1019($vt_regex; $vt_headerLine; $vl_start; $tl_pos; $tl_length; *))
		$vt_key:=Substring:C12($vt_headerLine; $tl_pos{1}; $tl_length{1})
		$vt_value:=Substring:C12($vt_headerLine; $tl_pos{2}; $tl_length{2})
		$vb_ok:=True:C214
	End if 
	
	ARRAY LONGINT:C221($tl_pos; 0)
	ARRAY LONGINT:C221($tl_length; 0)
	
End if 
$vp_keyPtr->:=$vt_key
$vp_valuePtr->:=$vt_value

$0:=$vb_ok