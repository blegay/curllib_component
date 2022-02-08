//%attributes = {"invisible":true,"shared":false}
C_LONGINT:C283($1;$vl_level)
C_TEXT:C284($2;$vt_methodName)
C_TEXT:C284($3;$vt_debugMessage)
C_TEXT:C284($4;$vt_moduleCode)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	$vl_level:=$1
	$vt_methodName:=$2
	$vt_debugMessage:=$3
	
	Case of 
		: ($vl_nbParam=3)
			$vt_moduleCode:="curl"
		Else 
			$vt_moduleCode:=$4
	End case 
	
	C_TEXT:C284($vt_dbgMethodName)
	$vt_dbgMethodName:=Storage:C1525.curl.dbgMethodName
	
	Case of 
		: (Storage:C1525.curl.useLogsSaveDebug)
			C_TEXT:C284($vt_ident;$vt_messagetype;$vt_message)
			$vt_ident:=$vt_moduleCode
			$vt_message:=$vt_methodName+" - "+$vt_debugMessage
			
			Case of 
				: ($vl_level=2)
					$vt_messagetype:="ERROR"
					
				: ($vl_level=4)
					$vt_messagetype:="INFO"
					
				: ($vl_level=6)
					$vt_messagetype:="DEBUG"
				Else 
					  //:($vl_level=2)
					
					$vt_messagetype:=String:C10($vl_level)
			End case 
			
			EXECUTE METHOD:C1007("logs_save_debug";*;$vt_ident;$vt_messagetype;$vt_message)
			
		: (Length:C16($vt_dbgMethodName)>0)
			EXECUTE METHOD:C1007($vt_dbgMethodName;*;$vt_moduleCode;$vl_level;$vt_methodName;$vt_debugMessage)
			
	End case 
	
End if 
