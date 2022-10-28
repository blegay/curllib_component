//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//ASSERT(CURL_caRefresh )

//C_TEXT($vt_url)
//$vt_url:="https://www.apple.com"

//C_OBJECT($vo_curlOptions)

//ARRAY TEXT($tt_headers;0)

//ASSERT(CURL_http_HEAD ($vt_url;$vo_curlOptions;->$tt_headers)=0)

//ASSERT(CURL_http_headersArrayToStatus(->$tt_headers)=200)


//ARRAY TEXT($tt_headers;0)

//APPEND TO ARRAY($tt_headers;"Accept: application/json")
//ASSERT(CURL_http_HEAD ($vt_url;$vo_curlOptions;->$tt_headers)=0)

//ASSERT(CURL_http_headersArrayToStatus(->$tt_headers)=200)
