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
	
Else 
	
	
	//C_LONGINT($vl_winMajVers;$vl_winMinVers)
	//C_TEXT($vt_macOSVers;$vt_macOSVersRev)
	
	//C_LONGINT($vl_platform;$vl_system;$vl_machine;$vl_langue)
	//PLATFORM PROPERTIES($vl_platform;$vl_system;$vl_machine;$vl_langue)
	//Case of 
	//: (Is macOS)  // ($vl_platform=Mac OS)
	//$vt_macOSVers:=String($vl_system;"&x")
	//  //"0x0922" ou "0x1035"
	
	//  // $vt_macOSVers:=Sous chaine($vt_macOSVers;Longueur($vt_macOSVers)-2)
	//  //$vt_platformOS:="MacOS‚Ñ¢ version "+$vt_macOSVers‚â§1‚â•+"."+$vt_macOSVers‚â§2‚â•
	//  // $vt_macOSVersRev:=$vt_macOSVers‚â§3‚â•
	
	//If (Length($vt_macOSVers)=6)
	//$vt_platformOS:=""
	
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//$vt_platformOS:=$vt_platformOS+"OS X version "
	//  //$vt_platformOS:=$vt_platformOS+"MacOS‚Ñ¢ version "
	//  //<Modif>
	
	//If (($vt_macOSVers[[3]])#"0")
	//$vt_platformOS:=$vt_platformOS+$vt_macOSVers[[3]]
	//End if 
	
	//  //<Modif> Bruno LEGAY (BLE) (19/11/2018)
	//  // stop returning "10.A.5" but "10.10.5" instead
	//$vt_platformOS:=$vt_platformOS+$vt_macOSVers[[4]]+"."+String(HEX_hexCharToInt ($vt_macOSVers[[5]]))
	//  //$vt_platformOS:=$vt_platformOS+$vt_macOSVers[[4]]+"."+$vt_macOSVers[[5]]
	//  //<Modif>
	
	//If ($vt_macOSVers[[6]]#"0")  //Avec une révision
	//$vt_platformOS:=$vt_platformOS+"."+$vt_macOSVers[[6]]
	//End if 
	
	//If ($vb_detail)
	//$vt_platformOS:=$vt_platformOS+", plateform : "+String($vl_system;"&x")
	//End if 
	
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//  ////HTTP__moduleDebugDateTimeLine (4;Nom méthode courante;"mac \""+$vt_platformOS+"\" (macOSVers : "+$vt_macOSVers+")")
	//  //<Modif>
	
	//Else 
	//$vt_platformOS:=$vt_platformOS+"OS X version ? ("+$vt_macOSVers+")"
	
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//  ////HTTP__moduleDebugDateTimeLine (2;Nom méhode courante;"unkown os x version (macOSVers : "+$vt_macOSVers+")")
	//  //<Modif>
	
	//End if 
	
	//: (Is Windows)  // ($vl_platform=Windows)
	
	//$vt_platformOS:=""
	
	//$vl_winMajVers:=$vl_system & 0x00FF
	//$vl_winMinVers:=($vl_system & 0xFF00) >> 8
	
	//C_TEXT($vt_windowsName)
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//$vt_windowsName:="Windows"
	//  //$vt_windowsName:="Windows‚Ñ¢ "
	//  //<Modif>
	
	//C_BOOLEAN($vb_unknown)
	//$vb_unknown:=False
	
	//  //<Modif> Bruno LEGAY (BLE) (10/11/2013)
	//If ($vl_system ?? 31)  //On teste le bit 31 pour savoir si on est sur NT, 2000 ou XP
	//  //Si ($vl_system ?? 32)  //On teste le bit 32 pour savoir si on est sur NT, 2000 ou XP
	//  //<Modif>
	//  //$vl_system is negative => Windows 3.1, 95, 98
	
	//If ($vl_winMajVers>=4)
	
	//If ($vl_winMinVers=0)
	//$vt_platformOS:=$vt_windowsName+" 95"
	//Else 
	//$vt_platformOS:=$vt_windowsName+" 98"
	//End if 
	
	//Else   //On est (encore) en Windows 3.1
	//$vt_platformOS:=$vt_windowsName+" 3.1 (with Win32s)"
	//End if 
	
	//Else   //On est en Windows NT, 2000, XP ou supérieur
	
	//Case of 
	//: ($vl_winMajVers=3)  // NT 3.x
	//  // this is for older versions of 4D (very theorectica)
	
	//Case of 
	//: ($vl_winMinVers=0)
	//$vt_platformOS:=$vt_windowsName+" NT 3.1"
	
	//: ($vl_winMinVers=5)
	//$vt_platformOS:=$vt_windowsName+" NT 3.5"
	
	//: ($vl_winMinVers=51)
	//$vt_platformOS:=$vt_windowsName+" NT 3.51"
	
	//Else 
	//$vb_unknown:=True
	//End case 
	
	//: ($vl_winMajVers=4)  // NT 4.0
	//  // this is for older versions of 4D (very theorectical)
	//$vt_platformOS:=$vt_windowsName+" NT 4.0"
	
	//: ($vl_winMajVers=5)  // 2000, XP, 2003
	//Case of 
	//: ($vl_winMinVers=0)
	//$vt_platformOS:=$vt_windowsName+" 2000"
	
	//: ($vl_winMinVers=1)  // "Windows XP" or "Windows Fundamentals for Legacy PCs"
	//$vt_platformOS:=$vt_windowsName+" XP"
	
	//: ($vl_winMinVers=2)  // "Windows XP" (64-bit Edition Version 2003) or "Windows Server 2003" or "Windows XP" (Professional x64 Edition) or "Windows Server 2003 R2" or "Windows Home Server"
	//$vt_platformOS:=$vt_windowsName+" Server 2003"
	
	//  //: ($vl_winMinVers=3)
	//  //$vt_platformOS:=$vt_windowsName+" 2008"`a valider
	
	//Else 
	//$vb_unknown:=True
	//End case 
	
	//: ($vl_winMajVers=6)  // Vista, 7 
	
	//Case of 
	//: ($vl_winMinVers=0)  //"windows Vista" or "Windows Server 2008" 
	//$vt_platformOS:=$vt_windowsName+" Vista"
	
	//: ($vl_winMinVers=1)  // "windows 8" or "Windows Server 2008 R2" or "Windows Home Server 2011"
	//$vt_platformOS:=$vt_windowsName+" 7"
	
	//: ($vl_winMinVers=2)  // "windows 8" or "Windows Server 2012"
	//$vt_platformOS:=$vt_windowsName+" 8"
	
	//: ($vl_winMinVers=3)  // "windows 8.1" or "Windows Server 2012 R2"
	//$vt_platformOS:=$vt_windowsName+" 8.1"
	
	//Else 
	//$vb_unknown:=True
	//End case 
	
	//: ($vl_winMajVers=10)
	
	//Case of 
	//: ($vl_winMinVers=0)
	//$vt_platformOS:=$vt_windowsName+" 10"
	//Else 
	//$vb_unknown:=True
	//End case 
	
	//Else 
	//$vb_unknown:=True
	//End case 
	
	//End if 
	//  //$vt_platformOS:=$vt_platformOS+" version "+Chaine($vl_winMajVers)+"."+Chaine($vl_winMinVers)
	
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//If ($vb_unknown)
	//$vt_platformOS:=$vt_windowsName+" ? ("+String($vl_winMajVers)+"."+String($vl_winMinVers)+")"
	//  //HTTP__moduleDebugDateTimeLine (2;Nom méhode courante;"unknow windows ("+Chaîne($vl_winMajVers)+"."+Chaîne($vl_winMinVers)+") version MajVers : "+Chaîne($vl_winMajVers)+", MinVers : "+Chaîne($vl_winMinVers))
	//Else 
	//  //HTTP__moduleDebugDateTimeLine (4;Nom méthode courante;"windows \""+$vt_platformOS+"\" (MajVers : "+Chaîne($vl_winMajVers)+", MinVers : "+Chaîne($vl_winMinVers)+")")
	//End if 
	//  //<Modif>
	
	//If ($vb_detail)
	//$vt_platformOS:=$vt_platformOS+" version "+String($vl_winMajVers)+"."+String($vl_winMinVers)
	//  //$vt_platformOS:=$vt_platformOS+", plateform : "+Chaine($vl_system;"&x")+", winMajVers : "+Chaine($vl_winMajVers)+", winMinVers : "+Chaine($vl_winMinVers)
	//End if 
	
	//Else 
	//$vt_platformOS:=""
	//End case 
	
	//  //<Modif> Bruno LEGAY (BLE) (20/02/2015)
	//If ($vb_detail)
	//If ($vl_langue#0)
	//$vt_platformOS:=$vt_platformOS+" ("+ENV__langageName ($vl_langue)+")"
	//End if 
	//End if 
	//  //<Modif>
End if 

$0:=$vt_platformOS

