//%attributes = {"shared":false,"invisible":true}

  //================================================================================
  //@xdoc-start : en
  //@name : UTL__throughputCalc
  //@scope : private
  //@deprecated : no
  //@description : This function returns throughput string to display in progress window
  //@parameter[0-OUT-thoughput-TEXT] : thoughput
  //@parameter[1-IN-bufferSize-LONGINT] : buffer size in bytes
  //@parameter[2-IN-thoughputMs-LONGINT] : duration of last buffer send
  //@parameter[3-IN-sizeLeft-REAL] : number of bytes left to send
  //@notes :
  //@example : UTL__throughputCalc 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2017
  //@history : CREATION : Bruno LEGAY (BLE) - 05/04/2017, 09:45:01 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_thoughput)
C_LONGINT:C283($1;$vl_bufferSize)
C_LONGINT:C283($2;$vl_throughputMs)
C_REAL:C285($3;$vr_sizeLeft)

$vl_bufferSize:=$1
$vl_throughputMs:=$2
$vr_sizeLeft:=$3

C_LONGINT:C283($vl_timeleftSecs)
$vl_timeleftSecs:=UTL_timeleftSecs ($vl_bufferSize;$vl_throughputMs;$vr_sizeLeft)

$vt_thoughput:=", "+UTL_throughput ($vl_bufferSize;$vl_throughputMs;False:C215;True:C214)+", "+UTL_timeleftString ($vl_timeleftSecs)

$0:=$vt_thoughput