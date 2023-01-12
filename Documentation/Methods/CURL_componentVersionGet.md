# **Method :** CURL_componentVersionGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns the component version
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | componentVersion | TEXT | component version (e.g. "4.00.00") | 

## **Notes :** 

## **Example :** 
```
CURL_componentVersionGet
```
## **Version :** 
4.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:06:48 - 1.00.00
        MODIFICATION : Bruno LEGAY (BLE) - 27/09/2017, 18:31:11 - v1.00.01
          - fixed bug in CURL__httpRequest when using 5 parameters
          - added CURL_http_headersArrayToStatus, CURL_http_headersArrayValueGet
        MODIFICATION : Bruno LEGAY (BLE) - 28/09/2017, 18:40:41 - v1.00.02
          - added CURL_caRefresh
          - fixed bug in CURL_http_headersArrayValueGet fix bug "Last-Modified: Wed, 20 Sep 2017 03:12:05 GMT" => "05 GMT"
        MODIFICATION : Bruno LEGAY (BLE) - 29/09/2017, 13:17:31 - v1.00.03
          - scramble passwords in logs
          - added compiler directives around copy array with pointer (and few missing assert on parameter types)
          - default certficate authorities certificiate file updated (https://curl.haxx.se/ca/cacert.pem : "Wed, 20 Sep 2017 03:12:05 GMT")
        MODIFICATION : Bruno LEGAY (BLE) - 12/12/2017, 08:00:00 - v1.00.04
          - CURL__prefDirPathGet - refactoring : made component name dynamic (not hard-coded anymore)
          - CURL_headerCallback : ignore last empty "crlf" line (end of header)
          - CURL_curlOptionsProgressSet : removed CURLOPT_USERNAME and CURLOPT_PASSWORD setters, fixed comments/added documentation, added to set custom callback method
          - CURL_debugCallback : added documentation
          - made private : UTL_fileCreationDateTimeSet, UTL_fileModifcationDateTimeSet, ENV_versionStr 
        MODIFICATION : Bruno LEGAY (BLE) - 18/09/2018, 14:39:54 - v1.00.05
          - CURL_http_POST fixed CURLOPT_HTTPPOST => CURLOPT_POST
          - improved debug for CURL_OPT 
        MODIFICATION : Bruno LEGAY (BLE) - 19/11/2018, 19:00:04 - v1.00.06
          - when there was a re-direction with CURLOPT_FOLLOWLOCATION, the redirect headers (301) were returned before the final headers. 
            this is fixed, these headers are removed from the returned headers
        MODIFICATION : Bruno LEGAY (BLE) - 28/11/2018, 08:44:27 - v1.00.07
          - fixed properties on HEX_hexCharToInt and ENV_plateformeStr (made "not shared")
        MODIFICATION : Bruno LEGAY (BLE) - 18/11/2019, 20:59:08 - v1.00.08
          - CURL__sslParamsObj
          - small refactoring...
          - CURL_curlOptionsTimeoutSet et CURL_curlOptionsTimeoutConnSet (value unique)
          - disabled the "Accept: */*" header (was added by default by curl)
          - disabled the "Transfer-Encoding: chunked" header (was added by default by curl on PUT, POST, etc...)
          - added CURL_httpObjCall , CURL_httpObjHeaderGet, CURL_httpObjHeaderSet, CURL_httpObjHeadersGet, CURL_httpObjHeaderToArrCombined, CURL_httpObjNew, CURL_httpObjRequestBodySet, CURL_httpObjResponseBodyGet 
          - added CURL_urlEscape, CURL_urlUnescape, CURL_pluginVersionGet, CURL_executablePathGet, CURL_dateStringToEpoch
        MODIFICATION : Bruno LEGAY (BLE) - 27/05/2020, 22:45:07 - v2.00.00
          - 4D v18 + https://github.com/miyako/4d-plugin-curl-v2
        MODIFICATION : Bruno LEGAY (BLE) - 02/06/2020, 15:27:28 - v2.00.01
          - fixed bug in CURL_httpObjStatusGet, managed follow location / redirect
        MODIFICATION : Bruno LEGAY (BLE) - 30/11/2020, 13:02:00 - v2.00.02
          - CURL__prefDirPathGet fixed bug (permissions)
        MODIFICATION : Bruno LEGAY (BLE) - 12/01/2021, 13:55:05 - v2.00.03
          - added CURL_debugDirGet, CURL_debugDirSet, improved debug options
          - updated CURL_errorToText 
        MODIFICATION : Bruno LEGAY (BLE) - 18/03/2021, 14:49:54 - v2.00.04
          - improved CURL_caRefresh : updated url "https://curl.se/ca/cacert.pem" => "https://curl.se/ca/cacert.pem" + handled follow location
        MODIFICATION : Bruno LEGAY (BLE) - 09/04/2021, 17:20:29 - v2.00.05
          - CURL_caRefresh threw an error when there was no internet connexion
          - adedd CURL_assertGet and CURL_assertSet
        MODIFICATION : Bruno LEGAY (BLE) - 19/10/2022, 22:24:24 - v4.00.00
          - 4D v19 + 
          - https://github.com/miyako/4d-plugin-curl-v3
