//%attributes = {"shared":false,"invisible":true}
C_TEXT:C284($vt_url)
  //$vt_url:="https://www.apple.com"
$vt_url:="https://curl.se/ca/cacert.pem"
C_OBJECT:C1216($vo_curlOptions)

C_LONGINT:C283($vl_progressId)
$vl_progressId:=Progress New 
Progress SET PROGRESS ($vl_progressId;-1)

  //C_OBJECT($vo_curlObj)
  //$vo_curlOptions:=CURL_httpRequestNew

  // CURL__curlOptionsProgressSet
  //CURL__curlOptionsProgressSet (->$vo_curlOptions;$vl_progressId)


C_LONGINT:C283($vl_ms;$vl_iters)
  //$vl_iters:=1000
$vl_iters:=10
$vl_ms:=Milliseconds:C459

C_BLOB:C604($vx_httpResponseBody)
ARRAY TEXT:C222($tt_headers;0)
C_LONGINT:C283($i)
For ($i;1;$vl_iters)
	
	C_OBJECT:C1216($vo_curlOptions)
	$vo_curlOptions:=CURL_httpRequestNew 
	$vo_curlOptions.progressShow:=True:C214
	$vo_curlOptions.progressTitle:="progress test"
	$vo_curlOptions.progressAbortable:=True:C214
	
	  //$vo_curlOptions.request.curlOptions.MAX_RECV_SPEED:=10000
	
	SET BLOB SIZE:C606($vx_httpResponseBody;0)
	
	Progress SET TITLE ($vl_progressId;"download "+String:C10($i))
	ASSERT:C1129(CURL_http_GET ($vt_url;$vo_curlOptions;->$vx_httpResponseBody)=0)
	
	
	SET BLOB SIZE:C606($vx_httpResponseBody;0)
End for 

$vl_ms:=Milliseconds:C459-$vl_ms

Progress QUIT ($vl_progressId)
Progress QUIT (0)


ALERT:C41("iters : "+String:C10($vl_iters)+"\rtotal time "+String:C10($vl_ms\1000)+"s\ravg : "+String:C10(($vl_ms/$vl_iters)/1000)+"s per http GET")

CLEAR VARIABLE:C89($vo_curlOptions)

If (False:C215)
	
	
	$vo_curlOptions:=New object:C1471
	
	$vl_ms:=Milliseconds:C459
	
	C_BLOB:C604($vx_httpResponseBody)
	For ($i;1;1000)
		SET BLOB SIZE:C606($vx_httpResponseBody;0)
		ARRAY TEXT:C222($tt_headers;0)
		
		ASSERT:C1129(CURL_http_GET ($vt_url;$vo_curlOptions;->$vx_httpResponseBody;->$tt_headers)=0)
		
		ASSERT:C1129(CURL_httpRequestStatusGet ($vo_curlOptions)=200)
		  //ASSERT(CURL_http_headersArrayToStatus(->$tt_headers)=200)
		
		
		C_COLLECTION:C1488($co_httpResponseHeaders)
		$co_httpResponseHeaders:=New collection:C1472
		
		ARRAY TO COLLECTION:C1563($co_httpResponseHeaders;$tt_headers)
		
		ASSERT:C1129(Num:C11(CURL_httpHeadersCollValueGet ($co_httpResponseHeaders;"Content-Length"))=BLOB size:C605($vx_httpResponseBody))
		  //ASSERT(Num(CURL_http_headersArrayValueGet(->$tt_headers;"Content-Length"))=BLOB size($vx_httpResponseBody))
		
		ARRAY TEXT:C222($tt_headers;0)
		SET BLOB SIZE:C606($vx_httpResponseBody;0)
	End for 
	
	$vl_ms:=Milliseconds:C459-$vl_ms
	ALERT:C41("iters : "+String:C10($vl_iters)+"\rtotal time "+String:C10($vl_ms\1000)+"s\ravg : "+String:C10(($vl_ms/$vl_iters)/1000)+"s per http GET")
End if 