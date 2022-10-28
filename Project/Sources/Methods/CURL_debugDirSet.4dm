//%attributes = {"shared":true,"preemptive":"capable"}
//================================================================================
//@xdoc-start : en
//@name : CURL_debugDirSet
//@scope : private 
//@attributes :    
//@deprecated : no
//@description : This method sets the folder debug path
//@parameter[1-IN-debugDirPath-TEXT] : folder dir path
//@notes : this applies to all processes
// CURLINFO_TEXT.log
// CURLINFO_HEADER_OUT.log
// CURLINFO_DATA_IN.log
// CURLINFO_SSL_DATA_OUT.log
// CURLINFO_SSL_DATA_IN.log
// CURLINFO_HEADER_IN.log
//@example : CURL_debugDirSet (Get 4D folder(Logs folder))
//@see : CURL_debugDirGet
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 12/01/2021, 12:37:07 - 2.00.03
//@xdoc-end
//================================================================================

C_TEXT:C284($1; $vt_debugDirPath)

ASSERT:C1129(Count parameters:C259>0)

$vt_debugDirPath:=$1

CURL__init

Case of 
	: (Length:C16($vt_debugDirPath)=0)
		
		Use (Storage:C1525.curl)
			Storage:C1525.curl.debugDirPath:=""
		End use 
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "debug off")
		
	: (Test path name:C476($vt_debugDirPath)=Is a folder:K24:2)
		
		If (Substring:C12($vt_debugDirPath; Length:C16($vt_debugDirPath); 1)#Folder separator:K24:12)
			$vt_debugDirPath:=$vt_debugDirPath+Folder separator:K24:12
		End if 
		
		Use (Storage:C1525.curl)
			Storage:C1525.curl.debugDirPath:=$vt_debugDirPath
		End use 
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "debug on : \""+$vt_debugDirPath+"\"")
		
	Else 
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "invalid debug dir path : \""+$vt_debugDirPath+"\"")
End case 
