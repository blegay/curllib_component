//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : UTL__methodListGet
//@scope : public
//@deprecated : no
//@description : This method will get a list of method into an array
//@parameter[1-OUT-methodListArrayPtr-POINTER] : pointer to a text array (modified)
//@parameter[2-IN-filter-TEXT] : filter (optional)
//@notes : v13 up
//@example : 
//  TEXT ARRAY($tt_methodNameList;0)
//  UTL__methodListGet (->$tt_methodNameList)
//
//  TEXT ARRAY($tt_methodNameList;0)
//  UTL__methodListGet (->$tt_methodNameList;"TXT_@")
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 30/10/2008, 11:46:40 - v1.00.00
//@xdoc-end
//================================================================================

C_POINTER:C301($1; $vp_methodListArrayPtr)  //method list array pointer
C_TEXT:C284($2; $vt_filter)  //optional filter

C_LONGINT:C283($vl_nbParams)
$vl_nbParams:=Count parameters:C259
If ($vl_nbParams>0)
	
	$vp_methodListArrayPtr:=$1
	
	
	Case of 
		: ($vl_nbParams=1)
			$vt_filter:=""
			
		Else 
			$vt_filter:=$2
	End case 
	
	//check array type
	If (Type:C295($vp_methodListArrayPtr->)=Text array:K8:16)
		
		ARRAY TEXT:C222($tt_methodList; 0)
		
		C_BOOLEAN:C305($vb_isComponent)
		$vb_isComponent:=ENV_isComponent
		If ($vb_isComponent)
			//the method is called as a component method, we will retun the host database method list
			If (Length:C16($vt_filter)=0)  //no filter
				METHOD GET NAMES:C1166($tt_methodList; *)
			Else 
				METHOD GET NAMES:C1166($tt_methodList; $vt_filter; *)
			End if 
			
		Else 
			//the method is not callled from a component
			If (Length:C16($vt_filter)=0)  //no filter
				METHOD GET NAMES:C1166($tt_methodList)
			Else 
				METHOD GET NAMES:C1166($tt_methodList; $vt_filter)
			End if 
			
		End if 
		
		//%W-518.1
		COPY ARRAY:C226($tt_methodList; $vp_methodListArrayPtr->)
		//%W+518.7
		
		ARRAY TEXT:C222($tt_methodList; 0)
		
	End if 
	
End if 
