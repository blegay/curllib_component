//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
//================================================================================
//@xdoc-start : en
//@name : CURL_componentVersionGet
//@scope : public
//@deprecated : no
//@description : This function returns the component version 
//@parameter[0-OUT-componentVersion-TEXT] : component version (e.g. "4.01.03")
//@notes : 
//@example : CURL_componentVersionGet
//@see : 
//@version : 4.01.03
//@author : Bruno LEGAY (BLE)) - Copyrights A&C Consulting 2024
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:06:48 - v1.00.00
//  MODIFICATION : Bruno LEGAY (BLE) - 27/09/2017, 18:31:11 - v1.00.01
//    - fixed bug in CURL__httpRequest when using 5 parameters
//    - added CURL_http_headersArrayToStatus, CURL_http_headersArrayValueGet
//  MODIFICATION : Bruno LEGAY (BLE) - 28/09/2017, 18:40:41 - v1.00.02
//    - added CURL_caRefresh
//    - fixed bug in CURL_http_headersArrayValueGet fix bug "Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT" => "05 GMT"
//  MODIFICATION : Bruno LEGAY (BLE) - 29/09/2017, 13:17:31 - v1.00.03
//    - scramble passwords in logs
//    - added compiler directives around copy array with pointer (and few missing assert on parameter types)
//    - default certficate authorities certificiate file updated (https://curl.haxx.se/ca/cacert.pem : "Wed, 20 Sep 2017 03:12:05 GMT")
//  MODIFICATION : Bruno LEGAY (BLE) - 12/12/2017, 08:00:00 - v1.00.04
//    - CURL__prefDirPathGet - refactoring : made component name dynamic (not hard-coded anymore)
//    - CURL_headerCallback : ignore last empty "crlf" line (end of header)
//    - CURL_curlOptionsProgressSet : removed CURLOPT_USERNAME and CURLOPT_PASSWORD setters, fixed comments/added documentation, added to set custom callback method
//    - CURL_debugCallback : added documentation
//    - made private : UTL_fileCreationDateTimeSet, UTL_fileModifcationDateTimeSet, ENV_versionStr 
//  MODIFICATION : Bruno LEGAY (BLE) - 18/09/2018, 14:39:54 - v1.00.05
//    - CURL_http_POST fixed CURLOPT_HTTPPOST => CURLOPT_POST
//    - improved debug for CURL_OPT 
//  MODIFICATION : Bruno LEGAY (BLE) - 19/11/2018, 19:00:04 - v1.00.06
//    - when there was a re-direction with CURLOPT_FOLLOWLOCATION, the redirect headers (301) were returned before the final headers. 
//      this is fixed, these headers are removed from the returned headers
//  MODIFICATION : Bruno LEGAY (BLE) - 28/11/2018, 08:44:27 - v1.00.07
//    - fixed properties on HEX_hexCharToInt and ENV_plateformeStr (made "not shared")
//  MODIFICATION : Bruno LEGAY (BLE) - 18/11/2019, 20:59:08 - v1.00.08
//    - CURL__sslParamsObj
//    - small refactoring...
//    - CURL_curlOptionsTimeoutSet et CURL_curlOptionsTimeoutConnSet (value unique)
//    - disabled the "Accept: */*" header (was added by default by curl)
//    - disabled the "Transfer-Encoding: chunked" header (was added by default by curl on PUT, POST, etc...)
//    - added CURL_httpObjCall , CURL_httpObjHeaderGet, CURL_httpObjHeaderSet, CURL_httpObjHeadersGet, CURL_httpObjHeaderToArrCombined, CURL_httpObjNew, CURL_httpObjRequestBodySet, CURL_httpObjResponseBodyGet 
//    - added CURL_urlEscape, CURL_urlUnescape, CURL_pluginVersionGet, CURL_executablePathGet, CURL_dateStringToEpoch
//  MODIFICATION : Bruno LEGAY (BLE) - 27/05/2020, 22:45:07 - v2.00.00
//    - 4D v18 + https://github.com/miyako/4d-plugin-curl-v2
//  MODIFICATION : Bruno LEGAY (BLE) - 02/06/2020, 15:27:28 - v2.00.01
//    - fixed bug in CURL_httpObjStatusGet, managed follow location / redirect
//  MODIFICATION : Bruno LEGAY (BLE) - 30/11/2020, 13:02:00 - v2.00.02
//    - CURL__prefDirPathGet fixed bug (permissions)
//  MODIFICATION : Bruno LEGAY (BLE) - 12/01/2021, 13:55:05 - v2.00.03
//    - added CURL_debugDirGet, CURL_debugDirSet, improved debug options
//    - updated CURL_errorToText 
//  MODIFICATION : Bruno LEGAY (BLE) - 18/03/2021, 14:49:54 - v2.00.04
//    - improved CURL_caRefresh : updated url "https://curl.se/ca/cacert.pem" => "https://curl.se/ca/cacert.pem" + handled follow location
//  MODIFICATION : Bruno LEGAY (BLE) - 09/04/2021, 17:20:29 - v2.00.05
//    - CURL_caRefresh threw an error when there was no internet connexion
//    - adedd CURL_assertGet and CURL_assertSet
//  MODIFICATION : Bruno LEGAY (BLE) - 19/10/2022, 22:24:24 - v4.00.00
//    - 4D v19 + 
//    - https://github.com/miyako/4d-plugin-curl-v3
//  MODIFICATION : Bruno LEGAY (BLE) - 09/02/2023, 20:07:48 - v4.00.01
//    - fixed bug in CURL__prefDirPathGet when "/Library/Application Support/4D/" is not writable
//  MODIFICATION : Bruno LEGAY (BLE) - 12/03/2023, 11:37:32 - v4.00.02
//    - added CURL_urlPathEscape
//  MODIFICATION : Bruno LEGAY (BLE) - 16/06/2023, 17:44:31 - v4.00.03
//    - changed CURL_httpObjNew (headers is not Null but an empty collection)
//  MODIFICATION : Bruno LEGAY (BLE) - 03/01/2024, 21:41:19 - v4.00.04
//    - fix privilege error reading and writing preferences files
//    - CURL_sslParamsObj is now public
//    - update plugin to version 4.6.2
//  MODIFICATION : Bruno LEGAY (BLE) - 06/01/2024, 16:55:15 - v4.01.00
//    - added CURL_ftpNew()
//    - ftp class
//  MODIFICATION : Bruno LEGAY (BLE) - 10/01/2024, 18:25:20 - v4.01.01
//    - ftp class : new function setCurrentWorkingDirToParent()
//  MODIFICATION : Bruno LEGAY (BLE) - 10/01/2024, 18:25:20 - v4.01.02
//    - ftp class : fix bug in _progressDeinit
//    - update plugin to version 4.6.3 (rollabck)
//  MODIFICATION : Bruno LEGAY (BLE) - 10/01/2024, 16:43:25 - v4.01.03
//    - ajout de commentaires et de debug
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_componentVersion)

//<Modif> Bruno LEGAY (BLE) (15/05/2024)
$vt_componentVersion:="4.01.03"
// - ajout de commentaires et de debug
//<Modif>

If (False:C215)
	
	//<Modif> Bruno LEGAY (BLE) (14/05/2024)
	// $vt_componentVersion:="4.01.02"
	// - ftp class : fix bug in _progressDeinit
	// - update plugin to version 4.6.3 (rollback)
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (10/01/2024)
	// $vt_componentVersion:="4.01.01"
	// - ftp class : new function setCurrentWorkingDirToParent()
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (06/01/2024)
	// $vt_componentVersion:="4.01.00"
	// - added CURL_ftpNew()
	// - ftp class
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (03/01/2024)
	// $vt_componentVersion:="4.00.04"
	// - fix privilege error reading and writing preferences files
	//    https://redmine.ac-consulting.fr/issues/4483
	// - CURL_sslParamsObj is now public
	// - update plugin to version 4.6.2
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (16/06/2023)
	//    - changed CURL_httpObjNew (headers is not Null but an empty collection)
	// $vt_componentVersion:="4.00.03"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (12/03/2023)
	//  added CURL_urlPathEscape
	// $vt_componentVersion:="4.00.02"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (09/02/2023)
	// fixed bug in CURL__prefDirPathGet when "/Library/Application Support/4D/" is not writable
	// https://redmine.ac-consulting.fr/issues/3911
	// $vt_componentVersion:="4.00.01"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (19/10/2022)
	// $vt_componentVersion:="4.00.00"
	//    - 4D v19 + 
	//    - https://github.com/miyako/4d-plugin-curl-v3
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (09/04/2021)
	// CURL_caRefresh threw an error when there was no internet connexion
	// adedd CURL_assertGet and CURL_assertSet
	// $vt_componentVersion:="2.00.05"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (18/03/2021)
	// improved CURL_caRefresh : updated url "https://curl.haxx.se/ca/cacert.pem" => "https://curl.se/ca/cacert.pem" + handled follow location
	//$vt_componentVersion:="2.00.04"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (12/01/2021)
	// added CURL_debugDirGet, CURL_debugDirSet, improved debug options
	// updated CURL_errorToText 
	// $vt_componentVersion:="2.00.03"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (05/01/2021)
	// updated CURL_errorToText 
	// $vt_componentVersion:="2.00.03"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (30/11/2020)
	// CURL__prefDirPathGet fixed bug if "Macintosh HD:Library:Application Support:4D" does not exists (we may not have the permissions to write to that dir")
	// $vt_componentVersion:="2.00.02"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (02/06/2020)
	// fixed bug in CURL_httpObjStatusGet, managed follow location / redirect
	// $vt_componentVersion:="2.00.01"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (24/05/2020)
	// 4D v18 + https://github.com/miyako/4d-plugin-curl-v2
	//$vt_componentVersion:="2.00.00"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (19/11/2019)
	// there is a potential problem where http headers may be not unique. (see https://stackoverflow.com/questions/3241326/set-more-than-one-http-header-with-the-same-name)
	// so we may need review the storage of headers in objets as key/value...
	//<Modif>
	
	
	//<Modif> Bruno LEGAY (BLE) (18/11/2019)
	// disabled the "Accept: */*" header (was added by default by curl)
	// disabled the "Transfer-Encoding: chunked" header (was added by default by curl on PUT, POST, etc...)
	// added CURL_httpObjCall , CURL_httpObjHeaderGet, CURL_httpObjHeaderSet, CURL_httpObjHeadersGet, CURL_httpObjHeaderToArrCombined, CURL_httpObjNew, CURL_httpObjRequestBodySet, CURL_httpObjResponseBodyGet 
	// added CURL_urlEscape, CURL_urlUnescape, CURL_pluginVersionGet, CURL_executablePathGet, CURL_dateStringToEpoch
	// $vt_componentVersion:="1.00.08"
	//<Modif>
	
	
	//<Modif> Bruno LEGAY (BLE) (04/06/2019)
	// CURL__sslParamsObj
	//$vt_componentVersion:="1.00.08"
	//<Modif>
	
	
	//<Modif> Bruno LEGAY (BLE) (09/02/2019)
	// small refactoring...
	//<Modif>
	
	
	//<Modif> Bruno LEGAY (BLE) (17/12/2018)
	// CURL_curlOptionsTimeoutSet et CURL_curlOptionsTimeoutConnSet (value unique)
	// $vt_componentVersion:="1.00.08"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (28/11/2018)
	//    - fixed properties on HEX_hexCharToInt and ENV_plateformeStr (made "not shared")
	//$vt_componentVersion:="1.00.07"
	//<Modif>
	
	
	//<Modif> Bruno LEGAY (BLE) (19/11/2018)
	// when there was a re-direction with CURLOPT_FOLLOWLOCATION, the redirect headers (301) were returned before the final headers. 
	//  this is fixed, these headers are removed from the returned headers
	// $vt_componentVersion:="1.00.06"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (18/09/2018)
	// CURL_http_POST fixed CURLOPT_HTTPPOST => CURLOPT_POST
	// improved debug for CURL_OPT 
	// $vt_componentVersion:="1.00.05"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (12/12/2017)
	// CURL__prefDirPathGet - refactoring : made component name dynamic (not hard-coded anymore)
	// CURL_headerCallback : ignore last empty "crlf" line (end of header)
	// CURL_curlOptionsProgressSet : removed CURLOPT_USERNAME and CURLOPT_PASSWORD setters, fixed comments/added documentation, added to set custom callback method
	// CURL_debugCallback : added documentation
	// made private : UTL_fileCreationDateTimeSet, UTL_fileModifcationDateTimeSet, ENV_versionStr 
	// $vt_componentVersion:="1.00.04"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (29/09/2017)
	//    - scramble passwords in logs
	//    - added compiler directives around copy array with pointer (and few missing assert on parameter types)
	//$vt_componentVersion:="1.00.03"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (28/09/2017)
	//$vt_componentVersion:="1.00.02"
	// added CURL_caRefresh
	// fixed bug in CURL_http_headersArrayValueGet fix bug "Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT" => "05 GMT"
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (27/09/2017)
	// $vt_componentVersion:="1.00.01"
	//  fixed bug in CURL__httpRequest when using 5 parameters
	//  added CURL_http_headersArrayToStatus, CURL_http_headersArrayValueGet
	//<Modif>
	
	//<Modif> Bruno LEGAY (BLE) (26/09/2017)
	//$vt_componentVersion:="1.00.00"
	//<Modif>
	
	//$vt_componentVersion:="1.00.00"
End if 

$0:=$vt_componentVersion
