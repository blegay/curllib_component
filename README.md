# curllib_component
A 4D v18+ component to help using Miyako's curl plugin v3 (v.4.4.0 and above)

https://github.com/miyako/4d-plugin-curl-v3

*****

```4d
C_OBJECT($vo_curlOptions)

$vo_curlOptions:=CURL_httpRequestNew (HTTP HEAD method;\
"https://github.com/miyako/4d-plugin-curl-v3/releases/download/4.4.4/cURL.dmg")

C_BLOB($vx_httpRequestBody;$vx_httpResponseBody)

If (CURL_httpRequestCall ($vo_curlOptions;->$vx_httpRequestBody;->$vx_httpResponseBody)=0)
	
	If (CURL_httpRequestStatusGet ($vo_curlOptions)=200)  // = $vo_curlOptions.status
		
		C_TEXT($vt_contentType)
		​$vt_contentType:=CURL_httpHeadersCollValueGet ($vo_curlOptions.response.headers;"content-type")  // => "application/octet-stream"
		
	End if 
	
End if 
```





