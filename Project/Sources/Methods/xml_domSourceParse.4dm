//%attributes = {"invisible":true,"shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : xml_domSourceParse
  //@scope : public
  //@deprecated : no
  //@description : This method is a wrapper on the DOM Parse XML source command
  //@parameter[0-OUT-domRef-ALPHA 32] : xml dom root reference
  //@parameter[1-IN-xmlFilePath-TEXT] : xml file path
  //@parameter[2-IN-validate-BOOLEAN] : if TRUE validates xml, if FALSE no validation
  //@parameter[3-IN-xsdOrDtdFilePath-TEXT] : xsdOrDtdFilePath
  //@notes : This function uses a workaround for ACI0094378
  //@example : 
  //
  //C_TEXT($vt_xmlFilePath;$vt_xsdFilePath)
  //$vt_xmlFilePath:=// .xml file
  //$vt_xsdFilePath:=// .xsd file
  //C_BOOLEAN($vb_validate)
  //$vb_validate:=Vrai
  //C_ALPHA(32;$va_domRootRef)
  //$va_domRootRef:=xml_domSourceParse ($vt_xmlFilePath;$vb_validate;$vt_xsdFilePath)
  //If (xml_domRefIsValid($va_domRootRef)>0)
  // // read/write in the dom here
  //  xml_domClose ($va_domRootRef)
  //End if
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2016
  //@history : CREATION : Bruno LEGAY (BLE) - 17/04/2016, 09:52:35 - v1.00.00
  //@xdoc-
  //================================================================================

C_TEXT:C284($0;$vt_domRef)
  //C_ALPHA(32;$0;$vt_domRef)
C_TEXT:C284($1;$vt_xmlFilePath)
C_BOOLEAN:C305($2;$vb_validate)
C_TEXT:C284($3;$vt_xsdOrDtdFilePath)

ASSERT:C1129(Count parameters:C259>2;"should have 3 parameter")

$vt_xmlFilePath:=$1
$vb_validate:=$2
$vt_xsdOrDtdFilePath:=$3

  // ACI0094378 workaround
If ($vb_validate)  // copy the xsd in the temp dir (temp xsd file)
	C_TEXT:C284($vt_tempXsdPath_ACI0094378)
	xml__ACI0094378_workaround (->$vt_tempXsdPath_ACI0094378;->$vt_xsdOrDtdFilePath)
End if 

$vt_domRef:=DOM Parse XML source:C719($vt_xmlFilePath;$vb_validate;$vt_xsdOrDtdFilePath)
If (ok=1)
	
Else 
	$vt_domRef:=""
End if 

  // ACI0094378 workaround
If ($vb_validate)  // delete the temp xsd file (if necessary)
	xml__ACI0094378_workaround (->$vt_tempXsdPath_ACI0094378)
End if 

$0:=$vt_domRef