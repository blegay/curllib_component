# **Method :** CURL_http_HEAD
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function uses curl plugin to do a http HEAD
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | error | LONGINT | error code (0 = no error) | 
| $1 | IN | $vt_url | TEXT | url | 
| $2 | IN | options | OBJECT | option object | 
| $3 | INOUT | httpHeaders | POINTER | pointer to a text array for headers (optional) | 

## **Notes :** 

## **Example :** 
```
CURL_http_HEAD
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 28/09/2017, 17:31:45 - v1.00.00
