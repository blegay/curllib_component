# **Method :** CURL_curlOptionsObjTimeoutConnS
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method will set the connect timeout in the "option" object
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $1 | INOUT | curlOptions | OBJECT | curl options object (modified) | 
| $2 | IN | timeoutSecs | TEXT | timeout in seconds | 

## **Notes :** 
this is the transfer timeout (default 300 seconds = 5 minutes)
## **Example :** 
```
CURL_curlOptionsObjTimeoutConnS
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:05:09 - 1.00.00
