# **Method :** CURL_httpRequestNew
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function creates an http object for a curl http request
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | httpObject | OBJECT | http object | 
| $1 | IN | verb | TEXT | http verb (e.g. "GET", POST", "PUT", "DELETE", HEAD", optional, default "GET) | 
| $2 | IN | url | TEXT | url (optional, default "http://") | 

## **Notes :** 

## **Example :** 
```
CURL_httpRequestNew
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 18/11/2019, 20:55:40 - 1.00.08
