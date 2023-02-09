//%attributes = {"invisible":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : ERR_onErrToObject
//@scope : private 
//@deprecated : no
//@description : Thisfunction gets information about the error context and returns an object
//@parameter[0-OUT-error-TEXT] : error object
//@notes : 
//@example : ERR_onErrToObject
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2023
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 12/01/2023, 05:57:41 - 1.00.00
//@xdoc-end
//================================================================================

var $0; $vo_error : Object

C_LONGINT:C283(error; Error line)  // cannot declare as "var" because space in variable name
C_TEXT:C284(Error method; Error formula)

If (error#0)
	
	var $vl_error; $vl_errorLine : Integer
	var $vt_errorMethod; $vt_errorFormula : Text
	
	$vl_error:=error
	$vl_errorLine:=Error line
	$vt_errorMethod:=Error method
	$vt_errorFormula:=Error formula  // 4D v15 R4+
	
	var $vt_procName : Text
	var $vl_procStatus; $vl_procTime : Integer
	
	PROCESS PROPERTIES:C336(Current process:C322; $vt_procName; $vl_procStatus; $vl_procTime)
	
	var $vo_error : Object
	$vo_error:=New object:C1471
	$vo_error.error:=$vl_error
	$vo_error.errorLine:=$vl_errorLine
	$vo_error.errorMethod:=$vt_errorMethod
	$vo_error.errorFormula:=$vt_errorFormula
	$vo_error.timestampUtc:=Timestamp:C1445
	$vo_error.process:=Current process:C322
	$vo_error.processName:=Current process name:C1392
	$vo_error.processState:=$vl_procStatus
	$vo_error.processTime:=$vl_procTime
	$vo_error.errorStack:=New collection:C1472
	$vo_error.callChain:=Get call chain:C1662  // 4D v17 R6 +
	
	ARRAY LONGINT:C221($tl_errorCodes; 0)
	ARRAY TEXT:C222($tt_intCompArray; 0)
	ARRAY TEXT:C222($tt_errorText; 0)
	
	GET LAST ERROR STACK:C1015($tl_errorCodes; $tt_intCompArray; $tt_errorText)
	
	ARRAY TO COLLECTION:C1563($vo_error.errorStack; \
		$tl_errorCodes; "codes"; \
		$tt_intCompArray; "intComp"; \
		$tt_errorText; "text")
	
	ARRAY LONGINT:C221($tl_errorCodes; 0)
	ARRAY TEXT:C222($tt_intCompArray; 0)
	ARRAY TEXT:C222($tt_errorText; 0)
End if 

$0:=$vo_error