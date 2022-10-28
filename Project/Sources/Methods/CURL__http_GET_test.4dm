//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//C_TEXT($vt_url)
//$vt_url:="https://www.apple.com"
//C_OBJECT($vo_curlOptions)

//C_LONGINT($vl_progressId)
//$vl_progressId:=Progress New 
//Progress SET PROGRESS ($vl_progressId;-1)

//CURL_curlOptionsProgressSet(->$vo_curlOptions;$vl_progressId)


//C_LONGINT($vl_ms;$vl_iters)
//$vl_iters:=1000
//$vl_ms:=Milliseconds

//C_BLOB($vx_httpResponseBody)
//ARRAY TEXT($tt_headers;0)
//C_LONGINT($i)
//For ($i;1;$vl_iters)
//SET BLOB SIZE($vx_httpResponseBody;0)

//Progress SET TITLE ($vl_progressId;"download "+String($i))
//ASSERT(CURL_http_GET ($vt_url;$vo_curlOptions;->$vx_httpResponseBody)=0)

//SET BLOB SIZE($vx_httpResponseBody;0)
//End for 

//$vl_ms:=Milliseconds-$vl_ms

//Progress QUIT ($vl_progressId)


//ALERT("iters : "+String($vl_iters)+"\rtotal time "+String($vl_ms\1000)+"s\ravg : "+String(($vl_ms/$vl_iters)/1000)+"s per http GET")

//CLEAR VARIABLE($vo_curlOptions)

//$vl_ms:=Milliseconds

//C_BLOB($vx_httpResponseBody)
//For ($i;1;1000)
//SET BLOB SIZE($vx_httpResponseBody;0)
//ARRAY TEXT($tt_headers;0)

//ASSERT(CURL_http_GET ($vt_url;$vo_curlOptions;->$vx_httpResponseBody;->$tt_headers)=0)

//ASSERT(CURL_http_headersArrayToStatus(->$tt_headers)=200)

//ASSERT(Num(CURL_http_headersArrayValueGet(->$tt_headers;"Content-Length"))=BLOB size($vx_httpResponseBody))

//ARRAY TEXT($tt_headers;0)
//SET BLOB SIZE($vx_httpResponseBody;0)
//End for 

//$vl_ms:=Milliseconds-$vl_ms
//ALERT("iters : "+String($vl_iters)+"\rtotal time "+String($vl_ms\1000)+"s\ravg : "+String(($vl_ms/$vl_iters)/1000)+"s per http GET")
