//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_OBJECT:C1216($1; $vo_curlOptions)
C_TEXT:C284($2; $vt_url)
C_TEXT:C284($3; $vt_verb)
C_POINTER:C301($4; $vp_extraHttpHeaderLinesArrayPtr)
C_TEXT:C284($5; $vt_contentType)

$vo_curlOptions:=$1
$vt_url:=$2
$vt_verb:=$3
$vp_extraHttpHeaderLinesArrayPtr:=$4
If (Count parameters:C259>4)
	$vt_contentType:=$5
End if 

If ($vo_curlOptions.request=Null:C1517)
	$vo_curlOptions.request:=New object:C1471
End if 
If ($vo_curlOptions.request.curlOptions=Null:C1517)
	$vo_curlOptions.request.curlOptions:=New object:C1471
End if 

If ($vo_curlOptions.progressShow=Null:C1517)
	$vo_curlOptions.progressShow:=False:C215
End if 
If ($vo_curlOptions.progressTitle=Null:C1517)
	$vo_curlOptions.progressTitle:=""
End if 
If ($vo_curlOptions.progressAbortable=Null:C1517)
	$vo_curlOptions.progressAbortable:=False:C215
End if 

$vo_curlOptions.url:=$vt_url
$vo_curlOptions.verb:=$vt_verb  //"GET"

$vo_curlOptions.request.curlOptions.URL:=$vt_url
Case of 
	: ($vt_verb="GET")
		$vo_curlOptions.request.curlOptions.HTTPGET:=1
		
	: ($vt_verb="HEAD")
		$vo_curlOptions.request.curlOptions.NOBODY:=1
		
	: ($vt_verb="POST")
		$vo_curlOptions.request.curlOptions.POST:=1
		
	: ($vt_verb="PUT")
		$vo_curlOptions.request.curlOptions.PUT:=1
		
	: ($vt_verb="DELETE")
		$vo_curlOptions.request.curlOptions.CUSTOMREQUEST:="DELETE"
		
	Else 
		$vo_curlOptions.request.curlOptions.CUSTOMREQUEST:=$vt_verb
		
End case 


//<Modif> Bruno LEGAY (BLE) (02/06/2020)
// headers response will be of the redirect (status 301)
// https://github.com/miyako/4d-plugin-curl-v2/issues/5

//<Modif> Bruno LEGAY (BLE) (03/06/2020)

CURL__optionsObjLong($vo_curlOptions.request.curlOptions; "FOLLOWLOCATION"; 1; False:C215)
//<Modif>


// CURL__optionsObjLong ($vo_curlOptions.request.curlOptions;"FOLLOWLOCATION";1;False)
//<Modif>



//If ($vt_url:="https://@")
// we could get a "http://" redirected to "https://" so always assume https
CURL__sslParamsObj($vo_curlOptions.request.curlOptions)
//End if 

//<Modif> Bruno LEGAY (BLE) (12/01/2021)
C_TEXT:C284($vt_debugDirPath)
$vt_debugDirPath:=CURL_debugDirGet
If (Length:C16($vt_debugDirPath)>0)
	If (Test path name:C476($vt_debugDirPath)=Is a folder:K24:2)
		
		C_TEXT:C284($vt_timestamp)
		$vt_timestamp:=String:C10(Current date:C33; Internal date short:K1:7)+"T"+Time string:C180(Current time:C178)+Substring:C12(Timestamp:C1445; 20; 4)
		// "14/11/2020T13:07:35.314"
		
		$vt_timestamp:=Substring:C12($vt_timestamp; 7; 4)+"-"+\
			Substring:C12($vt_timestamp; 4; 2)+"-"+\
			Substring:C12($vt_timestamp; 1; 2)+\
			Substring:C12($vt_timestamp; 11)
		// "2020-11-14T13:07:35.314"
		$vt_timestamp:=Replace string:C233($vt_timestamp; ":"; "-"; *)
		$vt_timestamp:=Replace string:C233($vt_timestamp; "."; "-"; *)
		// "2020-11-14T13-07-35-314"
		
		$vt_debugDirPath:=$vt_debugDirPath+"curl_debug"+Folder separator:K24:12+"curl "+$vt_timestamp+"_"+Generate UUID:C1066+Folder separator:K24:12
		
		// "2020-11-14T13-07-35-314_"
		CREATE FOLDER:C475($vt_debugDirPath; *)
		
		$vo_curlOptions.request.curlOptions.DEBUG:=$vt_debugDirPath
	End if 
End if 
//<Modif>


C_LONGINT:C283($vl_timeoutConnect)
If (OB Is defined:C1231($vo_curlOptions; "timeoutConnectSecs"))
	$vl_timeoutConnect:=OB Get:C1224($vo_curlOptions; "timeoutConnectSecs"; Is real:K8:4)
	
	//APPEND TO ARRAY($tl_keys;CURLOPT_CONNECTTIMEOUT)
	//APPEND TO ARRAY($tt_values;String($vl_timeoutConnect))
Else 
	$vl_timeoutConnect:=10
End if 
CURL_curlOptionsObjTimeoutConnS($vo_curlOptions.request.curlOptions; $vl_timeoutConnect)

C_LONGINT:C283($vl_timeout)
If (OB Is defined:C1231($vo_curlOptions; "timeoutSecs"))
	$vl_timeout:=OB Get:C1224($vo_curlOptions; "timeoutSecs"; Is real:K8:4)
	
	//APPEND TO ARRAY($tl_keys;CURLOPT_TIMEOUT)
	//APPEND TO ARRAY($tt_values;String($vl_timeout))
Else 
	$vl_timeout:=120
End if 
CURL_curlOptionsObjTimeoutSet($vo_curlOptions.request.curlOptions; $vl_timeout)


C_COLLECTION:C1488($co_httpHeaders)

ARRAY TEXT:C222($tt_httpHeaderCombined; 0)

Case of 
	: (Is nil pointer:C315($vp_extraHttpHeaderLinesArrayPtr))
	: (Type:C295($vp_extraHttpHeaderLinesArrayPtr->)=Text array:K8:16)
		
		If (Size of array:C274($vp_extraHttpHeaderLinesArrayPtr->)>0)
			//%W-518.1
			COPY ARRAY:C226($vp_extraHttpHeaderLinesArrayPtr->; $tt_httpHeaderCombined)
			//%W+518.1
			
			C_COLLECTION:C1488($co_httpHeaders)
			$co_httpHeaders:=New collection:C1472
			
			ARRAY TO COLLECTION:C1563($co_httpHeaders; $tt_httpHeaderCombined)
			$vo_curlOptions.request.curlOptions.HTTPHEADER:=$co_httpHeaders
		End if 
		
End case 


Case of 
	: (($vo_curlOptions.request.curlOptions.HTTPHEADER=Null:C1517) & ($vo_curlOptions.request.headers=Null:C1517))
	: (($vo_curlOptions.request.curlOptions.HTTPHEADER=Null:C1517) & ($vo_curlOptions.request.headers#Null:C1517))
		$vo_curlOptions.request.curlOptions.HTTPHEADER:=$vo_curlOptions.request.headers.copy()
		
	: (($vo_curlOptions.request.curlOptions.HTTPHEADER#Null:C1517) & ($vo_curlOptions.request.headers#Null:C1517))
		$vo_curlOptions.request.curlOptions.HTTPHEADER:=$vo_curlOptions.request.curlOptions.HTTPHEADER.concat($vo_curlOptions.request.headers)
		$vo_curlOptions.request.curlOptions.HTTPHEADER:=$vo_curlOptions.request.curlOptions.HTTPHEADER.distinct()
		
	Else 
		
End case 


If (Length:C16($vt_contentType)>0)
	If ($vo_curlOptions.request.curlOptions.HTTPHEADER=Null:C1517)
		$vo_curlOptions.request.curlOptions.HTTPHEADER:=New collection:C1472("Content-Type: "+$vt_contentType)
	Else 
		C_LONGINT:C283($vl_index)
		$vl_index:=$vo_curlOptions.request.curlOptions.HTTPHEADER.indexOf("Content-Type:@")
		// "Content-Type:@" matches "content-type:"
		If ($vl_index>=0)
			// if AWS signed "content-type: " we should not change it to "Content-Type: " or change it at all
			//$vo_curlOptions.request.curlOptions.HTTPHEADER[$vl_index]:="Content-Type: "+$vt_contentType
		Else 
			$vo_curlOptions.request.curlOptions.HTTPHEADER.push("Content-Type: "+$vt_contentType)
		End if 
	End if 
End if 

C_TEXT:C284($vt_headerLine)
$vt_headerLine:="User-Agent: "+CURL__userAgent
Case of 
	: ($vo_curlOptions.request.curlOptions.HTTPHEADER=Null:C1517)
		$vo_curlOptions.request.curlOptions.HTTPHEADER:=New collection:C1472($vt_headerLine)
		
	: ($vo_curlOptions.request.curlOptions.HTTPHEADER.indexOf("User-Agent:@")=-1)
		$vo_curlOptions.request.curlOptions.HTTPHEADER.push($vt_headerLine)
		
End case 

If ($vt_verb="POST")
	// https://curl.se/libcurl/c/CURLOPT_POST.html
	// disable the "Content-Type: application/x-www-form-urlencoded" header which is added by default by curl when doing a POST
	// this breaks the S3__multipartuploadComplete in AWS
	$vt_headerLine:="Content-Type:"
	Case of 
		: ($vo_curlOptions.request.curlOptions.HTTPHEADER=Null:C1517)
			$vo_curlOptions.request.curlOptions.HTTPHEADER:=New collection:C1472($vt_headerLine)
			
		: ($vo_curlOptions.request.curlOptions.HTTPHEADER.indexOf("Content-Type:@")=-1)
			$vo_curlOptions.request.curlOptions.HTTPHEADER.push($vt_headerLine)
			
	End case 
End if 

// disable the "Accept: */*" header which is added by default by curl
//$vt_headerLine:="Accept:"
//Case of 
//: ($vo_curlOptions.request.curlOptions.HTTPHEADER=Null)
//$vo_curlOptions.request.curlOptions.HTTPHEADER:=New collection($vt_headerLine)

//: ($vo_curlOptions.request.curlOptions.HTTPHEADER.indexOf("Accept:@")=-1)
//$vo_curlOptions.request.curlOptions.HTTPHEADER.push($vt_headerLine)

//End case 


//If ($vl_index>=0)

//If (Length($vt_contentType)>0)
//If (Find in array($tt_httpHeaderCombined;"Content-Type:@")=-1)

//If ($vo_curlOptions.request.curlOptions.HTTPHEADER=Null)
//$vo_curlOptions.request.curlOptions.HTTPHEADER:=New collection("Content-Type: "+$vt_contentType)
//Else 
//$vo_curlOptions.request.curlOptions.HTTPHEADER.push("Content-Type: "+$vt_contentType)
//End if 

//End if 
//End if 

ARRAY TEXT:C222($tt_httpHeaderCombined; 0)
