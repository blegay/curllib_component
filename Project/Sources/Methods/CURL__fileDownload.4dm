//%attributes = {"invisible":true,"preemptive":"incapable","shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__fileDownload
  //@scope : private
  //@deprecated : no
  //@description : This function downloads a resources using HTTP GET to a file
  //@parameter[0-OUT-result-OBJECT] : result
  //@parameter[1-IN-url-TEXT] : url
  //@parameter[2-IN-filepath-TEXT] : filepath
  //@notes :
  //@example : CURL__fileDownload
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history :
  //  CREATION : Bruno LEGAY (BLE) - 05/01/2022, 12:52:57 - 3.00.01
  //@xdoc-end
  //================================================================================

  // NOTE : #todo à finir (améliorer les logs, les erreurs, progress, etc...)

C_OBJECT:C1216($0;$vo_result)
C_TEXT:C284($1;$vt_url)
C_TEXT:C284($2;$vt_filepath)

$vo_result:=New object:C1471("success";False:C215;"errorText";"")
$vt_url:=$1
$vt_filepath:=$2

C_BOOLEAN:C305($vb_ok)

C_OBJECT:C1216($vo_curlOptions)
$vo_curlOptions:=CURL_httpRequestNew 

  //C_BLOB($vx_httpResponseBody)
  //SET BLOB SIZE($vx_httpResponseBody;0)
ARRAY TEXT:C222($tt_headers;0)

C_LONGINT:C283($vl_httpError)
$vl_httpError:=CURL_http_HEAD ($vt_url;$vo_curlOptions;->$tt_headers)
If ($vl_httpError=0)
	
	C_LONGINT:C283($vl_httpStatus)
	$vl_httpStatus:=CURL_httpRequestStatusGet ($vo_curlOptions)
	If ($vl_httpStatus=200)
		
		C_COLLECTION:C1488($co_httpResponseHeaders)
		$co_httpResponseHeaders:=New collection:C1472
		ARRAY TO COLLECTION:C1563($co_httpResponseHeaders;$tt_headers)
		
		C_REAL:C285($vr_fileSize)
		$vr_fileSize:=Num:C11(CURL_httpHeadersCollValueGet ($co_httpResponseHeaders;"Content-Length"))
		
		C_REAL:C285($vr_fileOffset;$vl_bufferSize)
		$vr_fileOffset:=0
		$vl_bufferSize:=1024*10
		  //$vl_bufferSize:=5242880  // 5 mb
		  //$vl_bufferSize:=1024*1024  // 1 Mb
		
		C_BOOLEAN:C305($vb_showProgress;$vb_abortable)
		$vb_showProgress:=True:C214
		$vb_abortable:=True:C214
		
		If ($vb_showProgress)  //progress
			
			C_REAL:C285($vr_fileSize;$vr_nbParts)
			$vr_nbParts:=$vr_fileSize/$vl_bufferSize
			
			C_LONGINT:C283($vl_partNumber;$vl_nbParts)
			$vl_partNumber:=1
			$vl_nbParts:=Int:C8($vr_nbParts)
			If (Dec:C9($vr_nbParts)#0)
				$vl_nbParts:=$vl_nbParts+1
			End if 
			
			C_LONGINT:C283($vl_progress)
			$vl_progress:=Progress New 
			Progress SET TITLE ($vl_progress;"multipart download")
			  //Progress SET ON STOP METHOD ($vl_progress;"S3_progressAbortCallback")
			Progress SET BUTTON ENABLED ($vl_progress;$vb_abortable)  //;Vrai)
			
			C_TEXT:C284($vt_progressThroughput)
			$vt_progressThroughput:=""
		End if 
		
		C_TIME:C306($vh_docRef)
		$vh_docRef:=Create document:C266($vt_filepath)
		If (ok=1)
			$vt_filepath:=document
			
			If ($vr_fileSize=0)
				$vb_ok:=True:C214
				$vo_result.success:=True:C214
				CURL__moduleDebugDateTimeLine (2;Current method name:C684;" created a empty file (S3 object size is 0). [OK]")
			Else 
				
				C_BOOLEAN:C305($vb_abort;$vb_exit)
				$vb_abort:=False:C215
				$vb_exit:=False:C215
				
				C_BLOB:C604($vx_responseBodyBlob)
				
				C_LONGINT:C283($vl_durationMs)
				$vl_durationMs:=Milliseconds:C459
				
				Repeat 
					
					If ($vb_showProgress)  //progress
						Progress SET PROGRESS ($vl_progress;$vr_fileOffset/$vr_fileSize;"receiving file (part "+String:C10($vl_partNumber)+" / "+String:C10($vl_nbParts)+$vt_progressThroughput+") ...")
					End if 
					
					C_OBJECT:C1216($vo_curlOptions)
					$vo_curlOptions:=CURL_httpRequestNew 
					
					If ($vb_showProgress)
						$vo_curlOptions.progressShow:=True:C214
						$vo_curlOptions.progressTitle:="downloading part "+String:C10($vl_partNumber)+" / "+String:C10($vl_nbParts)
						$vo_curlOptions.progressAbortable:=False:C215
					End if 
					
					ARRAY TEXT:C222($tt_headers;0)
					
					If ($vr_fileSize>$vl_bufferSize)
						APPEND TO ARRAY:C911($tt_headers;HTTP__range ($vr_fileOffset;$vl_bufferSize;$vr_fileSize))  // "Range: bytes=0-999"
					End if 
					  //http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35
					
					C_BLOB:C604($vx_responseBodyBlob)
					SET BLOB SIZE:C606($vx_responseBodyBlob;0)
					
					C_LONGINT:C283($vl_partThroughputMs)
					$vl_partThroughputMs:=Milliseconds:C459
					
					  // request headers : "Range: bytes=0-1023"
					
					$vl_httpError:=CURL_http_GET ($vt_url;$vo_curlOptions;->$vx_responseBodyBlob;->$tt_headers)
					
					  // response headers : "content-range: bytes 0-1023/122720"
					
					$vl_partThroughputMs:=LONG_durationDifference ($vl_partThroughputMs;Milliseconds:C459)
					
					If ($vl_httpError=0)
						$vl_httpStatus:=CURL_httpRequestStatusGet ($vo_curlOptions)
						
						$vb_ok:=HTTP_responseOk ($vl_httpStatus)  // http status 206 : "partial content" (https://httpstatuses.com/206)
						If ($vb_ok)
							
							$vr_fileOffset:=$vr_fileOffset+BLOB size:C605($vx_responseBodyBlob)
							
							SEND PACKET:C103($vh_docRef;$vx_responseBodyBlob)
							CURL__moduleDebugDateTimeLine (4;Current method name:C684;"")
							  //"url : \""+$vt_url+"\", file : \""+$vt_filepath+"\", sent "+String(BLOB size($vx_responseBodyBlob))+" to file, "+UTL__ratio ($vr_fileSize;Get document size($vt_filepath)))
							
							If ($vb_showProgress)  //progress
								$vt_progressThroughput:=UTL__throughputCalc (BLOB size:C605($vx_responseBodyBlob);$vl_partThroughputMs;$vr_fileSize-$vr_fileOffset)
								
								$vl_partNumber:=$vl_partNumber+1
							End if 
							
						Else 
							  // erreur http (status) => à voir comment on sort au bout de x tentatives ?
							CURL__moduleDebugDateTimeLine (2;Current method name:C684;"url : \""+$vt_url+"\", file \""+$vt_filepath+"\", http status : "+String:C10($vl_httpStatus)+" [KO]")
						End if 
						
					Else 
						  // erreur http (pb reseau) => à voir comment on sort au bout de x tentatives ?
					End if 
					
					SET BLOB SIZE:C606($vx_responseBodyBlob;0)
					
					If ($vb_showProgress)  //progress
						$vb_abort:=Progress Stopped ($vl_progress)
					End if 
					
					Case of 
						: ($vr_fileOffset>=$vr_fileSize)
							$vb_exit:=True:C214
							$vb_ok:=True:C214
							$vo_result.success:=True:C214
							
						: ($vb_abort)
							$vb_exit:=True:C214
							$vb_ok:=False:C215
							$vo_result.errorText:="user aborted"
							
							  //Else
							  //$vb_exit:=False
					End case 
					
				Until ($vb_exit)
				
				$vl_durationMs:=LONG_durationDifference ($vl_durationMs;Milliseconds:C459)
				
				If ($vb_abort)
					CURL__moduleDebugDateTimeLine (2;Current method name:C684;"url : \""+$vt_url+"\", file : \""+$vt_filepath+"\" download aborted by user : [KO]")
				Else 
					CURL__moduleDebugDateTimeLine (4;Current method name:C684;"url : \""+$vt_url+"\", file : \""+$vt_filepath+"\", "+UTL_throughput ($vr_fileSize;$vl_durationMs;True:C214;True:C214)+" download complete : [OK]")
				End if 
				
			End if 
			
			CLOSE DOCUMENT:C267($vh_docRef)
			
			If (Not:C34($vb_ok))  // there was a problem with the file
				If (Test path name:C476($vt_filepath)=Is a document:K24:1)
					DELETE DOCUMENT:C159($vt_filepath)
				End if 
			End if 
			
		Else 
			$vo_result.errorText:="failed to create file  \""+$vt_filepath+"\""
			CURL__moduleDebugDateTimeLine (2;Current method name:C684;"failed to create file \""+$vt_filepath+"\" (or create file canceled). [KO]")
		End if 
		
		If ($vb_showProgress)  //progress
			Progress QUIT ($vl_progress)
		End if 
		
	Else 
		$vo_result.errorText:="curl HEAD unexpected status : "+String:C10($vl_httpStatus)
	End if 
	
Else 
	$vo_result.errorText:="curl HEAD error : "+String:C10($vl_httpError)
End if 

$0:=$vo_result