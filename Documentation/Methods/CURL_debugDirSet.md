# **Method :** CURL_debugDirSet
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This method sets the folder debug path
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $1 | IN | debugDirPath | TEXT | folder dir path | 

## **Notes :** 
this applies to all processes
       CURLINFO_TEXT.log
       CURLINFO_HEADER_OUT.log
       CURLINFO_DATA_IN.log
       CURLINFO_SSL_DATA_OUT.log
       CURLINFO_SSL_DATA_IN.log
       CURLINFO_HEADER_IN.log
## **Example :** 
```
CURL_debugDirSet (Get 4D folder(Logs folder))
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2021
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 12/01/2021, 12:37:07 - 2.00.03
