//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__executablePathGet_
//@scope : public
//@deprecated : yes
//@description : This function returns curl executable path (e.g. "/Users/ble/Documents/Projets/BaseRef_v15/curllib_component/source/curllib_component.4dbase/Plugins/cURL.bundle/Contents/MacOS/curl")
//@parameter[0-OUT-$vt_executablePath-TEXT] : curl executable path
//@notes : 
//@example : CURL__executablePathGet_
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 15:58:38 - 1.00.08
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_executablePath)

//$vt_executablePath:=cURL Get executable

$0:=$vt_executablePath