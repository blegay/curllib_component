CURL__xdocInit

//Si (Non(Mode compile))
ARRAY TEXT:C222($tt_components; 0)
COMPONENT LIST:C1001($tt_components)
If ((Find in array:C230($tt_components; "log4D_component")>0) | \
(Find in array:C230($tt_components; "dbg_component")>0))
	
	//Initialize the http debug
	//DBG_init
	//DBG_mode_OnOff (Vrai)
	
	//DBG_module_Mode_Set ("http";Vrai)
	//DBG_module_Threshold_Set ("http";8)
	
	EXECUTE METHOD:C1007("DBG_init"; *)
	EXECUTE METHOD:C1007("DBG_mode_OnOff"; *; True:C214)
	
	EXECUTE METHOD:C1007("DBG_module_Mode_Set"; *; "curl"; True:C214)
	EXECUTE METHOD:C1007("DBG_module_Threshold_Set"; *; "curl"; 8)
	
	EXECUTE METHOD:C1007("DBG_logFileShow")
End if 
ARRAY TEXT:C222($tt_components; 0)
//Fin de si

CURL__initStorage
CURL__init

CURL_assertSet(True:C214)

Case of 
	: (Is compiled mode:C492)
	: (Storage:C1525.curl.isHeadless)
	: (Storage:C1525.curl.launchedAsService)
	Else 
		CURL__caCertUpdateInResDir
End case 