﻿# **Method :** CURL_errorToText
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a text error code from an error message
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | errorCode | TEXT | error code | 
| $1 | IN | error | LONGINT | error number | 

## **Notes :** 

## **Example :** 
```
CURL_errorToText(58) => "CURLE_SSL_CERTPROBLEM (58) : problem with the local client certificate."
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:53:35 - 1.00.00