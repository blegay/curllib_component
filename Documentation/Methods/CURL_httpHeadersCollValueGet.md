﻿# **Method :** CURL_httpHeadersCollValueGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns a header value from a header collection for a given header key
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | headerValue | TEXT | header value | 
| $1 | IN | headersCollection | COLLECTION | headers collection | 
| $2 | IN | headerKey | TEXT | header key | 

## **Notes :** 
header key is not case sensitive
## **Example :** 
```
CURL_httpHeadersCollValueGet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 04/01/2022, 18:36:34 - 3.00.00