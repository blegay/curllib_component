//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

//================================================================================
//@xdoc-start : en
//@name : CURL__httpRequestObj
//@scope : public
//@deprecated : no
//@description : This function uses curl plugin to do an http request
//@parameter[0-OUT-curlError-LONGINT] : curl error (0 = no error)
//@parameter[1-IN-object-OBJECT] : curl option object
//@parameter[2-IN-requestBodyPtr-POINTER] : request body blob pointer (not modified)
//@parameter[3-IN-responseBodyPtr-POINTER] : response body blob pointer (modified)
//@parameter[4-INOUT-httpHeaders-POINTER] : http headers text array pointer (optional, modified)
//@parameter[5-OUT-curlInfosJsonPtr-POINTER] : curl infos in json format (optional, modified)
//@notes : 
//@example : CURL__httpRequest
//@see : https://github.com/miyako/4d-plugin-curl-v3
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:30:44 - 1.00.00
//@xdoc-end
//================================================================================

C_LONGINT:C283($0; $vl_curlError)
C_OBJECT:C1216($1; $vo_curlOptions)
C_POINTER:C301($2; $vp_curlRequestBodyPtr)
C_POINTER:C301($3; $vp_curlResponseBodyPtr)
C_POINTER:C301($4; $vp_httpHeadersPtr)
C_POINTER:C301($5; $vp_curlInfosJsonPtr)

ASSERT:C1129(Count parameters:C259>2; "requires 3 parameters or more")
ASSERT:C1129($1#Null:C1517; "$1 object is null")
ASSERT:C1129($1.request#Null:C1517; "$1.request is null")
ASSERT:C1129($1.request.curlOptions#Null:C1517; "$1.request.curlOptions is null")
ASSERT:C1129($1.request.curlOptions.URL#Null:C1517; "$1.request.curlOptions.URL is null")
ASSERT:C1129(Type:C295($2->)=Is BLOB:K8:12; "$4 should be a blob pointer")
ASSERT:C1129(Type:C295($3->)=Is BLOB:K8:12; "$5 should be a blob pointer")
If (Count parameters:C259>5)
	ASSERT:C1129(Type:C295($4->)=Text array:K8:16; "$6 should be a text array pointer")
End if   //ASSERT(Type($7->)=Est un texte;"$7 should be a text pointer")

$vl_curlError:=-1

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>2)
	
	$vo_curlOptions:=$1
	$vp_curlRequestBodyPtr:=$2
	$vp_curlResponseBodyPtr:=$3
	
	Case of 
		: ($vl_nbParam=3)
		: ($vl_nbParam=4)
			ASSERT:C1129(Type:C295($4->)=Text array:K8:16; "$4 should be a text array pointer")
			$vp_httpHeadersPtr:=$4
		Else 
			//: ($vl_nbParam=5)
			ASSERT:C1129(Type:C295($4->)=Text array:K8:16; "$4 should be a text array pointer")
			ASSERT:C1129(Type:C295($5->)=Is text:K8:3; "$5 should be a text pointer")
			$vp_httpHeadersPtr:=$4
			$vp_curlInfosJsonPtr:=$5
	End case 
	
	C_OBJECT:C1216($vo_curlRequestOptions)
	$vo_curlRequestOptions:=$vo_curlOptions.request.curlOptions
	
	C_BOOLEAN:C305($vb_isPreemptive; $vb_isHeadless; $vb_launchedAsService)
	$vb_isPreemptive:=UTL_processIsPreemptive
	$vb_isHeadless:=UTL_isHeadless
	$vb_launchedAsService:=UTL_launchedAsService
	
	EXECUTE METHOD:C1007("CURL__init")
	
	C_BLOB:C604($vx_curlRequestBody; $vx_curlResponseBody)
	SET BLOB SIZE:C606($vx_curlRequestBody; 0)
	SET BLOB SIZE:C606($vx_curlResponseBody; 0)
	
	$vx_curlRequestBody:=$vp_curlRequestBodyPtr->
	
	If (BLOB size:C605($vx_curlRequestBody)>0)
		
		// disable the "Transfer-Encoding: chunked" in the request body
		//   Transfer-Encoding: chunked
		//   Expect: 100-continue
		// Note : "Transfer-Encoding: chunked" in a PUT request was breaking the AWS4 signature
		
		C_TEXT:C284($vt_headerLine)
		// https://stackoverflow.com/questions/49670008/how-to-disable-expect-100-continue-in-libcurl
		// "HTTP/1.1 100 Continue"
		$vt_headerLine:="Expect:"
		Case of 
			: ($vo_curlRequestOptions.HTTPHEADER=Null:C1517)
				$vo_curlRequestOptions.HTTPHEADER:=New collection:C1472($vt_headerLine)
				
			: ($vo_curlRequestOptions.HTTPHEADER.indexOf("Expect:@")=-1)
				$vo_curlRequestOptions.HTTPHEADER.push($vt_headerLine)
				
		End case 
		
		//$vt_headerLine:="Transfer-Encoding:"
		//Case of 
		//: ($vo_curlRequestOptions.HTTPHEADER=Null)
		//$vo_curlRequestOptions.HTTPHEADER:=New collection($vt_headerLine)
		
		//: ($vo_curlRequestOptions.HTTPHEADER.indexOf("Transfer-Encoding:@")=-1)
		//$vo_curlRequestOptions.HTTPHEADER.push($vt_headerLine)
		
		//End case 
	End if 
	
	//<Modif> Bruno LEGAY (BLE) (02/06/2020)
	If ($vo_curlOptions.redirectCount=Null:C1517)
		$vo_curlOptions.redirectCount:=0
	End if 
	//<Modif>
	
	
	C_LONGINT:C283($vl_progressId)
	$vl_progressId:=0
	Case of 
		: ($vb_isPreemptive | $vb_isHeadless | $vb_launchedAsService)
		: ($vo_curlOptions.progressShow)
			//%T-
			EXECUTE METHOD:C1007("CURL__progressNew"; $vl_progressId; $vo_curlOptions.progressTitle; $vo_curlOptions.progressAbortable)
			//%T+
			
			//$vl_progressId:=CURL__progressNew 
			//$vl_progressId:=Progress New 
			//Progress SET PROGRESS ($vl_progressId;-1)
			//Progress SET TITLE ($vl_progressId;$vo_curlOptions.progressTitle)
			//Progress SET BUTTON ENABLED ($vl_progressId;$vo_curlOptions.progressAbortable)
			
			//<Modif> Bruno LEGAY (BLE) (13/01/2021)
			$vo_curlRequestOptions.PRIVATE:=JSON Stringify:C1217(New object:C1471("progressId"; $vl_progressId))
			//<Modif>
			
	End case 
	
	//<Modif> Bruno LEGAY (BLE) (13/01/2021)
	//$vo_curlRequestOptions.PRIVATE:=JSON Stringify(New object("progressId";$vl_progressId))
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (12/01/2021)
	// dump all key/values into logs
	//CURL__moduleDebugDateTimeLine (6;Current method name;CURL__debugObjectJson ($vo_curlOptions))
	//<Modif>
	
	C_TEXT:C284($vt_callbackMethod; $vt_transferInfo; $vt_headerInfo)
	$vt_callbackMethod:="CURL__callback"
	$vt_transferInfo:=""
	$vt_headerInfo:=""
	
	//C_TEXT($vt_curlOptionsJson)
	//$vt_curlOptionsJson:=JSON Stringify($vo_curlRequestOptions)
	
	//<Modif> Bruno LEGAY (BLE) (12/01/2021)
	C_TEXT:C284($vt_processDebug)
	$vt_processDebug:="\""+Current process name:C1392+"\" ("+String:C10(Current process:C322)+")"
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "about to call cURL, curlOptions : "+CURL__debugObjectJson($vo_curlRequestOptions; True:C214)+\
		", resquest local blob size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
		", response local blob size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
		", callbackMethod : \""+$vt_callbackMethod+"\""+\
		", transferInfo : \""+$vt_transferInfo+"\""+\
		", process : \""+$vt_processDebug+"\""+\
		", isPreemptive : "+Choose:C955($vb_isPreemptive; "true"; "false")+\
		", isHeadless : "+Choose:C955($vb_isHeadless; "true"; "false")+\
		", launchedAsService : "+Choose:C955($vb_launchedAsService; "true"; "false"))
	
	If ($vo_curlOptions.request.curlOptions.DEBUG#Null:C1517)
		C_TEXT:C284($vt_objJsonDumpPath)
		$vt_objJsonDumpPath:=$vo_curlOptions.request.curlOptions.DEBUG+"request.json"
		TEXT TO DOCUMENT:C1237($vt_objJsonDumpPath; JSON Stringify:C1217($vo_curlRequestOptions))
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "debug infos in : \""+$vt_objJsonDumpPath+"\", process : \""+$vt_processDebug+"\"")
	End if 
	//<Modif>
	
	C_LONGINT:C283($vl_durationMs)
	$vl_durationMs:=Milliseconds:C459
	
	// https://github.com/miyako/4d-plugin-curl-v3
	
	
	C_OBJECT:C1216($vo_curlResult)
	$vo_curlResult:=cURL($vo_curlRequestOptions; $vx_curlRequestBody; $vx_curlResponseBody; $vt_callbackMethod)  //; $vt_transferInfo; $vt_headerInfo)
	
	$vl_curlError:=$vo_curlResult.status
	$vt_headerInfo:=$vo_curlResult.headerInfo
	$vt_transferInfo:=JSON Stringify:C1217($vo_curlResult.transferInfo)
	
	//$vl_curlError:=cURL($vo_curlRequestOptions; $vx_curlRequestBody; $vx_curlResponseBody; $vt_callbackMethod; $vt_transferInfo; $vt_headerInfo)
	
	$vl_durationMs:=LONG_durationDifference($vl_durationMs; Milliseconds:C459)
	
	//<Modif> Bruno LEGAY (BLE) (12/01/2021)
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "about to call cURL, curlOptions : "+CURL__debugObjectJson($vo_curlRequestOptions; True:C214)+\
		", resquest local blob size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
		", response local blob size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
		", callbackMethod : \""+$vt_callbackMethod+"\""+\
		", transferInfo : \""+$vt_transferInfo+"\""+\
		", headerInfo : \""+$vt_headerInfo+"\""+\
		", process : \""+$vt_processDebug+"\""+\
		", errror code : "+String:C10($vl_curlError)+" - "+CURL_errorToText($vl_curlError))
	//<Modif>
	
	If ($vl_progressId#0)
		//%T-
		EXECUTE METHOD:C1007("CURL__progressClose"; *; $vl_progressId)
		//%T+
		//CURL__progressClose ($vl_progressId)
		//Progress QUIT ($vl_progressId)
	End if 
	
	If (False:C215)
		// $vt_transferInfo :
		//   {
		//      "appConnectTime" : 4.0000000000000003e-05,
		//      "conditionUnmet" : 0,
		//      "connectCode" : 0,
		//      "connectTime" : 3.8999999999999999e-05,
		//      "contentLengthDownload" : 223687,
		//      "contentLengthUpload" : -1,
		//      "contentType" : "application/x-pem-file",
		//      "effectiveUrl" : "https://curl.se/ca/cacert.pem",
		//      "fileTime" : -1,
		//      "ftpEntryPath" : "",
		//      "headerSize" : 705,
		//      "httpAuthAvail" : 0,
		//      "lastSocket" : -1,
		//      "localIp" : "2a01:e34:ef76:1080:cd49:c531:543b:ee1c",
		//      "localPort" : 60418,
		//      "nameLookupTime" : 3.8999999999999999e-05,
		//      "numConnects" : 0,
		//      "osErrNo" : 0,
		//      "preTransferTime" : 0.00011400000000000001,
		//      "primaryIp" : "2a04:4e42:1d::561",
		//      "primaryPort" : 443,
		//      "proxyAuthAvail" : 0,
		//      "redirectCount" : 0,
		//      "redirectTime" : 0.0,
		//      "redirectUrl" : "",
		//      "requestSize" : 185,
		//      "responseCode" : 200,
		//      "rtspClientCseq" : 0,
		//      "rtspCseqRecv" : 0,
		//      "rtspServerCseq" : 0,
		//      "rtspSessionId" : "",
		//      "sizeDownload" : 0,
		//      "sizeUpload" : 0,
		//      "speedDownload" : 0,
		//      "speedUpload" : 0,
		//      "sslVerifyResult" : 0,
		//      "startTransferTime" : 0.035527999999999997,
		//      "totalTime" : 0.035557999999999999
		//   }
		
		
		// $vt_headerInfo :
		
		// HTTP/2 200 \r\n 
		// server: Apache\r\n 
		// x-frame-options: SAMEORIGIN\r\n 
		// last-modified: Wed, 01 Jan 2020 04:12:10 GMT\r\n 
		// etag: "369c7-59b0c47d1f397"\r\n 
		// cache-control: max-age=43200\r\n 
		// expires: Fri, 13 Mar 2020 12:47:24 GMT\r\n 
		// x-content-type-options: nosniff\r\n 
		// content-security-policy: default-src 'self' www.fastly-insights.com; style-src 'unsafe-inline' 'self'\r\n 
		// strict-transport-security: max-age=31536000; includeSubDomains;\r\n 
		// content-type: application/x-pem-file\r\n 
		// via: 1.1 varnish\r\n 
		// accept-ranges: bytes\r\n 
		// date: Sun, 24 May 2020 08:15:05 GMT\r\n 
		// via: 1.1 varnish\r\n 
		// age: 26788\r\n 
		// x-served-by: cache-bma1643-BMA, cache-cdg20734-CDG\r\n 
		// x-cache: HIT, HIT\r\n 
		// x-cache-hits: 1, 308\r\n 
		// x-timer: S1590308105.317872,VS0,VE0\r\n 
		// content-length: 223687\r\n\r\n
	End if 
	
	$vo_curlOptions.error:=$vl_curlError
	
	If (($vl_curlError=0) & (Length:C16($vt_headerInfo)>0))
		
		//<Modif> Bruno LEGAY (BLE) (03/06/2020)
		// When getting redirect, we have all the headers
		
		C_COLLECTION:C1488($co_responseHeaders)
		$co_responseHeaders:=Split string:C1554($vt_headerInfo; "\r\n\r\n"; sk ignore empty strings:K86:1)
		If ($co_responseHeaders.length>1)
			C_TEXT:C284($vt_headerFinal)
			$vt_headerFinal:=$co_responseHeaders[$co_responseHeaders.length-1]  // get last "element" headers from the effective url
			
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "url : \""+$vo_curlRequestOptions.URL+"\""+\
				", verb : \""+$vo_curlOptions.verb+"\""+\
				", headers (all) : \r"+$vt_headerInfo+"\r"+\
				", headers (effective url) : \""+$vt_headerFinal)
			
			$vt_headerInfo:=$vt_headerFinal
			
		End if 
		
		//   HTTP/1.1 301 Moved Permanently\r\n
		//   Server: myracloud\r\n
		//   Date: Wed, 03 Jun 2020 10:21:19 GMT\r\n
		//   Content-Type: text/html\r\n
		//   Content-Length: 177\r\n
		//   Connection: keep-alive\r\n
		//   Location: https://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml\r\n
		//   \r\n
		//   HTTP/1.1 200 OK\r\n
		//   Server: myracloud\r\n
		//   Date: Wed, 03 Jun 2020 10:21:20 GMT\r\n
		//   Content-Type: text/xml\r\n
		//   Transfer-Encoding: chunked\r\n
		//   Connection: close\r\n
		//   X-Frame-Options: SAMEORIGIN\r\n
		//   Strict-Transport-Security: max-age=63072000; includeSubDomains\r\n
		//   Last-Modified: Tue, 02 Jun 2020 13:55:17 GMT\r\n
		//   X-XSS-Protection: 1; mode=block\r\n
		//   Expires: Tue, 02 Jun 2020 14:09:24 GMT\r\n
		//   cache-control: max-age=300\r\n
		//   X-CDN: 1\r\n
		//   \r\n
		
		//<Modif>
		
		
		//C_COLLECTION($co_responseHeaders)
		$co_responseHeaders:=Split string:C1554($vt_headerInfo; "\r\n"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
		
		// remove headers from redirect, etc... 
		C_TEXT:C284($vt_httpStatusLine)
		If ($co_responseHeaders#Null:C1517)
			$vt_httpStatusLine:=$co_responseHeaders[0]  // "HTTP/2 200"
		End if 
		
		C_LONGINT:C283($vl_status)
		$vl_status:=CURL__httpStatusLineToStatus($vt_httpStatusLine)
		
		//<Modif> Bruno LEGAY (BLE) (02/06/2020)
		//C_BOOLEAN($vb_followRedirect)
		//$vb_followRedirect:=False
		
		//If ((($vl_status=301) | ($vl_status=302) | ($vl_status=303)) & (Bool($vo_curlOptions.followRedirect)))
		
		//C_TEXT($vt_redirectUrl)
		//$vt_redirectUrl:=CURL_http_headersCollValueGet ($co_responseHeaders;"Location")
		
		//CURL__moduleDebugDateTimeLine (4;Current method name;"url : \""+$vo_curlRequestOptions.URL+"\""+\
																		", verb : \""+$vo_curlOptions.verb+"\""+\
																		", redirect status : "+String($vl_status)+\
																		", status line : \""+$vt_httpStatusLine+"\""+\
																		", redirect count : "+String($vo_curlOptions.redirectCount)+\
																		", redirect url : \""+$vt_redirectUrl+"\""+\
																		", request size : "+String(BLOB size($vx_curlRequestBody))+" byte(s)"+\
																		", response size : "+String(BLOB size($vx_curlResponseBody))+" byte(s)"+\
																		", headers : \r"+$vt_headerInfo+\
																		", duration : "+CURL__debugMilliseconds ($vl_durationMs))
		
		//If ((Length($vt_redirectUrl)>0) & ($vt_redirectUrl#$vo_curlOptions.request.curlOptions.URL))
		
		//If ($vo_curlOptions.redirectCount<$vl_redirectMax)
		//$vo_curlOptions.redirectCount:=$vo_curlOptions.redirectCount+1
		
		//$vb_followRedirect:=True
		//$vo_curlOptions.request.curlOptions.URL:=$vt_redirectUrl
		
		//Case of 
		//: ($vl_nbParam=3)
		//$vl_curlError:=CURL__httpRequestObj ($vo_curlOptions;$vp_curlRequestBodyPtr;$vp_curlResponseBodyPtr)
		
		//: ($vl_nbParam=4)
		//$vl_curlError:=CURL__httpRequestObj ($vo_curlOptions;$vp_curlRequestBodyPtr;$vp_curlResponseBodyPtr;$vp_httpHeadersPtr)
		
		//Else 
		//  // : ($vl_nbParam=5)
		//$vl_curlError:=CURL__httpRequestObj ($vo_curlOptions;$vp_curlRequestBodyPtr;$vp_curlResponseBodyPtr;$vp_httpHeadersPtr;$vp_curlInfosJsonPtr)
		
		//End case 
		
		//Else 
		//CURL__moduleDebugDateTimeLine (2;Current method name;"url : \""+$vo_curlRequestOptions.URL+"\""+\
																		", verb : \""+$vo_curlOptions.verb+"\""+\
																		", redirect status : "+String($vl_status)+\
																		", status line : \""+$vt_httpStatusLine+"\""+\
																		", redirect count : "+String($vo_curlOptions.redirectCount)+\
																		", too many redirects, max redirect : "+String($vl_redirectMax))
		//End if 
		
		//End if 
		//End if 
		
		//If (Not($vb_followRedirect))
		//<Modif>
		
		ARRAY TEXT:C222($tt_responseHeaders; 0)
		If ($co_responseHeaders#Null:C1517)
			COLLECTION TO ARRAY:C1562($co_responseHeaders; $tt_responseHeaders)
		End if 
		
		If ($vl_nbParam>3)
			//%W-518.1
			COPY ARRAY:C226($tt_responseHeaders; $vp_httpHeadersPtr->)
			//%W+518.1
		End if 
		
		ARRAY TEXT:C222($tt_responseHeaders; 0)
		
		If ($vo_curlOptions.response=Null:C1517)
			$vo_curlOptions.response:=New object:C1471
		End if 
		
		
		$vo_curlOptions.response.statusLine:=$vt_httpStatusLine
		//<Modif> Bruno LEGAY (BLE) (02/06/2020)
		$vo_curlOptions.status:=$vl_status
		//$vo_curlOptions.response.status:=$vl_status
		//<Modif>
		$vo_curlOptions.response.headers:=$co_responseHeaders
		$vo_curlOptions.transferInfo:=JSON Parse:C1218($vt_transferInfo)
		
		
		C_TEXT:C284($vt_throughputDebug)
		// "228,89 KB/s (66,83 KB, 68 441 bytes in 0,292s)"
		Case of 
			: ($vo_curlOptions.transferInfo.contentLengthDownload>0)
				//$vo_curlOptions.response.speedDownloadHuman:=DBG_bytes ($vo_curlOptions.transferInfo.speedDownload)+"/s"
				$vo_curlOptions.speedDownloadThroughput:=UTL_throughput($vo_curlOptions.transferInfo.contentLengthDownload; \
					($vo_curlOptions.transferInfo.totalTime-$vo_curlOptions.transferInfo.startTransferTime)*1000)
				$vo_curlOptions.speedUploadThroughput:=""
				
				$vt_throughputDebug:=", downloadThroughput : "+$vo_curlOptions.speedDownloadThroughput
				
			: ($vo_curlOptions.transferInfo.contentLengthUpload>0)
				//$vo_curlOptions.response.speedUploadHuman:=DBG_bytes ($vo_curlOptions.transferInfo.speedUpload)+"/s"
				$vo_curlOptions.speedUploadThroughput:=UTL_throughput($vo_curlOptions.transferInfo.contentLengthUpload; \
					($vo_curlOptions.transferInfo.totalTime-$vo_curlOptions.transferInfo.startTransferTime)*1000)
				$vo_curlOptions.speedDownloadThroughput:=""
				
				$vt_throughputDebug:=", uploadThroughput : "+$vo_curlOptions.speedUploadThroughput
			Else 
				$vo_curlOptions.speedUploadThroughput:=""
				$vo_curlOptions.speedDownloadThroughput:=""
				
				$vt_throughputDebug:=""
		End case 
		
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "url : \""+$vo_curlRequestOptions.URL+"\""+\
			", verb : \""+$vo_curlOptions.verb+"\""+\
			", error : "+CURL_errorToText($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
			", status : "+String:C10($vl_status)+\
			", status line : \""+$vt_httpStatusLine+"\""+\
			", request size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
			", response size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
			$vt_throughputDebug+\
			", duration : "+CURL__debugMilliseconds($vl_durationMs)+\
			", curl options :\r"+JSON Stringify:C1217($vo_curlOptions; *)+"\r"+\
			", transfer infos :\r"+$vt_transferInfo+"\r"+\
			", header infos :\r"+$vt_headerInfo)
		
		$vp_curlResponseBodyPtr->:=$vx_curlResponseBody
		
		If ($vl_nbParam>6)
			$vp_curlInfosJsonPtr->:=$vt_transferInfo
		End if 
		
		//End if 
		
	Else   // $vl_curlError#0
		
		$vo_curlOptions.response:=New object:C1471
		$vo_curlOptions.transferInfo:=JSON Parse:C1218($vt_transferInfo)
		
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "url : \""+$vo_curlRequestOptions.URL+"\""+\
			", verb : \""+$vo_curlOptions.verb+"\""+\
			", error : "+CURL_errorToText($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
			", duration : "+CURL__debugMilliseconds($vl_durationMs)+\
			", curl options :\r"+JSON Stringify:C1217($vo_curlOptions; *)+"\r"+\
			", transfer infos :\r"+$vt_transferInfo+"\r"+\
			", header infos :\r"+$vt_headerInfo)
		
	End if 
	
	SET BLOB SIZE:C606($vx_curlRequestBody; 0)
	SET BLOB SIZE:C606($vx_curlResponseBody; 0)
	
Else 
	$vl_curlError:=-1
End if 

$0:=$vl_curlError