//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

C_TEXT:C284($vt_url)
  //$vt_url:="https://curl.haxx.se/ca/cacert.pem"
  //$vt_url:="https://curl.se/ca/cacert.pem"
$vt_url:=CURL__cacertUrlDefault 

C_OBJECT:C1216($vo_options)
$vo_options:=New object:C1471("request";New object:C1471("headers";New collection:C1472("Accept: application/x-pem-file")))

  //CURL_curlOptionsSet (->$vo_options;CURLOPT_HTTPHEADER;"Accept: application/x-pem-file")

  //ARRAY TEXT($tt_headers;0)
  //APPEND TO ARRAY($tt_headers;"Accept: application/x-pem-file")

C_BLOB:C604($vx_cacertPem)
SET BLOB SIZE:C606($vx_cacertPem;0)
C_LONGINT:C283($vl_error)
$vl_error:=CURL_http_GET ($vt_url;$vo_options;->$vx_cacertPem)
If ($vl_error=0)  // ;->$tt_headers
	
	If ($vo_options.status=200)
		  //If (CURL_http_headersArrayToStatus (->$tt_headers)=200)
		
		  // HTTP/1.1 200 OK
		  // Server: Apache
		  // X-Frame-Options: SAMEORIGIN
		  // Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT
		  // ETag: "39a1d-559965729d817"
		  // Cache-Control: max-age=43200
		  // Expires: Fri, 22 Sep 2017 12:03:03 GMT
		  // Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
		  // Content-Type: application/x-pem-file
		  // Via: 1.1 varnish
		  // Fastly-Debug-Digest: 84634dfb641e25b82c7745bdf6f300465a03e36a036ca753fbdea04bea45e642
		  // Content-Length: 236061
		  // Accept-Ranges: bytes
		  // Date: Fri, 29 Sep 2017 12:45:49 GMT
		  // Via: 1.1 varnish
		  // Age: 5264
		  // Connection: keep-alive
		  // X-Served-By: cache-bma7021-BMA, cache-lcy1150-LCY
		  // X-Cache: HIT, HIT
		  // X-Cache-Hits: 447, 82
		  // X-Timer: S1506689150.735595,VS0,VE0
		
		  // note : the file is in UTF-8 format, lf delimited, without a BOM - this is ok for CURL
		
		C_TEXT:C284($vt_lastModifiedrfc1123)
		$vt_lastModifiedrfc1123:=CURL_httpHeadersCollValueGet ($vo_options.response.headers;"Last-Modified")
		
		  //C_TEXT($vt_lastModifiedrfc1123)
		  //$vt_lastModifiedrfc1123:=CURL_http_headersArrayValueGet (->$tt_headers;"Last-Modified")
		
		C_DATE:C307($vd_date)
		C_TIME:C306($vh_time)
		C_TEXT:C284($vt_timezone)
		
		DAT_rfc1123ToDatTimeZone ($vt_lastModifiedrfc1123;->$vd_date;->$vh_time;->$vt_timezone)
		DAT_dateTimeWithTimezoneToLocal (->$vd_date;->$vh_time;$vt_timezone)
		
		C_BOOLEAN:C305($vb_createFile)
		$vb_createFile:=False:C215
		
		C_TEXT:C284($vt_pemPath)
		$vt_pemPath:=CURL__caPemFileDefaultPath 
		If (Test path name:C476($vt_pemPath)=Is a document:K24:1)
			
			C_BLOB:C604($vx_cacertPemOld)
			SET BLOB SIZE:C606($vx_cacertPemOld;0)
			
			DOCUMENT TO BLOB:C525($vt_pemPath;$vx_cacertPemOld)
			If (Generate digest:C1147($vx_cacertPem;SHA1 digest:K66:2)#Generate digest:C1147($vx_cacertPemOld;SHA1 digest:K66:2))
				CONFIRM:C162("Update CA Certificates pem file (in curllib_component resource dir) ?")
				If (ok=1)
					
					C_TEXT:C284($vt_timestampStr)
					$vt_timestampStr:=Replace string:C233(Replace string:C233(String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178);":";"";*);"-";"";*)
					
					MOVE DOCUMENT:C540($vt_pemPath;Substring:C12($vt_pemPath;1;Length:C16($vt_pemPath)-4)+"-old-"+$vt_timestampStr+".pem")
					ASSERT:C1129(ok=1;"failed to move file \""+$vt_pemPath+"\".")
					
					$vb_createFile:=True:C214
				End if 
			Else 
				ALERT:C41("CA Certificates pem file (in curllib_component resource dir) is up to date.")
			End if 
			
			SET BLOB SIZE:C606($vx_cacertPemOld;0)
		Else 
			$vb_createFile:=True:C214
		End if 
		
		If ($vb_createFile)
			BLOB TO DOCUMENT:C526($vt_pemPath;$vx_cacertPem)
			ASSERT:C1129(ok=1;"failed to create file \""+$vt_pemPath+"\".")
			
			UTL_fileCreationDateTimeSet ($vt_pemPath;$vd_date;$vh_time)
			UTL_fileModifcationDateTimeSet ($vt_pemPath;$vd_date;$vh_time)
			
			SHOW ON DISK:C922($vt_pemPath)
		End if 
		
	End if 
End if 

SET BLOB SIZE:C606($vx_cacertPem;0)
ARRAY TEXT:C222($tt_headers;0)
