//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
//================================================================================
//@xdoc-start : en
//@name : ERR_onErrCall
//@scope : private
//@deprecated : no
//@description : This method is the error handler to trap errors and log them
//@notes : 
//@example : ERR_onErrCall
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 23/06/2018, 11:40:58 - 1.00.00
//@xdoc-end
//================================================================================

var $vo_error : Object

$vo_error:=ERR_onErrToObject

If ($vo_error#Null:C1517)
	CURL__moduleDebugDateTimeLine(2; Current method name:C684; "error : "+JSON Stringify:C1217($vo_error))
End if 