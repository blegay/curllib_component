//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

//================================================================================
//@xdoc-start : en
//@name : ENV_plateformeStr
//@scope : public
//@deprecated : no
//@description : This function returns the plateform string (i.e. "MacOS‚Ñ¢ version 10.6.8 (Intel)")
//@parameter[0-OUT-plateformeStr-TEXT] : plateform information string
//@parameter[1-IN-detail-BOOLEAN] : if TRUE output with details (optional, default FALSE)
//@notes :
//@example : ENV_plateformeStr
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
//@history : CREATION : Bruno LEGAY (BLE) - 29/12/2011, 17:16:21 - v1.00.00
//@xdoc-end
//================================================================================

C_TEXT:C284($0; $vt_platformOS)  // type d'OS, sa version et le type de processeur
C_BOOLEAN:C305($1; $vb_detail)

If (Count parameters:C259=0)
	$vb_detail:=False:C215
Else 
	$vb_detail:=$1
End if 

If (True:C214)
	C_OBJECT:C1216($vo_systemInfos)
	$vo_systemInfos:=Get system info:C1571
	
	$vt_platformOS:=$vo_systemInfos.osVersion
	// "macOS 10.12.6 (16G29)"
	
	If ($vb_detail)
		$vt_platformOS:=$vt_platformOS+" ("+$vo_systemInfos.osLanguage+")"
		// "macOS 10.12.6 (16G29) (fr)"
	End if 
	
	If (False:C215)
		//%T-
		//SET TEXT TO PASTEBOARD(JSON Stringify($vo_systemInfos;*))
		//%T+
	End if 
	
	If (False:C215)  // mac os sample
		//   {
		//       "machineName": "MacBook Pro Bruno",
		//       "accountName": "ble",
		//       "userName": "Bruno LEGAY",
		//       "osVersion": "macOS 10.12.6 (16G29)",
		//       "uptime": 169594,
		//       "physicalMemory": 16777216,
		//       "osLanguage": "fr",
		//       "processor": "Intel(R) Core(TM) i7-4960HQ CPU @ 2.60GHz",
		//       "cores": 4,
		//       "cpuThreads": 8,
		//       "networkInterfaces": [
		//           {
		//               "type": "wifi",
		//               "name": "Wi-Fi",
		//               "ipAddresses": [
		//                   {
		//                       "ip": "fe80::c91:2003:48c0:ec5f",
		//                       "type": "ipv6"
		//                   },
		//                   {
		//                       "ip": "192.168.235.146",
		//                       "type": "ipv4"
		//                   },
		//                   {
		//                       "ip": "2a01:e34:ef76:1080:144a:a7e6:ecda:1249",
		//                       "type": "ipv6"
		//                   }
		//               ]
		//           }
		//       ],
		//       "model": "MacBookPro11,3",
		//       "volumes": [
		//           {
		//               "mountPoint": "/",
		//               "capacity": 934494080,
		//               "available": 2822760,
		//               "filesystem": "hfs",
		//               "name": "Macintosh HD",
		//               "disk": [
		//                   {
		//                       "size": 934856664,
		//                       "description": "APPLE SSD SM1024F",
		//                       "interface": "pci",
		//                       "identifier": "A28E9177-8CAA-4138-B813-2DFB31630380"
		//                   }
		//               ]
		//           },
		//           {
		//               "mountPoint": "/Volumes/spare",
		//               "capacity": 40642948,
		//               "available": 5819608,
		//               "filesystem": "hfs",
		//               "name": "spare",
		//               "disk": {
		//                   "interface": "pci",
		//                   "description": "APPLE SSD SM1024F",
		//                   "size": 40642948,
		//                   "identifier": "932AFA7B-ED2E-4E1A-9844-83E1DE00FAC7"
		//               }
		//           },
		//           {
		//               "mountPoint": "/Volumes/MobileBackups",
		//               "capacity": 934494080,
		//               "available": 0,
		//               "filesystem": "mtmfs",
		//               "name": "",
		//               "disk": {
		//                   "interface": "network",
		//                   "description": "",
		//                   "identifier": "",
		//                   "size": 934494080
		//               }
		//           }
		//       ]
		//   }
	End if 
	
End if 

$0:=$vt_platformOS

