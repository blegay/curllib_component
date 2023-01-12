# **Method :** CURL_http_PUT
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function uses curl plugin to do a http PUT
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | error | LONGINT | error code (0 = no error) | 
| $1 | IN | $vt_url | TEXT | url | 
| $2 | IN | options | OBJECT | option object | 
| $3 | OUT | requestBodyPtr | POINTER | response body blob pointer (modified) | 
| $4 | IN | contentType | TEXTE | content-type | 
| $5 | OUT | responseBodyPtr | POINTER | response body blob pointer (modified) | 
| $6 | INOUT | httpHeaders | POINTER | pointer to a text array for headers (optional) | 

## **Notes :** 

## **Example :** 
```
CURL_http_PUT
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:47:57 - 1.00.00
