# **Method :** CURL_httpHeadersCollValueSet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method will set a header key/value in a collection of headers
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $1 | INOUT | headersCollection | COLLECTION | headers collection (modified) | 
| $2 | IN | headerKey | TEXT | header key | 
| $3 | IN | headerValue | TEXT | header value | 
| $4 | IN | override | BOOLEAN | if TRUE will override the existing value (optional, default TRUE) | 

## **Notes :** 
header key is not case sensitive
## **Example :** 
```
CURL_httpHeadersCollValueSet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 04/01/2022, 18:39:05 - 3.00.00
