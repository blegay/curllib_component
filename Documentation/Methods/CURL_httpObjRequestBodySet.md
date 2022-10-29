﻿# **Method :** CURL_httpObjRequestBodySet
## **Scope :** public
## **Treadsafe :** capable ✅ 
## **Description :** 
This method sets the body for the request of an http object
## **Parameters :** 
| Parameter | Direction | Name | Type | Ddescription | 
|:----:|:----:|:----|:----|:----| 
| $1 | IN | httpObj | OBJECT | http object (modified) | 
| $2 | IN | bodyPtr | POINTER | request body blob pointer (not modified) | 

## **Notes :** 

## **Example :** 
```
CURL_httpObjRequestBodySet
```
## **Version :** 
1.00.00
## **Author :** 
Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
## **History :** 
 CREATION : Bruno LEGAY (BLE) - 18/11/2019, 21:06:48 - v1.00.00