//%attributes = {"invisible":true,"preemptive":"incapable"}
//================================================================================
//@xdoc-start : en
//@name : CURL__initStorage
//@scope : private 
//@deprecated : no
//@description : This method inits the storage for the component
//@notes : 
//@example : CURL__initStorage
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 19/10/2022, 21:51:48 - 2.00.05
//@xdoc-end
//================================================================================

C_TEXT:C284($vt_debugMethodName)
$vt_debugMethodName:=""

ARRAY TEXT:C222($tt_componentsList; 0)
COMPONENT LIST:C1001($tt_componentsList)
If (Find in array:C230($tt_componentsList; "dbg_component")>0)
	$vt_debugMethodName:="DBG_module_Debug_DateTimeLine"
End if 

C_BOOLEAN:C305($vb_progressComponentInstalled)
$vb_progressComponentInstalled:=(Find in array:C230($tt_componentsList; "4D Progress")>0)

ARRAY TEXT:C222($tt_componentsList; 0)

C_BOOLEAN:C305($vb_logsSaveDebugExists)
$vb_logsSaveDebugExists:=UTL__isMethod("logs_save_debug")

Use (Storage:C1525)
	Storage:C1525.curl:=New shared object:C1526(\
		"debugMethodName"; $vt_debugMethodName; \
		"init"; False:C215; \
		"useLogsSaveDebug"; $vb_logsSaveDebugExists; \
		"progressComponentInstalled"; $vb_progressComponentInstalled)
End use 
