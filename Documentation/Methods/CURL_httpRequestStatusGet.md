# **Method :** CURL_httpRequestStatusGet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This function returns the http status from an http object
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | status | LONGINT | http status (e.g. 200) | 
| $1 | IN | httpObj | OBJET | curl http object (not modified) | 

## **Notes :** 

## **Example :** 
```

      
       If (CURL_httpRequestStatusGet ($vo_httpObj)=200)
      
       If ($vo_httpObj.status=200)
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:31:35 - v1.00.00
