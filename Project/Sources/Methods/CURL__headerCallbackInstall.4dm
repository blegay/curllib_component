//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//C_TEXT($0;$vt_callback)
//C_BOOLEAN($1;$vb_quiet)

//$vt_callback:=""

//If (Count parameters=0)
//$vb_quiet:=True
//Else 
//$vb_quiet:=$1
//End if 

//If (Length(<>vb_CURL_headerCallback)=0)

//C_TEXT($vt_callback)
//If (ENV_isComponent )
//$vt_callback:="CURL_headerCallbackHost"

//  //C_BOOLEEN($0)
//  //C_BLOB($1)

//  //$0:=CURL_headerCallback ($1)
//  // create callback
//  // curl did not work well when the callback was in the compiled component
//  // lets curl call the host method and the method will call "CURL_headerCallback" from the component
//ARRAY TEXT($tt_methods;0)
//UTL__methodListGet (->$tt_methods;"CURL_@")

//If (Find in array($tt_methods;$vt_callback)>0)
//CURL__moduleDebugDateTimeLine (4;Current method name;"method : \""+$vt_callback+"\" exists. [OK]")
//Else 

//If (Is compiled mode(*))
//CURL__moduleDebugDateTimeLine (2;Current method name;"method : \""+$vt_callback+"\" does not exists. Host database is compiled. [OK]")
//ALERT("The callback method \""+$vt_callback+"\" does not exist.\rThe host database is compiled.\r The curllib_component cannot create the \""+$vt_callback+"\" callback method.")
//Else 

//C_BOOLEAN($vb_doCreate)
//If ($vb_quiet)
//$vb_doCreate:=True
//Else 
//CONFIRM("Method \""+$vt_callback+"\" not found. Create it ?")
//$vb_doCreate:=(ok=1)
//End if 

//If ($vb_doCreate)
//C_TEXT($vt_src)
//$vt_src:=""
//$vt_src:=$vt_src+"// This method is a callback for cURL_plugin and curllib_component\r"
//$vt_src:=$vt_src+"// This method was created automatically on the "+String(Current date;Internal date short)+" at "+Time string(Current time)+"\r"
//$vt_src:=$vt_src+"// This method is a wrapper on the CURL_headerCallback method from the curllib_component (to avoid a crash)\r"
//$vt_src:=$vt_src+"// Do not delete, modify or rename this method\r\r"

//$vt_src:=$vt_src+Command name(305)+"($0)\r"  //C_BOOLEEN($0)
//$vt_src:=$vt_src+Command name(604)+"($1)\r"  //C_BLOB($1)
//$vt_src:=$vt_src+"$0:=CURL_headerCallback ($1)\r"

//UTL__callbackMethodSourceSet ($vt_callback;$vt_src)

//CURL__moduleDebugDateTimeLine (4;Current method name;"method : \""+$vt_callback+"\" created. [OK]")
//Else 
//CURL__moduleDebugDateTimeLine (4;Current method name;"user canceled creating callback : \""+$vt_callback+"\". [KO]")
//End if 

//End if 

//End if 
//ARRAY TEXT($tt_methods;0)

//Else 
//$vt_callback:="CURL_headerCallback"
//End if 

//<>vb_CURL_headerCallback:=$vt_callback
//Else 
//$vt_callback:=<>vb_CURL_headerCallback
//End if 

//$0:=$vt_callback
