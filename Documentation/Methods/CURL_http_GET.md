# **Method :** CURL_http_GET
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function uses curl plugin to do a http GET
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | error | LONGINT | error code (0 = no error) | 
| $1 | IN | $vt_url | TEXT | url | 
| $2 | IN | options | OBJECT | option object | 
| $3 | OUT | responseBodyPtr | POINTER | response body blob pointer (modified) | 
| $4 | INOUT | httpHeaders | POINTER | pointer to a text array for headers (optional) | 

## **Notes :** 

## **Example :** 
```
CURL_http_GET
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:31:18 - 1.00.00
