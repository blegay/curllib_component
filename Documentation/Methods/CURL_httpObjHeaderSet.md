﻿# **Method :** CURL_httpObjHeaderSet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method sets a header to a request object from a http object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | paramName | TEXT | ParamDescription | 
| $1 | IN | httpRequestObj | OBJECT | http.request object | 
| $2 | IN | key | TEXT | key | 
| $3 | IN | value | TEXT | value | 

## **Notes :** 

## **Example :** 
```

      
        C_OBJECT($vo_httpObj)
        $vo_httpObj:=CURL_httpObjNew 
      
        OB SET($vo_httpObj;"url";"https://curl.se/ca/cacert.pem")
        OB SET($vo_httpObj;"verb";"GET")
      
        C_OBJECT($vo_httpRequestObj)
        $vo_httpRequestObj:=OB Get($vo_httpObj;"request";Est un objet)
        CURL_httpObjHeaderSet ($vo_httpRequestObj;"Accept";"application/x-pem-file")
      
       // OR
      
        C_OBJECT($vo_httpObj)
        $vo_httpObj:=CURL_httpObjNew 
      
        $vo_httpObj.url:="https://curl.se/ca/cacert.pem"
        $vo_httpObj.verb:="GET"
      
        CURL_httpObjHeaderSet ($vo_httpObj.request;"Accept";"application/x-pem-file")
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:57:50 - 1.00.08