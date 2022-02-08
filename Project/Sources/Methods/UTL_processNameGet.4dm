//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_processNameGet
  //@scope : private 
  //@attributes :    
  //@deprecated : no
  //@description : This function returns the process name for a given process no (or the current process)
  //@parameter[0-OUT-processName-TEXT] : process name
  //@parameter[1-IN-processNo-LONGINT] : process no (optional, default current process no)
  //@notes : 
  //@example : UTL_processNameGet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 11/01/2021, 10:36:52 - 2.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_processName)  //nom du process
C_LONGINT:C283($1;$vl_processNo)  //numéro du process

$vt_processName:=""

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

Case of 
	: ($vl_nbParam=0)
		$vl_processNo:=Current process:C322
		
	Else 
		  //: ($vl_nbParam=1)
		$vl_processNo:=$1
End case 

C_LONGINT:C283($vl_status)
C_LONGINT:C283($vl_elapsedTicks)
  //C_BOOLEEN($vb_visible)
  //C_ENTIER($ve_uniqueId)
  //C_ENTIER LONG($vl_origin)

PROCESS PROPERTIES:C336($vl_processNo;$vt_processName;$vl_status;$vl_elapsedTicks)  //;$vb_visible;$ve_uniqueId;$vl_origin)
Case of 
	: ($vl_status=Aborted:K13:1)
		$vt_processName:="??? (détruit)"
		
	: ($vl_status=Does not exist:K13:3)
		$vt_processName:="??? (inexistant)"
End case 

$0:=$vt_processName