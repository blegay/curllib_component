//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : UTL__isMethod
//@scope : public
//@deprecated : no
//@description : This function will return True if a given method name is really a method
//@parameter[0-OUT-isMethod-BOOLEAN] : True if a given method name is really a method, False otherwise
//@parameter[1-IN-methodName-TEXT] : method name
//@notes : 
//@example : UTL__isMethod¬†
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008 
//@history : CREATION : Bruno LEGAY (BLE) - 12/11/2012, 01:23:36 - v1.00.00
//@xdoc-end
//================================================================================

C_BOOLEAN:C305($0; $vb_isMethod)  //is method
C_TEXT:C284($1; $vt_methodPath)  //method name

$vb_isMethod:=False:C215

C_LONGINT:C283($vl_nbParams)
$vl_nbParams:=Count parameters:C259
If ($vl_nbParams>0)
	$vt_methodPath:=$1
	
	ARRAY TEXT:C222($tt_methodList; 0)
	
	C_BOOLEAN:C305($vb_isComponent)
	$vb_isComponent:=IND__isComponent
	If ($vb_isComponent)
		//the method is called as a component method, we will retun the host database method list
		METHOD GET NAMES:C1166($tt_methodList; $vt_methodPath; *)
	Else 
		//the method is not callled from a component
		METHOD GET NAMES:C1166($tt_methodList; $vt_methodPath)
	End if 
	
	$vb_isMethod:=(Find in array:C230($tt_methodList; $vt_methodPath)>0)
	
	ARRAY TEXT:C222($tt_methodList; 0)
	
End if 
$0:=$vb_isMethod