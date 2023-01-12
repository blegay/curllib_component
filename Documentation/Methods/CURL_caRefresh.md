# **Method :** CURL_caRefresh
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method will download a ca certificates in pem format and store it in as "cache" in the prefence directory
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $0 | OUT | ok | BOOLEAN | TRUE if ok, FALSE otherwise | 
| $1 | IN | options | OBJECT | curl options (for proxy configuration for instance) (optional) | 
| $2 | IN | url | TEXT | pem file url (optional, default : "https://curl.se/ca/cacert.pem") | 

## **Notes :** 
if this command is not called, the ca certificates pem file in the component Resources dir will be used.
       There is a risk that the certificates in this file will expire
       So it a good idea to call this method once on the application startup
## **Example :** 
```
CURL_caRefresh
      
       CURL_caRefresh 
      
         or
      
       C_OBJET($vo_options)
       CURL_curlOptionsProxySet (->$vo_options;"127.0.0.1";80;"steve";"1234")
       CURL_caRefresh ($vo_options)
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 28/09/2017, 18:02:12 - v1.00.00
