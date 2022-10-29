//%attributes = {"shared":false,"invisible":true}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_curlOptionsProgressSet
  //@scope : private 
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-paramName-TEXT] : ParamDescription
  //@parameter[1-IN-paramName-OBJECT] : ParamDescription
  //@parameter[2-IN-paramName-POINTER] : ParamDescription (not modified)
  //@parameter[3-INOUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[4-OUT-paramName-POINTER] : ParamDescription (modified)
  //@parameter[5-IN-paramName-LONGINT] : ParamDescription (optional, default value : 1)
  //@notes : 
  //@example : CURL_curlOptionsProgressSet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 30/07/2021, 11:07:44 - 2.00.04
  //@xdoc-end
  //================================================================================


  //C_POINTER($1;$vp_curlOptionObjectPtr)
  //C_LONGINT($2;$vl_progressId)

  //$vp_curlOptionObjectPtr:=$1
  //$vl_progressId:=$2

  //C_OBJECT($vo_curlOptions)
  //If ($vp_curlOptionObjectPtr->=Null)
  //$vo_curlOptions:=New object
  //Else 
  //$vo_curlOptions:=$vp_curlOptionObjectPtr->
  //End if 

  //If ($vo_curlOptions.request=Null)
  //$vo_curlOptions.request:=New object
  //End if 

  //If ($vo_curlOptions.request.curlOptions=Null)
  //$vo_curlOptions.request.curlOptions:=New object
  //End if 


  //C_OBJECT($vo_private)
  //If ($vo_curlOptions.request.curlOptions.PRIVATE=Null)
  //$vo_private:=New object("progressId";$vl_progressId)
  //Else 
  //$vo_private:=JSON Parse($vo_curlOptions.request.curlOptions.PRIVATE)
  //$vo_private.progressId:=$vl_progressId
  //End if 

  //$vo_curlOptions.request.curlOptions.PRIVATE:=JSON Stringify($vo_private)

  //  // {
  //  //     "request": {
  //  //         "headers": [
  //  //             "Accept: application/x-pem-file"
  //  //         ],
  //  //         "curlOptions": {
  //  //             "URL": "https://curl.haxx.se/ca/cacert.pem",
  //  //             "NOBODY": 1,
  //  //             "FOLLOWLOCATION": 1,
  //  //             "SSL_VERIFYHOST": 2,
  //  //             "SSL_VERIFYPEER": 1,
  //  //             "USE_SSL": "CURLUSESSL_ALL",
  //  //             "CAINFO": "Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:cacert.pem",
  //  //             "CONNECTTIMEOUT": 10,
  //  //             "TIMEOUT": 120,
  //  //             "HTTPHEADER": [
  //  //                 "Accept: application/x-pem-file",
  //  //                 "User-Agent: 4D-curlComponent/2.00.04 (macOS 10.14.6 (18G103)) 4D/v18.5Final-build266755 libcurl/7.62.0 OpenSSL/1.1.0g zlib/1.2.11 libssh2/1.8.0"
  //  //             ],
  //  //             "PRIVATE": "{\"progressId\":0}"
  //  //         }
  //  //     },
  //$vp_curlOptionObjectPtr->:=$vo_curlOptions
