//%attributes = {"invisible":true,"shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : ENV_isComponent
  //@scope : public
  //@deprecated : no
  //@description : This function returns true if it is called within a component 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@notes : this methode cannot (by definition) be used as a component...
  //@example : ENV__isComponent 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 12/10/2010, 11:27:34 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_isComponent)

C_TEXT:C284($vt_structureFile)
$vt_structureFile:=Structure file:C489
  //Macintosh HD:Users:ble:Documents:Projets:4D for OCI:Components v11:src:ociLib_component.4dbase:ociLib_component.4DB

C_TEXT:C284($vt_hostStructureFile)
$vt_hostStructureFile:=Structure file:C489(*)
  //Macintosh HD:Users:ble:Documents:Projets:4D for OCI:Components v11:src:ociLib_component.4dbase:ociLib_component.4DB

$vb_isComponent:=($vt_structureFile#$vt_hostStructureFile)

$0:=$vb_isComponent