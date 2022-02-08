//%attributes = {"invisible":true,"preemptive":"capable","shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : UTL_throughput
  //@scope : private
  //@deprecated : no
  //@description : This function returns throughput information for debug purposes 
  //@parameter[0-OUT-throughputText-TEXT] : throughput infos
  //@parameter[1-IN-size-REAL] : size
  //@parameter[2-IN-durationMs-LONGINT] : durationin milliseconds
  //@notes :
  //@example : UTL_throughput(160000;1023) => "152,73 Kbyte(s) per second (160 000 bytes in 1,023s)"
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2018
  //@history : CREATION : Bruno LEGAY (BLE) - 08/01/2014, 14:39:48 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_throughpuInfos)
C_REAL:C285($1;$vr_size)  //size in bytes
C_LONGINT:C283($2;$vl_durationMs)
C_BOOLEAN:C305($3;$vb_detail)
C_BOOLEAN:C305($4;$vb_shortUnits)

$vt_throughpuInfos:=""

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	$vr_size:=$1
	$vl_durationMs:=$2
	Case of 
		: ($vl_nbParam=2)
			$vb_detail:=True:C214
			$vb_shortUnits:=True:C214
			
		: ($vl_nbParam=3)
			$vb_detail:=$3
			$vb_shortUnits:=True:C214
			
		Else 
			  //: ($vl_nbParam=4)
			$vb_detail:=$3
			$vb_shortUnits:=$4
	End case 
	
	  //160 bytes in 1023 ms
	If (($vr_size>0) & ($vl_durationMs>0))
		
		C_REAL:C285($vr_throughput)
		$vr_throughput:=$vr_size/($vl_durationMs/1000)  //troughput in bytes per seconds
		
		
		  //#define ONE_KILOBYTE  CURL_OFF_T_C(1024)
		  //#define ONE_MEGABYTE (CURL_OFF_T_C(1024)* ONE_KILOBYTE)
		  //#define ONE_GIGABYTE (CURL_OFF_T_C(1024)* ONE_MEGABYTE)
		  //#define ONE_TERABYTE (CURL_OFF_T_C(1024)* ONE_GIGABYTE)
		  //#define ONE_PETABYTE (CURL_OFF_T_C(1024) * ONE_TERABYTE)
		
		
		Case of 
			: ($vr_throughput>=0x00100000)  //1048576
				$vt_throughpuInfos:=String:C10($vr_throughput/0x00100000;"# ##0.00")+" "+Choose:C955($vb_shortUnits;"MB/s";"Mbyte(s) per second")
				
			: ($vr_throughput>=0x0400)  //1024)
				$vt_throughpuInfos:=String:C10($vr_throughput/0x0400;"# ##0.00")+" "+Choose:C955($vb_shortUnits;"KB/s";"Kbyte(s) per second")
				
			: ($vr_throughput>1)
				$vt_throughpuInfos:=String:C10($vr_throughput;"# ##0")+" "+Choose:C955($vb_shortUnits;"B/s";"bytes per second")
				
			Else   //$vl_size = 0 or 1
				$vt_throughpuInfos:=String:C10($vr_throughput;"# ##0")+" "+Choose:C955($vb_shortUnits;"B/s";"byte per second")
		End case 
		
	Else 
		$vb_detail:=True:C214
	End if 
	
	If ($vb_detail)
		If (Length:C16($vt_throughpuInfos)>0)
			$vt_throughpuInfos:=$vt_throughpuInfos+" "
		End if 
		$vt_throughpuInfos:=$vt_throughpuInfos+"("+DBG__bytes ($vr_size)+", "+String:C10($vr_size;"# ### ### ##0")+" bytes in "+UTL_durationMsDebug ($vl_durationMs)+")"  //Chaine($vl_durationMs/1000;"# ### ### ##0.000")+"s)"
	End if 
	
End if 
$0:=$vt_throughpuInfos