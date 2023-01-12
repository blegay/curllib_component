# **Method :** CURL_pluginVersionGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns curl plugin version (e.g. "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0")
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | paramName | TEXT | curl plugin version | 

## **Notes :** 
value returned by "cURL Get version"
## **Example :** 
```
CURL_pluginVersionGet => 
       "libcurl/7.75.0 OpenSSL/1.1.1g zlib/1.2.11 libssh2/1.9.0"
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 19/11/2019, 15:56:40 - 1.00.08
