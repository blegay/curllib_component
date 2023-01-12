# **Method :** CURL_dateStringToEpoch
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method/function returns
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | dateString | TEXT | date string | 
| $2 | OUT | epochLongPtr | POINTER | epoch as a longint (modified) | 

## **Notes :** 

       
       Sun, 06 Nov 1994 08:49:37 GMT
       Sunday, 06-Nov-94 08:49:37 GMT
       Sun Nov  6 08:49:37 1994
       06 Nov 1994 08:49:37 GMT
       06-Nov-94 08:49:37 GMT
       Nov  6 08:49:37 1994
       06 Nov 1994 08:49:37
       06-Nov-94 08:49:37
       1994 Nov 6 08:49:37
       GMT 08:49:37 06-Nov-94 Sunday
       94 6 Nov 08:49:37
       1994 Nov 6
       06-Nov-94
       Sun Nov 6 94
       1994.Nov.6
       Sun/Nov/6/94/GMT
       Sun, 06 Nov 1994 08:49:37 CET
       06 Nov 1994 08:49:37 EST
       Sun, 12 Sep 2004 15:05:58 -0700
       Sat, 11 Sep 2004 21:32:11 +0200
       20040912 15:05:58 -0700
       20040911 +0200
## **Example :** 
```
CURL_dateStringToEpoch
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 19/11/2019, 16:02:03 - 1.00.08
