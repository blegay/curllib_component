//%attributes = {"invisible":true,"preemptive":"incapable"}
//================================================================================
//@xdoc-start : en
//@name : CURL__xdocInit
//@scope : private
//@deprecated : no
//@description : This method initialize the xdoc component
//@notes : 
//@example : CURL__xdocInit
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:53:18 - 1.00.00
//@xdoc-end
//================================================================================

If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222($tt_components; 0)
	COMPONENT LIST:C1001($tt_components)
	If (Find in array:C230($tt_components; "XDOC_component")>0)
		
		//XDOC_componentPrefixSet ("S3")
		EXECUTE METHOD:C1007("XDOC_componentPrefixSet"; *; "CURL")  //"CURL")
		
		//XDOC_authorSet (1;"Bruno LEGAY (BLE)")
		EXECUTE METHOD:C1007("XDOC_authorSet"; *; 1; "Bruno LEGAY (BLE)")
		
		//XDOC_authorSet (2;"Bruno LEGAY (BLE) - Copyrights A&C Consulting "+Chaine(Annee de(Date du jour)))
		EXECUTE METHOD:C1007("XDOC_authorSet"; *; 2; "Bruno LEGAY (BLE) - Copyrights A&C Consulting - "+String:C10(Year of:C25(Current date:C33)))
		
		//XDOC_versionTagSet (AWS_componentVersionGet )
		EXECUTE METHOD:C1007("XDOC_versionTagSet"; *; CURL_componentVersionGet)
		
	End if 
	ARRAY TEXT:C222($tt_components; 0)
End if 
