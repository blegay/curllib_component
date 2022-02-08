//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL__ratio
  //@scope : private 
  //@deprecated : no
  //@description : This function is a ratio formatter
  //@parameter[0-OUT-ratio-TEXT] : ratio formatted e.g. "80,2 %"
  //@parameter[1-IN-reference-REAL] : reference/max possible value
  //@parameter[2-IN-value-REAL] : ParamDescription (not modified)
  //@parameter[3-IN-nbDecimal-LONGINT] : nb decimal (optionnal, default value : 1)
  //@notes : 
  //@example : dbg_ratio(pi;pi/3) => "33,3 %" 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 08/02/2022, 19:07:44 - 3.00.02
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_ratio)  //ratio : "80,2 %"
C_REAL:C285($1;$vr_reference)  //reference
C_REAL:C285($2;$vr_value)  //value
C_LONGINT:C283($3;$vl_nbDecimal)  //nb decimal (optionnal, default 1)

$vt_ratio:=""

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>1)
	$vr_reference:=$1
	$vr_value:=$2
	
	Case of 
		: ($vl_nbParam=2)
			$vl_nbDecimal:=1
			
		Else 
			  //: ($vl_nbParam=2)
			$vl_nbDecimal:=$3
	End case 
	
	
	C_TEXT:C284($vt_format)
	If ($vl_nbDecimal>0)
		$vt_format:="# ##0."+("0"*$vl_nbDecimal)
	Else 
		$vt_format:="# ##0"
	End if 
	
	C_REAL:C285($vr_ratio)
	$vr_ratio:=Round:C94(($vr_value/$vr_reference)*100;$vl_nbDecimal)
	
	  //Si (Dec($vr_ratio)=0)
	  //$vt_ratio:=Chaine($vr_ratio;"# ##0")+" %"
	  //Sinon 
	$vt_ratio:=String:C10($vr_ratio;$vt_format)+" %"
	  //Fin de si 
	
End if 
$0:=$vt_ratio
