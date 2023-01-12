# **Method :** CURL_httpObjHeaderGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a header value from a header key for the response sub object
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | headerValue | TEXT | header value | 
| $1 | IN | httpObjReponse | OBJECT | curl http object response subobject (not modified) | 
| $2 | IN | headerKey | TEXT | header key | 

## **Notes :** 

## **Example :** 
```
CURL_httpObjHeaderGet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:34:00 - v1.00.00
