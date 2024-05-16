//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
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

C_OBJECT:C1216($vo_appInfos)
$vo_appInfos:=Get application info:C1599

C_BOOLEAN:C305($vb_isHeadless; $vb_launchedAsService; $vb_is4dServer; $vb_progressAllowed)
$vb_isHeadless:=$vo_appInfos.headless
$vb_launchedAsService:=$vo_appInfos.launchedAsService
$vb_is4dServer:=(Application type:C494=4D Server:K5:6)

//https://support.4d.com/Cases/73787
// infinite beach ball when calling cURL plugin using callback in // (in v4.1.2, 4.6.2)
// terrible when it happends on 4D server !
$vb_progressAllowed:=Not:C34($vb_isHeadless | $vb_launchedAsService | $vb_is4dServer)
//$vb_progressAllowed:=Not($vb_isHeadless | $vb_launchedAsService)

Use (Storage:C1525)
	Storage:C1525.curl:=New shared object:C1526(\
		"debugMethodName"; $vt_debugMethodName; \
		"init"; False:C215; \
		"isHeadless"; $vb_isHeadless; \
		"launchedAsService"; $vb_launchedAsService; \
		"is4dServer"; $vb_is4dServer; \
		"progressAllowed"; $vb_progressAllowed; \
		"useLogsSaveDebug"; $vb_logsSaveDebugExists; \
		"progressComponentInstalled"; $vb_progressComponentInstalled)
End use 
