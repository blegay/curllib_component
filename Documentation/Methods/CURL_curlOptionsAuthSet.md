# **Method :** CURL_curlOptionsAuthSet
## **Scope :** private
## **Treadsafe :** capable ✅ 
## **Description :** 
This method will set the auth parameters in a curl options object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $1 | INOUT | curlOptions | OBJECT | curl options object | 
| $2 | IN | login | TEXT | login | 
| $3 | IN | password | TEXT | password | 
| $4 | IN | auth | TEXT | auth method | 

## **Notes :** 

       ("NONE", "BASIC", DIGEST", "NEGOTIATE", "NTLM", "DIGEST_IE", "NTLM_WB", "BEARER", "ONLY")
## **Example :** 
```
CURL_curlOptionsAuthSet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2020
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 27/05/2020, 23:02:03 - 2.00.00
