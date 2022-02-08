//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_OBJECT:C1216($1;$vo_object)
C_TEXT:C284($2;$vt_propertyName)
C_VARIANT:C1683($3;$vv_value)
C_BOOLEAN:C305($4;$vb_override)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")

$vo_object:=$1
$vt_propertyName:=$2
$vv_value:=$3

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>3)
	$vb_override:=$4
Else 
	$vb_override:=True:C214
End if 

C_BOOLEAN:C305($vb_set)
If (OB Is defined:C1231($vo_object;$vt_propertyName))
	$vb_set:=$vb_override
Else 
	$vb_set:=True:C214
End if 

If ($vb_set)
	OB SET:C1220($vo_object;$vt_propertyName;$vv_value)
End if 
