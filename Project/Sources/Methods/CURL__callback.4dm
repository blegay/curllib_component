//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_BOOLEAN:C305($0; $vb_abort)
C_OBJECT:C1216($1; $vo_transferInfo)
C_TEXT:C284($2; $vt_userInfos)  // $vo_curlOptions.PRIVATE in CURL__httpRequestObj

$vb_abort:=False:C215
$vo_transferInfo:=$1
$vt_userInfos:=$2

If ($vo_transferInfo#Null:C1517)
	
	If (False:C215)
		// $vo_transferInfo
		
		//   {
		//      "appConnectTime" : 0.34377999999999997,
		//      "conditionUnmet" : 0,
		//      "connectCode" : 0,
		//      "connectTime" : 0.176762,
		//      "contentLengthDownload" : 1042157,
		//      "contentLengthUpload" : -1,
		//      "contentType" : "application/pdf",
		//      "effectiveUrl" : "https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf",
		//      "fileTime" : -1,
		//      "ftpEntryPath" : "",
		//      "headerSize" : 298,
		//      "httpAuthAvail" : 0,
		//      "lastSocket" : -1,
		//      "localIp" : "192.168.235.146",
		//      "localPort" : 49703,
		//      "nameLookupTime" : 0.101493,
		//      "numConnects" : 1,
		//      "osErrNo" : 0,
		//      "preTransferTime" : 0.34382200000000002,
		//      "primaryIp" : "185.135.88.81",
		//      "primaryPort" : 443,
		//      "proxyAuthAvail" : 0,
		//      "redirectCount" : 0,
		//      "redirectTime" : 0.0,
		//      "redirectUrl" : "",
		//      "requestSize" : 238,
		//      "responseCode" : 200,
		//      "rtspClientCseq" : 0,
		//      "rtspCseqRecv" : 0,
		//      "rtspServerCseq" : 0,
		//      "rtspSessionId" : "",
		//      "sizeDownload" : 163840,
		//      "sizeUpload" : 0,
		//      "speedDownload" : 180242,
		//      "speedUpload" : 0,
		//      "sslVerifyResult" : 0,
		//      "startTransferTime" : 0.42521300000000001,
		//      "totalTime" : 0.90970200000000001
		//   }
		
		
		
		//   {
		//      "appConnectTime" : 0.0,
		//      "conditionUnmet" : 0,
		//      "connectCode" : 0,
		//      "connectTime" : 0.0,
		//      "contentLengthDownload" : -1,
		//      "contentLengthUpload" : -1,
		//      "contentType" : "",
		//      "effectiveUrl" : "https://www.apple.com",
		//      "fileTime" : -1,
		//      "ftpEntryPath" : "",
		//      "headerSize" : 0,
		//      "httpAuthAvail" : 0,
		//      "lastSocket" : -1,
		//      "localIp" : "",
		//      "localPort" : 0,
		//      "nameLookupTime" : 0.14392199999999999,
		//      "numConnects" : 1,
		//      "osErrNo" : 0,
		//      "preTransferTime" : 0.0,
		//      "primaryIp" : "",
		//      "primaryPort" : 0,
		//      "proxyAuthAvail" : 0,
		//      "redirectCount" : 0,
		//      "redirectTime" : 0.0,
		//      "redirectUrl" : "",
		//      "requestSize" : 0,
		//      "responseCode" : 0,
		//      "rtspClientCseq" : 0,
		//      "rtspCseqRecv" : 0,
		//      "rtspServerCseq" : 0,
		//      "rtspSessionId" : "",
		//      "sizeDownload" : 0,
		//      "sizeUpload" : 0,
		//      "speedDownload" : 0,
		//      "speedUpload" : 0,
		//      "sslVerifyResult" : 0,
		//      "startTransferTime" : 0.0,
		//      "totalTime" : 0.14402499999999999
		//   }
	End if 
	
	If (Length:C16($vt_userInfos)>0)
		C_OBJECT:C1216($vo_userInfos)
		$vo_userInfos:=JSON Parse:C1218($vt_userInfos)
		
		If ($vo_userInfos#Null:C1517)
			If (OB Is defined:C1231($vo_userInfos; "progressId"))
				C_LONGINT:C283($vl_progressId)
				$vl_progressId:=OB Get:C1224($vo_userInfos; "progressId")
				
				If ($vl_progressId#0)
					
					C_REAL:C285($vr_contentLengthDownload; $vr_sizeDownload; $vr_speedDownload)
					$vr_contentLengthDownload:=$vo_transferInfo.contentLengthDownload
					$vr_sizeDownload:=$vo_transferInfo.sizeDownload
					$vr_speedDownload:=$vo_transferInfo.speedDownload  // bytes/sec
					
					C_REAL:C285($vr_contentLengthUpload; $vr_sizeUpload; $vr_speedUpload)
					$vr_contentLengthUpload:=$vo_transferInfo.contentLengthUpload
					$vr_sizeUpload:=$vo_transferInfo.sizeUpload
					$vr_speedUpload:=$vo_transferInfo.speedUpload  // bytes/sec
					
					C_REAL:C285($vr_startTransferTime; $vr_totalTime; $vr_elapsed; $vr_estimatedTimeleft)
					$vr_startTransferTime:=$vo_transferInfo.startTransferTime
					$vr_totalTime:=$vo_transferInfo.totalTime
					$vr_elapsed:=$vr_totalTime-$vr_startTransferTime
					
					
					C_TEXT:C284($vt_message)
					Case of 
						: ($vr_contentLengthDownload>0)
							$vt_message:=DBG__bytes($vr_sizeDownload)+" / "+DBG__bytes($vr_contentLengthDownload)+" bytes"
							
						: ($vr_contentLengthUpload>0)
							$vt_message:=DBG__bytes($vr_sizeUpload)+" / "+DBG__bytes($vr_contentLengthUpload)+" bytes"
							
					End case 
					
					C_REAL:C285($vr_progress)
					Case of 
						: (($vr_contentLengthDownload<=0) & ($vr_contentLengthUpload<=0))
							$vr_progress:=-1
							
						: ((($vr_sizeDownload>$vr_contentLengthDownload) & ($vr_contentLengthDownload>=0)) | \
							(($vr_sizeUpload>$vr_contentLengthUpload) & ($vr_contentLengthUpload>=0)))
							$vr_progress:=1
							
						: (($vr_contentLengthDownload>0) & ($vr_speedDownload>0))
							
							$vr_progress:=$vr_sizeDownload/$vr_contentLengthDownload
							
							$vt_message:=$vt_message+", down speed : "+DBG__bytes($vr_speedDownload)+"/s"
							
							If ($vr_progress>0)
								$vr_estimatedTimeleft:=($vr_contentLengthDownload-$vr_sizeDownload)/$vr_speedDownload
								
								$vt_message:=$vt_message+", ETA : "+UTL_timeleftString($vr_estimatedTimeleft)
							End if 
							
						: (($vr_contentLengthUpload>0) & ($vr_speedUpload>0))
							
							$vr_progress:=$vr_sizeUpload/$vr_contentLengthUpload
							
							$vt_message:=$vt_message+", up speed : "+DBG__bytes($vr_speedUpload)+"/s"
							
							If ($vr_progress>0)
								$vr_estimatedTimeleft:=($vr_contentLengthUpload-$vr_sizeUpload)/$vr_speedUpload
								
								$vt_message:=$vt_message+", ETA : "+UTL_timeleftString($vr_estimatedTimeleft)
							End if 
							
						Else 
							$vr_progress:=-1
					End case 
					
					CURL__moduleDebugDateTimeLine(6; Current method name:C684; "progressId : "+String:C10($vl_progressId)+", progress : "+String:C10($vr_progress)+", message : \""+$vt_message+"\"\r"+JSON Stringify:C1217($vo_transferInfo; *))
					
					// 26/05/2020 11:39:57 - curl - 04 - CURL__callback ==> progressId : 1, progress : 0
					// 26/05/2020 11:39:58 - curl - 04 - CURL__callback ==> progressId : 1, progress : 0,2829823145649
					// 26/05/2020 11:39:59 - curl - 04 - CURL__callback ==> progressId : 1, progress : 0,7860619849025
					// 26/05/2020 11:39:59 - curl - 04 - CURL__httpRequestObj ==> url : "https://file-examples.com/wp-content/uploads/2017/10/file-example_PDF_1MB.pdf", error : OK (0), status line : "HTTP/1.1 200 OK", request size : 0 byte(s), response size : 1042157 byte(s), duration : 2,771s
					
					//%T- 
					EXECUTE METHOD:C1007("CURL__progressUpdate"; $vb_abort; $vl_progressId; $vr_progress; $vt_message)
					//$vb_abort:=CURL__progressUpdate ($vl_progressId;$vr_progress;$vt_message)
					//Progress SET PROGRESS ($vl_progressId;$vr_progress;$vt_message)
					//$vb_abort:=Progress Stopped ($vl_progressId)
					//%T+
					
					// cURL will return -42 if user aborts
					
					If ($vb_abort)
						CURL__moduleDebugDateTimeLine(2; Current method name:C684; "progressId : "+String:C10($vl_progressId)+", user abort : TRUE !")
					End if 
					
				End if 
				
			End if 
		End if 
		
	End if 
	
End if 

$0:=$vb_abort