//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__options
//@scope : public
//@deprecated : no
//@description : This method fills arrays of key and value options for curl from an object
//@parameter[1-INOUT-headerKeyPtr-POINTER] : curl option key longint array pointer (modified)
//@parameter[2-INOUT-headerValuePtr-POINTER] : curl option value text array pointer (modified)
//@parameter[3-IN-key-LONGINT] : key
//@parameter[4-IN-value-TEXT] : value
//@parameter[5-IN-override-BOOLEAN] : if TRUE override an existing value, if FALSE leave the existing value, (optional, default : FALSE)
//@notes : 
//@example : CURL__options
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:37:14 - 1.00.00
//@xdoc-end
//================================================================================

C_POINTER:C301($1; $vp_headerKeyPtr)
C_POINTER:C301($2; $vp_headerValuePtr)
C_LONGINT:C283($3; $vl_key)
C_TEXT:C284($4; $vt_value)
C_BOOLEAN:C305($5; $vb_override)

ASSERT:C1129(Count parameters:C259>3; "requires 4 parameters")
ASSERT:C1129(Type:C295($1->)=LongInt array:K8:19; "$1 should be a longint array pointer")
ASSERT:C1129(Type:C295($2->)=Text array:K8:16; "$1 should be a text array pointer")
ASSERT:C1129(Size of array:C274($1->)=Size of array:C274($2->); "$2-> and $2-> should be of same size")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

$vp_headerKeyPtr:=$1
$vp_headerValuePtr:=$2
$vl_key:=$3
$vt_value:=$4

If ($vl_nbParam>4)
	$vb_override:=$5
Else 
	$vb_override:=True:C214
End if 


C_LONGINT:C283($vl_found)
$vl_found:=Find in array:C230($vp_headerKeyPtr->; $vl_key)
If ($vl_found>0)
	
	If ($vb_override)
		$vp_headerValuePtr->{$vl_found}:=$vt_value
	End if 
	
Else 
	APPEND TO ARRAY:C911($vp_headerKeyPtr->; $vl_key)
	APPEND TO ARRAY:C911($vp_headerValuePtr->; $vt_value)
End if 
