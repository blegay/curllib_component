//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__httpRequestCleanHeaders
//@scope : public
//@deprecated : no
//@description : This function will clean the headers array
//@parameter[0-OUT-statusLine-TEXT] : http status line (e.g. "HTTP/1.1 200 OK")
//@parameter[1-INOUT-headersArrayPtr-POINTER] : http headers text array pointer (modified)
//@notes : when curl gets a redirect, all the headers including the one of the redirect will get in the header arrays (callback)
// this function will remove the unecessary headers and will keep the last header
//@example : CURL__httpRequestCleanHeaders
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:23:37 - 1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_httpStatusLine)
C_POINTER:C301($1; $vp_headersArrayPtr)

// BEFORE :

// CURL__CB_header ==> headers : HTTP/1.1 301 Moved Permanently
// CURL__CB_header ==> headers : Server: AkamaiGHost
// CURL__CB_header ==> headers : Content-Length: 0
// CURL__CB_header ==> headers : Location: https://www.apple.com/
// CURL__CB_header ==> headers : Cache-Control: max-age=0
// CURL__CB_header ==> headers : Expires: Mon, 25 Sep 2017 18:39:58 GMT
// CURL__CB_header ==> headers : Date: Mon, 25 Sep 2017 18:39:58 GMT
// CURL__CB_header ==> headers : Connection: keep-alive
// CURL__CB_header ==> headers : 
// CURL__CB_header ==> headers : HTTP/1.1 200 OK
// CURL__CB_header ==> headers : Server: Apache
// CURL__CB_header ==> headers : Content-Length: 45743
// CURL__CB_header ==> headers : Content-Type: text/html; charset=UTF-8
// CURL__CB_header ==> headers : X-Frame-Options: SAMEORIGIN
// CURL__CB_header ==> headers : X-Content-Type-Options: nosniff
// CURL__CB_header ==> headers : X-Xss-Protection: 1; mode=block
// CURL__CB_header ==> headers : Cache-Control: max-age=15
// CURL__CB_header ==> headers : Expires: Mon, 25 Sep 2017 18:40:14 GMT
// CURL__CB_header ==> headers : Date: Mon, 25 Sep 2017 18:39:59 GMT
// CURL__CB_header ==> headers : Connection: keep-alive
// CURL__CB_header ==> headers : 

// AFTER :

// CURL__CB_header ==> headers : HTTP/1.1 200 OK
// CURL__CB_header ==> headers : Server: Apache
// CURL__CB_header ==> headers : Content-Length: 45743
// CURL__CB_header ==> headers : Content-Type: text/html; charset=UTF-8
// CURL__CB_header ==> headers : X-Frame-Options: SAMEORIGIN
// CURL__CB_header ==> headers : X-Content-Type-Options: nosniff
// CURL__CB_header ==> headers : X-Xss-Protection: 1; mode=block
// CURL__CB_header ==> headers : Cache-Control: max-age=15
// CURL__CB_header ==> headers : Expires: Mon, 25 Sep 2017 18:40:14 GMT
// CURL__CB_header ==> headers : Date: Mon, 25 Sep 2017 18:39:59 GMT
// CURL__CB_header ==> headers : Connection: keep-alive


ASSERT:C1129(Count parameters:C259>0; "requires 1 parameter")
ASSERT:C1129(Type:C295($1->)=Text array:K8:16; "$1 should be a text array pointer")

$vt_httpStatusLine:=""
$vp_headersArrayPtr:=$1

If (Size of array:C274($vp_headersArrayPtr->)>0)
	
	C_LONGINT:C283($vl_found)
	$vl_found:=Find in array:C230($vp_headersArrayPtr->; "")
	While ($vl_found>0)
		If ($vl_found=Size of array:C274($vp_headersArrayPtr->))
			DELETE FROM ARRAY:C228($vp_headersArrayPtr->; $vl_found; 1)
		Else 
			DELETE FROM ARRAY:C228($vp_headersArrayPtr->; 1; $vl_found)
		End if 
		
		$vl_found:=Find in array:C230($vp_headersArrayPtr->; "")
	End while 
	
	ASSERT:C1129(Size of array:C274($vp_headersArrayPtr->)>0; "unexpected http headers")
	$vt_httpStatusLine:=$vp_headersArrayPtr->{1}
End if 

$0:=$vt_httpStatusLine