# **Method :** CURL_httpObjCall
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function will make an http request
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | error | LONGINT | error code (0 if no error) | 
| $1 | IN | httpObj | OBJECT | ParamDescription | 
| $2 | IN | requestBodyBlobPtr | POINTER | request body blob pointer (modified, optional) | 
| $3 | IN | responseBodyBlobPtr | POINTER | response body blob (modified, optional) | 

## **Notes :** 

## **Example :** 
```
CURL_httpObjCall
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:09:00 - v1.00.08
