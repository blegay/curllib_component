# **Method :** CURL_curlOptionsProxySet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method will set the proxy configuration parameters in the "option" object
## **Parameters :** 
| Parameter | Direction | Name | Type | Description | 
|:----:|:----:|:----|:----|:----| 
| $1 | INOUT | optionPtr | POINTER | option object pointer (modified) | 
| $2 | IN | proxyServer | TEXT | proxy server (e.g. "myProxy.local" or "192.168.1.250") | 
| $3 | IN | proxyPort | LONGINT | proxy port (e.g. 8080) | 
| $4 | IN | proxyLogin | TEXT | login for proxy server (optional) | 
| $5 | IN | proxyPassword | TEXT | password for proxy server (optional) | 

## **Notes :** 

## **Example :** 
```
CURL_curlOptionsProxySet
```
## **Version :** 
1.00.00
## **Author :** 

## **History :** 
 
        CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:55:33 - 1.00.00
