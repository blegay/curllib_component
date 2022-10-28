//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : IND__isComponent
//@scope : private
//@deprecated : no
//@description : This function returns True if it is called within a component 
//@parameter[0-OUT-isComponent-BOOLEAN] : is component
//@notes : this method cannot (by definition) be used as a component...
//@example : 
// If (IND__isComponent)
//    ...
// Else
//    ...
//End case¬†¬†
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 12/10/2010, 11:27:34 - v1.00.00
//@xdoc-end
//================================================================================

C_BOOLEAN:C305($0; $vb_isComponent)

C_TEXT:C284($vt_structureFile)
$vt_structureFile:=Structure file:C489
// if within a component, returns the component structure file path
// if not within a component, returns the (host) structure file path

C_TEXT:C284($vt_hostStructureFile)
$vt_hostStructureFile:=Structure file:C489(*)
// if within a component, returns the host structure file path
// if not within a component, returns the (host) structure file path

$vb_isComponent:=($vt_structureFile#$vt_hostStructureFile)

$0:=$vb_isComponent