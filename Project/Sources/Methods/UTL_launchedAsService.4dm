//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
C_BOOLEAN:C305($0; $vb_launchedAsService)

$vb_launchedAsService:=False:C215

C_OBJECT:C1216($vo_appInfos)
$vo_appInfos:=Get application info:C1599

// Created: 4D v17 R3
// Modified: 4D v18

// {
//     "launchedAsService": false,
//     "volumeShadowCopyStatus": "notAvailable",
//     "cpuUsage": 9.9,
//     "uptime": 304,
//     "networkInputThroughput": 1386,
//     "networkOutputThroughput": 573,
//     "headless": false,
//     "pid": 42989
// }

$vb_launchedAsService:=$vo_appInfos.launchedAsService

If (False:C215)
	//%T-
	//SET TEXT TO PASTEBOARD(JSON Stringify($vo_appInfos;*))
	//%T+
End if 

$0:=$vb_launchedAsService
