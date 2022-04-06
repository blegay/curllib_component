//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_componentVersionGet
  //@scope : public
  //@deprecated : no
  //@description : This function returns the component version 
  //@parameter[0-OUT-componentVersion-TEXT] : component version (e.g. "3.00.04")
  //@notes : 
  //@example : CURL_componentVersionGet
  //@see : 
  //@version : 3.00.04
  //@author : 
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
  //    - added CURL_httpRequestCall , CURL_httpObjHeaderGet, CURL_httpHeaderSet, CURL_httpObjHeadersGet, CURL_httpHeadersToArrCombined, CURL_httpRequestNew, CURL_httpObjRequestBodySet, CURL_httpObjResponseBodyGet 
  //    - added CURL_urlEscape, CURL_urlUnescape, CURL_pluginVersionGet, CURL_executablePathGet, CURL_dateStringToEpoch
  //  MODIFICATION : Bruno LEGAY (BLE) - 27/05/2020, 22:45:07 - v2.00.00
  //    - 4D v18 + https://github.com/miyako/4d-plugin-curl-v2
  //  MODIFICATION : Bruno LEGAY (BLE) - 02/06/2020, 15:27:28 - v2.00.01
  //    - fixed bug in CURL_httpRequestStatusGet, managed follow location / redirect
  //  MODIFICATION : Bruno LEGAY (BLE) - 12/01/2021, 13:55:05 - v2.00.03
  //    - added CURL_debugDirGet, CURL_debugDirSet, improved debug options
  //    - updated CURL_errorToText 
  //  MODIFICATION : Bruno LEGAY (BLE) - 30/07/2021, 09:55:03 - v2.00.04
  //   - fixed CURL_http_HEAD where $3 was mandatory
  //   - fixed bug in CURL_caRefresh with redirect/301 response
  //  MODIFICATION : Bruno LEGAY (BLE) - 04/01/2022, 08:30:52 - v3.00.00
  //   - curl plugin v2 v3.7.4 => curl plugin v3 v4.4.0
  //      https://github.com/miyako/4d-plugin-curl-v3
  //  MODIFICATION : Bruno LEGAY (BLE) - 04/01/2022, 19:28:53 - v3.00.01
  //    - adedd CURL_assertGet and CURL_assertSet
  //    - CURL_caRefresh threw an error when there was no internet connexion
  //    - improved CURL_caRefresh : updated url "https://curl.se/ca/cacert.pem" => "https://curl.se/ca/cacert.pem" + handled follow location
  //  MODIFICATION : Bruno LEGAY (BLE) - 03/02/2022, 12:00:00 - v3.00.02
  //   - added 2 parameters to CURL_httpRequestNew
  //  MODIFICATION : Bruno LEGAY (BLE) - 08/02/2022, 19:26:55 - v3.00.03
  //   - initial commit on github
  //  MODIFICATION : Bruno LEGAY (BLE) - 06/04/2022, 14:38:36 - v3.00.04
  //   - fixed an error in CURL__httpRequestObj
  //@xdoc-end
  //================================================================================     

C_TEXT:C284($0;$vt_componentVersion)

  // #todo :
  //  - revoir la gestion des progress, 
  //  - tester les non régressions

  //<Modif> Bruno LEGAY (BLE) (06/04/2022)
  // fixed an error in CURL__httpRequestObj
$vt_componentVersion:="3.00.04"
  //<Modif>

  //<Modif> Bruno LEGAY (BLE) (08/02/2022)
  // initial commit on github
  // $vt_componentVersion:="3.00.03"
  //<Modif>

If (False:C215)
	  //<Modif> Bruno LEGAY (BLE) (03/02/2022)
	  // added 2 parameters to CURL_httpRequestNew
	  // $vt_componentVersion:="3.00.02"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
	  // $vt_componentVersion:="3.00.01"
	  //    - adedd CURL_assertGet and CURL_assertSet
	  //    - CURL_caRefresh threw an error when there was no internet connexion
	  //    - improved CURL_caRefresh : updated url "https://curl.se/ca/cacert.pem" => "https://curl.se/ca/cacert.pem" + handled follow location
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (04/01/2022)
	  //  - curl plugin v2 v3.7.4 => curl plugin v3 v4.4.0
	  // https://github.com/miyako/4d-plugin-curl-v3
	  // $vt_componentVersion:="3.00.00"
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (29/07/2021)
	  // fixed CURL_http_HEAD where $3 was mandatory
	  // fixed bug in CURL_caRefresh with redirect/301 response
	  // $vt_componentVersion:="2.00.04"
	  // https://github.com/miyako/4d-plugin-curl-v2
	  //<Modif>
	
	  //<Modif> Bruno LEGAY (BLE) (12/01/2021)
	  // added CURL_debugDirGet, CURL_debugDirSet, improved debug options
	  // updated CURL_errorToText 
	  // $vt_componentVersion:="2.00.03"
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (30/11/2020)
	  // CURL__prefDirPathGet fixed bug if "Macintosh HD:Library:Application Support:4D" does not exists (we may not have the permissions to write to that dir")
	  // $vt_componentVersion:="2.00.02"
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (02/06/2020)
	  // fixed bug in CURL_httpRequestStatusGet, managed follow location / redirect
	  //$vt_componentVersion:="2.00.01"
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (24/05/2020)
	  // 4D v18 + https://github.com/miyako/4d-plugin-curl-v2
	  // $vt_componentVersion:="2.00.00"
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (19/11/2019)
	  // there is a potential problem where http headers may be not unique. (see https://stackoverflow.com/questions/3241326/set-more-than-one-http-header-with-the-same-name)
	  // so we may need review the storage of headers in objets as key/value...
	  //<Modif>
	
	
	  //<Modif> Bruno LEGAY (BLE) (18/11/2019)
	  // disabled the "Accept: */*" header (was added by default by curl)
	  // disabled the "Transfer-Encoding: chunked" header (was added by default by curl on PUT, POST, etc...)
	  // added CURL_httpRequestCall , CURL_httpObjHeaderGet, CURL_httpHeaderSet, CURL_httpObjHeadersGet, CURL_httpHeadersToArrCombined, CURL_httpRequestNew, CURL_httpObjRequestBodySet, CURL_httpObjResponseBodyGet 
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
