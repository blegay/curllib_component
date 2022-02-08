//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_caRefresh
  //@scope : public
  //@deprecated : no
  //@description : This method will download a ca certificates in pem format and store it in as "cache" in the prefence directory
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-options-OBJECT] : curl options (for proxy configuration for instance) (optional)
  //@parameter[2-IN-url-TEXT] : pem file url (optional, default : "https://curl.haxx.se/ca/cacert.pem")
  //@notes : if this command is not called, the ca certificates pem file in the component Resources dir will be used.
  // There is a risk that the certificates in this file will expire
  // So it a good idea to call this method once on the application startup
  //@example : CURL_caRefresh 
  //
  // CURL_caRefresh 
  //
  //   or
  //
  // C_OBJET($vo_options)
  // CURL_curlOptionsProxySet (->$vo_options;"127.0.0.1";80;"steve";"1234")
  // CURL_caRefresh ($vo_options)
  //
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 28/09/2017, 18:02:12 - v1.00.00
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_OBJECT:C1216($1;$vo_curlOptions)
  //C_TEXT($2;$vt_url)

$vb_ok:=False:C215

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259

Case of 
	: ($vl_nbParam=0)
	: ($vl_nbParam=1)
		$vo_curlOptions:=$1
		  //$vt_url:=""
	Else 
		$vo_curlOptions:=$1
		  //$vt_url:=$2
End case 

  //If (Length($vt_url)=0)
  //$vt_url:="https://curl.haxx.se/ca/cacert.pem"
  //End if 

EXECUTE METHOD:C1007("CURL__init")

  // CURL__init 

  //CURL__initG 

  //ARRAY LONGINT($tl_curlKeysCommon;0)
  //ARRAY TEXT($tt_curlValuesCommon;0)

  //ARRAY LONGINT($tl_curlKeys;0)
  //ARRAY TEXT($tt_curlValues;0)

C_BLOB:C604($vx_curlRequestBody;$vx_curlResponseBody)
SET BLOB SIZE:C606($vx_curlRequestBody;0)
SET BLOB SIZE:C606($vx_curlResponseBody;0)

C_TEXT:C284($vt_curlInfos)

  //CURL__optionsFromObject (->$tl_curlKeysCommon;->$tt_curlValuesCommon;$vo_options)
If ($vo_curlOptions=Null:C1517)
	$vo_curlOptions:=New object:C1471
End if 

If ($vo_curlOptions.URL=Null:C1517)
	  //<Modif> Bruno LEGAY (BLE) (18/03/2021) - v3.00.01
	$vo_curlOptions.URL:=CURL__cacertUrlDefault   // "https://curl.se/ca/cacert.pem"
	  //$vo_curlOptions.URL:="https://curl.se/ca/cacert.pem"
	  //<Modif>
	  //$vo_curlOptions.URL:="https://curl.haxx.se/ca/cacert.pem"
End if 

$vo_curlOptions.SSL_VERIFYHOST:=0
$vo_curlOptions.SSL_VERIFYPEER:=0
  //<Modif> Bruno LEGAY (BLE) (02/06/2020)
  // headers response will be of the redirect (status 301)
  // https://github.com/miyako/4d-plugin-curl-v2/issues/5

  //<Modif> Bruno LEGAY (BLE) (30/07/2021)
$vo_curlOptions.FOLLOWLOCATION:=1  // headers response will be of the redirect (status 301)`
  //<Modif>


  //<Modif>
$vo_curlOptions.CONNECTTIMEOUT:=2
$vo_curlOptions.HTTPHEADER:=New collection:C1472("Accept: application/x-pem-file";"User-Agent: "+CURL__userAgent )

If (False:C215)
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_SSL_VERIFYHOST)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"0")
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_SSL_VERIFYPEER)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"0")
	
	  //AJOUTER À TABLEAU($tl_curlKeysCommon;CURLOPT_CAINFO)
	  //AJOUTER À TABLEAU($tt_curlValuesCommon;"")
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_FOLLOWLOCATION)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"1")
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_HTTPHEADER)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"User-Agent: "+CURL__userAgent )
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_HTTPHEADER)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"Accept: application/x-pem-file")
	  //  //AJOUTER À TABLEAU($tt_curlValues;"Accept: */*")
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_CONNECTTIMEOUT)
	  //APPEND TO ARRAY($tt_curlValuesCommon;"2")
	
	  //APPEND TO ARRAY($tl_curlKeysCommon;CURLOPT_HEADERFUNCTION)  // Not supported !!
	  //APPEND TO ARRAY($tt_curlValuesCommon;CURL__headerCallbackInstall )
	
	  //COPY ARRAY($tl_curlKeysCommon;$tl_curlKeys)
	  //COPY ARRAY($tt_curlValuesCommon;$tt_curlValues)
	
	  // HTTP/1.1 200 OK
	  // Server: Apache
	  // X-Frame-Options: SAMEORIGIN
	  // Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT
	  // ETag: "39a1d-559965729d817"
	  // Cache-Control: max-age=43200
	  // Expires: Thu, 21 Sep 2017 00:03:02 GMT
	  // Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
	  // Content-Type: application/x-pem-file
	  // Via: 1.1 varnish
	  // Fastly-Debug-Digest: 84634dfb641e25b82c7745bdf6f300465a03e36a036ca753fbdea04bea45e642
	  // Content-Length: 236061
	  // Accept-Ranges: bytes
	  // Date: Thu, 28 Sep 2017 10:58:27 GMT
	  // Via: 1.1 varnish
	  // Age: 39317
	  // Connection: keep-alive
	  // X-Served-By: cache-bma7032-BMA, cache-lhr6329-LHR
	  // X-Cache: HIT, HIT
	  // X-Cache-Hits: 1, 1
	  // X-Timer: S1506596308.815181,VS0,VE3
	
	  // First do an HTTP HEAD to get the date and size of the pem file from the url
	  //APPEND TO ARRAY($tl_curlKeys;CURLOPT_NOBODY)  // => do a "HEAD" request
	  //APPEND TO ARRAY($tt_curlValues;"1")
	
	  //AJOUTER À TABLEAU($tl_curlKeys;CURLOPT_CUSTOMREQUEST)
	  //AJOUTER À TABLEAU($tt_curlValues;"HEAD")
	
	  // https://curl.haxx.se/libcurl/c/CURLOPT_HEADER.html
	  //AJOUTER À TABLEAU($tl_curlKeys;CURLOPT_HEADER)
	  //AJOUTER À TABLEAU($tt_curlValues;"1")
	
	  // this array will be set with the CURL_headerCallback function
	  //ARRAY TEXT(tt_CURL_httpHeaders;0)
End if 

$vo_curlOptions.NOBODY:=1

C_LONGINT:C283($vl_curlError)

C_TEXT:C284($vt_curlOptionsJson)
$vt_curlOptionsJson:=JSON Stringify:C1217($vo_curlOptions)

C_TEXT:C284($vt_callbackMethod;$vt_headerInfo)
C_OBJECT:C1216($vo_transferInfo)
$vt_callbackMethod:=""
$vt_headerInfo:=""
$vo_transferInfo:=Null:C1517

C_LONGINT:C283($vl_durationMs)
$vl_durationMs:=Milliseconds:C459

  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
  // https://github.com/miyako/4d-plugin-curl-v3
C_OBJECT:C1216($vo_curlResponse)
$vo_curlResponse:=cURL ($vo_curlOptions;$vx_curlRequestBody;$vx_curlResponseBody;$vt_callbackMethod)  //;$vo_transferInfo;$vt_headerInfo)
$vl_curlError:=$vo_curlResponse.status
$vt_headerInfo:=$vo_curlResponse.headerInfo
$vo_transferInfo:=$vo_curlResponse.transferInfo

  // https://github.com/miyako/4d-plugin-curl-v2
  //$vl_curlError:=cURL ($vt_curlOptionsJson;$vx_curlRequestBody;$vx_curlResponseBody;$vt_callbackMethod;$vo_transferInfo;$vt_headerInfo)
  //<Modif>

$vl_durationMs:=LONG_durationDifference ($vl_durationMs;Milliseconds:C459)


  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
  // 2021-04-09T12:06:22.036 - curl - 04 - CURL_caRefresh ==> HEAD url : "https://curl.se/ca/cacert.pem", error : CURLE_OPERATION_TIMEDOUT (28) : Operation timeout. The specified time-out period was reached according to the conditions. (28), status line : "", request size : 0 byte(s), response size : 0 byte(s), duration : 30,106s
  // Exemple de message affi
  // dans ce cas $vt_httpStatusLine:=$co_responseHeaders[0] donne une erreur 
  // mieux gérer cette #todo
If (($vl_curlError=0) & (Length:C16($vt_headerInfo)>0))
	  //<Modif>
	
	
	If (False:C215)
		  // $vo_transferInfo :
		  //   {
		  //      "appConnectTime" : 4.0000000000000003e-05,
		  //      "conditionUnmet" : 0,
		  //      "connectCode" : 0,
		  //      "connectTime" : 3.8999999999999999e-05,
		  //      "contentLengthDownload" : 223687,
		  //      "contentLengthUpload" : -1,
		  //      "contentType" : "application/x-pem-file",
		  //      "effectiveUrl" : "https://curl.haxx.se/ca/cacert.pem",
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
		
		  // HTTP/2 301 
		  // server: nginx/1.17.6
		  // content-type: text/html; charset=iso-8859-1
		  // x-frame-options: SAMEORIGIN
		  // location: https://curl.se/ca/cacert.pem
		  // cache-control: max-age=60
		  // expires: Fri, 30 Jul 2021 08:20:11 GMT
		  // strict-transport-security: max-age=31536000
		  // via: 1.1 varnish, 1.1 varnish
		  // accept-ranges: bytes
		  // date: Fri, 30 Jul 2021 08:19:51 GMT
		  // age: 40
		  // x-served-by: cache-bma1631-BMA, cache-cdg20729-CDG
		  // x-cache: HIT, HIT
		  // x-cache-hits: 1, 2
		  // x-timer: S1627633192.555700,VS0,VE0
		  // content-length: 299
		  // 
		  // HTTP/2 200 
		  // server: nginx/1.17.6
		  // content-type: application/x-pem-file
		  // x-frame-options: SAMEORIGIN
		  // last-modified: Mon, 05 Jul 2021 21:35:55 GMT
		  // etag: "31dcb-5c667171988c9"
		  // cache-control: max-age=43200
		  // expires: Thu, 22 Jul 2021 11:45:02 GMT
		  // x-content-type-options: nosniff
		  // content-security-policy: default-src 'self' curl.haxx.se www.curl.se curl.se www.fastly-insights.com fastly-insights.com; style-src 'unsafe-inline' 'self' curl.haxx.se www.curl.se curl.se
		  // strict-transport-security: max-age=31536000
		  // via: 1.1 varnish, 1.1 varnish
		  // accept-ranges: bytes
		  // date: Fri, 30 Jul 2021 08:19:51 GMT
		  // age: 30886
		  // x-served-by: cache-bma1621-BMA, cache-cdg20735-CDG
		  // x-cache: HIT, HIT
		  // x-cache-hits: 1, 30
		  // x-timer: S1627633192.810872,VS0,VE0
		  // content-length: 204235
		  // 
		
	End if 
	
	  //<Modif> Bruno LEGAY (BLE) (30/07/2021)
	C_COLLECTION:C1488($co_responseHeaders)
	$co_responseHeaders:=Split string:C1554($vt_headerInfo;"\r\n\r\n";sk ignore empty strings:K86:1)
	If ($co_responseHeaders.length>1)
		C_TEXT:C284($vt_headerFinal)
		$vt_headerFinal:=$co_responseHeaders[$co_responseHeaders.length-1]  // get last "element" headers from the effective url
		
		CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url : \""+$vo_curlOptions.URL+"\""+\
			", verb : \"HEAD\""+\
			", headers (all) : \r"+$vt_headerInfo+"\r"+\
			", headers (effective url) : \""+$vt_headerFinal)
		
		$vt_headerInfo:=$vt_headerFinal
		
	End if 
	  //<Modif>
	
	
	
	
	C_COLLECTION:C1488($co_responseHeaders)
	$co_responseHeaders:=Split string:C1554($vt_headerInfo;"\r\n";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	
	  //ARRAY TEXT($tt_headers;0)
	  //COPY ARRAY(tt_CURL_httpHeaders;$tt_headers)
	  //ARRAY TEXT(tt_CURL_httpHeaders;0)
	
	  // remove headers from redirect, etc... 
	C_TEXT:C284($vt_httpStatusLine)
	$vt_httpStatusLine:=$co_responseHeaders[0]  // "HTTP/2 200"
	
	  //$vt_httpStatusLine:=CURL__httpRequestCleanHeaders (->$tt_headers)
	
	CURL__moduleDebugDateTimeLine (4;Current method name:C684;"HEAD url : \""+$vo_curlOptions.URL+"\""+\
		", error : "+CURL_errorToText ($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
		", status line : \""+$vt_httpStatusLine+"\""+\
		", request size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
		", response size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
		", duration : "+CURL__debugMilliseconds ($vl_durationMs))
	
	ASSERT:C1129($vl_curlError=0;"libCurl error "+CURL_errorToText ($vl_curlError)+" ("+String:C10($vl_curlError)+") with url \""+$vo_curlOptions.URL+"\"")
	If ($vl_curlError=0)
		ASSERT:C1129(CURL__httpStatusLineToStatus ($vt_httpStatusLine)=200;"http status : \""+$vt_httpStatusLine+"\" with url : \""+$vo_curlOptions.URL+"\"")
		
		C_LONGINT:C283($vl_contentLength)
		$vl_contentLength:=Num:C11(CURL_http_headersCollValueGet ($co_responseHeaders;"Content-Length"))
		  //$vl_contentLength:=Num(CURL_http_headersArrayValueGet (->$tt_headers;"Content-Length"))
		
		C_TEXT:C284($vt_contentType)
		$vt_contentType:=CURL_http_headersCollValueGet ($co_responseHeaders;"Content-Type")
		  //$vt_contentType:=CURL_http_headersArrayValueGet (->$tt_headers;"Content-Type")
		ASSERT:C1129($vt_contentType="application/x-pem-file";"libCurl unexpected \"Content-Type\" : \""+$vt_contentType+"\" (\"application/x-pem-file\" was expected)")
		
		C_TEXT:C284($vt_lastModifiedrfc1123;$vt_lastModifiedIso8601)
		$vt_lastModifiedrfc1123:=CURL_http_headersCollValueGet ($co_responseHeaders;"Last-Modified")
		  //$vt_lastModifiedrfc1123:=CURL_http_headersArrayValueGet (->$tt_headers;"Last-Modified")
		
		$vt_lastModifiedIso8601:=DAT_rfc1123ToIso8601 ($vt_lastModifiedrfc1123)
		
		CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url : \""+$vo_curlOptions.URL+"\""+\
			", Content-Length: "+String:C10($vl_contentLength)+\
			", Content-Type: "+$vt_contentType+\
			", Last-Modified: "+$vt_lastModifiedrfc1123)
		
		C_BOOLEAN:C305($vb_ok)
		C_TEXT:C284($vt_caPath)
		$vb_ok:=CURL__caPrefUpToDate ($vt_lastModifiedIso8601;$vl_contentLength;->$vt_caPath)
		  //C_TEXT(<>vt_CURL_caPath)
		  //$vb_ok:=CURL__caPrefUpToDate ($vt_lastModifiedIso8601;$vl_contentLength;-><>vt_CURL_caPath)
		If ($vb_ok)
			Use (Storage:C1525.curl)
				Storage:C1525.curl.caPath:=$vt_caPath
			End use 
		Else 
			
			  //COPY ARRAY($tl_curlKeysCommon;$tl_curlKeys)
			  //COPY ARRAY($tt_curlValuesCommon;$tt_curlValues)
			
			  //ARRAY TEXT(tt_CURL_httpHeaders;0)
			
			$vt_callbackMethod:=""
			$vt_headerInfo:=""
			$vo_transferInfo:=Null:C1517
			
			  //<Modif> Bruno LEGAY (BLE) (04/01/2022) - v3.00.01
			$vo_curlOptions.HTTPGET:=1
			  //<Modif>
			
			OB REMOVE:C1226($vo_curlOptions;"NOBODY")
			C_TEXT:C284($vt_curlOptionsJson)
			$vt_curlOptionsJson:=JSON Stringify:C1217($vo_curlOptions)
			
			C_LONGINT:C283($vl_curlError)
			
			C_LONGINT:C283($vl_durationMs)
			$vl_durationMs:=Milliseconds:C459
			
			  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
			  // https://github.com/miyako/4d-plugin-curl-v3
			C_OBJECT:C1216($vo_curlResponse)
			$vo_curlResponse:=cURL ($vo_curlOptions;$vx_curlRequestBody;$vx_curlResponseBody;$vt_callbackMethod)
			$vl_curlError:=$vo_curlResponse.status
			$vt_headerInfo:=$vo_curlResponse.headerInfo
			$vo_transferInfo:=$vo_curlResponse.transferInfo
			
			  // https://github.com/miyako/4d-plugin-curl-v2
			  //$vl_curlError:=cURL ($vt_url;$tl_curlKeys;$tt_curlValues;$vx_curlRequestBody;$vx_curlResponseBody;$vt_callbackMethod;$vo_transferInfo;$vt_headerInfo)
			  //<Modif>
			
			$vl_durationMs:=LONG_durationDifference ($vl_durationMs;Milliseconds:C459)
			
			If (($vl_curlError=0) & (Length:C16($vt_headerInfo)>0))
				
				  //<Modif> Bruno LEGAY (BLE) (30/07/2021)
				C_COLLECTION:C1488($co_responseHeaders)
				$co_responseHeaders:=Split string:C1554($vt_headerInfo;"\r\n\r\n";sk ignore empty strings:K86:1)
				If ($co_responseHeaders.length>1)
					C_TEXT:C284($vt_headerFinal)
					$vt_headerFinal:=$co_responseHeaders[$co_responseHeaders.length-1]  // get last "element" headers from the effective url
					
					CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url : \""+$vo_curlOptions.URL+"\""+\
						", verb : \"GET\""+\
						", headers (all) : \r"+$vt_headerInfo+"\r"+\
						", headers (effective url) : \""+$vt_headerFinal)
					
					$vt_headerInfo:=$vt_headerFinal
					
				End if 
				  //<Modif>
				
				C_COLLECTION:C1488($co_responseHeaders)
				$co_responseHeaders:=Split string:C1554($vt_headerInfo;"\r\n";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
				
				  // remove headers from redirect, etc... 
				C_TEXT:C284($vt_httpStatusLine)
				$vt_httpStatusLine:=$co_responseHeaders[0]  // "HTTP/2 200"
				
				  //ARRAY TEXT($tt_headers;0)
				  //COPY ARRAY(tt_CURL_httpHeaders;$tt_headers)
				  //ARRAY TEXT(tt_CURL_httpHeaders;0)
				
				  // remove headers from redirect, etc... 
				  //C_TEXT($vt_httpStatusLine)
				  //$vt_httpStatusLine:=CURL__httpRequestCleanHeaders (->$tt_headers)
				
				CURL__moduleDebugDateTimeLine (4;Current method name:C684;"GET url : \""+$vo_curlOptions.URL+"\""+\
					", error : "+CURL_errorToText ($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
					", status line : \""+$vt_httpStatusLine+"\""+\
					", request size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
					", response size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
					", duration : "+CURL__debugMilliseconds ($vl_durationMs)+"\r"+\
					", curl options : "+$vt_curlOptionsJson+"\r"+\
					", transfer infos : "+JSON Stringify:C1217($vo_transferInfo)+"\r"+\
					", header infos : "+$vt_headerInfo)
				
				If (CURL__httpStatusLineToStatus ($vt_httpStatusLine)=200)
					C_TEXT:C284($vt_caPath)
					
					$vb_ok:=CURL__caPrefSave (->$vx_curlResponseBody;$vt_lastModifiedIso8601;->$vt_caPath)
					
					If ($vb_ok)
						Use (Storage:C1525.curl)
							Storage:C1525.curl.caPath:=$vt_caPath
						End use 
					End if 
					  //$vb_ok:=CURL__caPrefSave (->$vx_curlResponseBody;$vt_lastModifiedIso8601;-><>vt_CURL_caPath)
					
					
				Else 
					
					CURL__moduleDebugDateTimeLine (2;Current method name:C684;"GET failed, url : \""+$vo_curlOptions.URL+"\""+\
						", error : "+CURL_errorToText ($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
						", request size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
						", response size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
						", duration : "+CURL__debugMilliseconds ($vl_durationMs)+"\r"+\
						", curl options :\r"+$vt_curlOptionsJson+"\r"+\
						", transfer infos :\r"+JSON Stringify:C1217($vo_transferInfo)+"\r"+\
						", header infos :\r"+$vt_headerInfo)
					
				End if 
			End if 
			
		End if 
	End if 
	
	
Else 
	
	  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
	  // Exemple de message affiché
	  // 2021-04-09T12:06:22.036 - curl - 04 - CURL_caRefresh ==> HEAD url : "https://curl.se/ca/cacert.pem", error : CURLE_OPERATION_TIMEDOUT (28) : Operation timeout. The specified time-out period was reached according to the conditions. (28), status line : "", request size : 0 byte(s), response size : 0 byte(s), duration : 30,106s
	  // dans ce cas $vt_httpStatusLine:=$co_responseHeaders[0] donne une erreur 
	  // mieux gérer cette #todo
	
	CURL__moduleDebugDateTimeLine (2;Current method name:C684;"HEAD failed, url : \""+$vo_curlOptions.URL+"\""+\
		", error : "+CURL_errorToText ($vl_curlError)+" ("+String:C10($vl_curlError)+")"+\
		", request size : "+String:C10(BLOB size:C605($vx_curlRequestBody))+" byte(s)"+\
		", response size : "+String:C10(BLOB size:C605($vx_curlResponseBody))+" byte(s)"+\
		", duration : "+CURL__debugMilliseconds ($vl_durationMs)+"\r"+\
		", curl options :\r"+$vt_curlOptionsJson+"\r"+\
		", transfer infos :\r"+JSON Stringify:C1217($vo_transferInfo)+"\r"+\
		", header infos :\r"+$vt_headerInfo)
	
	  //<Modif>
End if 

  //ARRAY TEXT(tt_CURL_httpHeaders;0)
$0:=$vb_ok