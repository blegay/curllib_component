//%attributes = {"invisible":true,"shared":false}
C_TEXT:C284($1;$vt_devNullErrHdlr)  //error handler (to /dev/null)
C_POINTER:C301($2;$vp_dbgMethodNamePtr)  //interprocess variable containing the name of méthod to execute (◊vt_curl_dbgMethodName)

If (Count parameters:C259>1)
	$vt_devNullErrHdlr:=$1
	$vp_dbgMethodNamePtr:=$2
	
	
	  //The standard DBG component module debug with DateTimeLine...
	C_TEXT:C284($vt_methodName)
	$vt_methodName:="DBG_module_Debug_DateTimeLine"
	
	C_LONGINT:C283($vl_DBG_methodExist)
	
	  //NOTE : the command "AP Does method exist" only works for current database, not for components
	  //$vl_DBG_methodExist:=AP Does method exist ($vt_methodName)
	
	  //get the current error handler
	C_TEXT:C284($vt_errHdlr)
	$vt_errHdlr:=Method called on error:C704
	
	  //place a error handler which will ignore errors
	ON ERR CALL:C155($vt_devNullErrHdlr)  //("curl__errHdlrToDevNull")
	
	  //The method DBG_componentVersionGet exists on the DBG component
	  //If the DBG component is installed, this will return the DBG component version
	  //and the ok variable will be set to 1
	  //If the compoent is not installed, an error will be thrown (but intercepted and ignores)
	  //and the ok variable will be set to 0
	C_TEXT:C284($vt_dbg_version)
	EXECUTE METHOD:C1007("DBG_componentVersionGet";$vt_dbg_version)
	$vl_DBG_methodExist:=ok
	
	  //restore the initial error handler
	ON ERR CALL:C155($vt_errHdlr)
	
	If ($vl_DBG_methodExist=1)
		  //If the component is installed, we set the name of the DBG component method to execute into an interprcess variable
		  //The calls to curl__moduleDebugDateTimeLine will be passed on to DBG_module_Debug_DateTimeLine from DBG component.
		  //◊vt_curl_dbgMethodName:=$vt_methodName
		$vp_dbgMethodNamePtr->:=$vt_methodName
	Else 
		  //If the component is not installed, we leave the interprcess variable empty. 
		  //The calls to curl__moduleDebugDateTimeLine will not be passed to the DBG component.
		  //◊vt_curl_dbgMethodName:=""
		$vp_dbgMethodNamePtr->:=""
	End if 
	
	
	
End if 
