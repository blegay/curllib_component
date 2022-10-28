//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__sslParamsObj
//@scope : public
//@deprecated : no
//@description : This method sets the default ssl options
//@parameter[1-INOUT-options-OBJECT] : ParamDescription
//@notes : 
//@example : CURL__sslParamsObj
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION :  - 04/06/2019, 13:10:10 - 1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($1; $vo_options)

ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")

$vo_options:=$1

// default format used by curl is "pem"
C_TEXT:C284($vt_caPath)
$vt_caPath:=""

//<Modif> Bruno LEGAY (BLE) (28/09/2017)
$vt_caPath:=Storage:C1525.curl.caPath
Case of 
	: (Length:C16($vt_caPath)=0)
	: (Test path name:C476($vt_caPath)=Is a document:K24:1)
	Else 
		$vt_caPath:=""
End case 


//Case of 
//: (Length(<>vt_CURL_caPath)=0)
//: (Test path name(<>vt_CURL_caPath)=Is a document)
//$vt_caPath:=<>vt_CURL_caPath
//End case 

If (Length:C16($vt_caPath)=0)  // no fresh ca.pem file. use the fallback pem file from the component
	$vt_caPath:=CURL__caPemFileDefaultPath
	ASSERT:C1129(Test path name:C476($vt_caPath)=Is a document:K24:1; "file \""+$vt_caPath+"\" not found")
End if 

//C_TEXT($vt_caPathPosix)
//$vt_caPathPosix:=Convert path system to POSIX($vt_caPath)
//$vt_caPath:=Convertir chemin système vers POSIX(Dossier 4D(Dossier Resources courant)+"certs"+Séparateur dossier+"cacert.pem")
//ASSERT(Tester chemin acces($vt_caPath)#Est un document;"file \""+$vt_caPath+"\" not found")
//<Modif>

// set SSL options

C_BOOLEAN:C305($vb_override)
$vb_override:=False:C215


// https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYHOST.html
// This option determines whether libcurl verifies that the server cert is for the server it is known as.
// default is "2"
If (Not:C34(OB Is defined:C1231($vo_options; "SSL_VERIFYHOST")) | $vb_override)
	OB SET:C1220($vo_options; "SSL_VERIFYHOST"; 2)
	CURL__moduleDebugDateTimeLine(6; Current method name:C684; "CURLOPT_SSL_VERIFYHOST : 2")
End if 

// https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYPEER.html
// This option determines whether curl verifies the authenticity of the peer's certificate
// default is "1"
If (Not:C34(OB Is defined:C1231($vo_options; "SSL_VERIFYPEER")) | $vb_override)
	OB SET:C1220($vo_options; "SSL_VERIFYPEER"; 1)
	CURL__moduleDebugDateTimeLine(6; Current method name:C684; "CURLOPT_SSL_VERIFYPEER : 1")
End if 

If (False:C215)
	// https://discuss.4d.com/t/curl-plugin/21800
	// https://curl.se/libcurl/c/CURLOPT_CERTINFO.html
	// https://github.com/miyako/4d-plugin-curl-v2/blob/master/curl/4DPlugin.cpp
	//OB SET($vo_options;"CERTINFO";1)
End if 



// https://curl.se/libcurl/c/CURLOPT_USE_SSL.html
If (Not:C34(OB Is defined:C1231($vo_options; "USE_SSL")) | $vb_override)
	OB SET:C1220($vo_options; "USE_SSL"; "CURLUSESSL_ALL")
	
	CURL__moduleDebugDateTimeLine(6; Current method name:C684; "CURLOPT_USE_SSL : \"CURLUSESSL_ALL\"")
	
	// This is for enabling SSL/TLS when you use FTP, SMTP, POP3, IMAP etc.
	
	// "CURLUSESSL_NONE" Don't attempt to use SSL.
	// "CURLUSESSL_TRY" : Try using SSL, proceed as normal otherwise.
	// "CURLUSESSL_CONTROL" : Require SSL for the control connection or fail with CURLE_USE_SSL_FAILED.
	// "CURLUSESSL_ALL" : Require SSL for all communication or fail with CURLE_USE_SSL_FAILED.
	
End if 

// https://curl.se/libcurl/c/CURLOPT_CAINFO.html
// This option is by default set to the system path where libcurl's cacert bundle is assumed to be stored, as established at build time.
If (Not:C34(OB Is defined:C1231($vo_options; "CAINFO")) | $vb_override)
	OB SET:C1220($vo_options; "CAINFO"; $vt_caPath)
	CURL__moduleDebugDateTimeLine(6; Current method name:C684; "CAINFO : \""+$vt_caPath+"\")")  // not posix
	//If (False)
	//$vt_caPathPosix:="Macintosh HD:Users:ble:Documents:Projets:BaseRef_v18:curllib_component:source:curllib_component.4dbase:Resources:certs:cacert.pem"
	//End if 
	//OB SET($vo_options;"CAINFO";$vt_caPathPosix)
	//CURL__moduleDebugDateTimeLine (6;Current method name;"CURLOPT_CAINFO : \""+$vt_caPathPosix+"\" (posix), \""+$vt_caPath+"\")")
	
End if 

//If (Not(OB Is defined($vo_options;"CAINFO")) | $vb_override)
//OB SET($vo_options;"CAINFO";$vt_caPathPosix)
//CURL__moduleDebugDateTimeLine (6;Current method name;"CURLOPT_CAINFO : \""+$vt_caPathPosix+"\" (posix), \""+$vt_caPath+"\")")
//End if 

