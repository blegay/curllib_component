//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_dateStringToEpoch
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[0-OUT-ok-BOOLEAN] : TRUE if ok, FALSE otherwise
  //@parameter[1-IN-dateString-TEXT] : date string
  //@parameter[2-OUT-epochLongPtr-POINTER] : epoch as a longint (modified)
  //@notes : 
  // 
  // Sun, 06 Nov 1994 08:49:37 GMT
  // Sunday, 06-Nov-94 08:49:37 GMT
  // Sun Nov  6 08:49:37 1994
  // 06 Nov 1994 08:49:37 GMT
  // 06-Nov-94 08:49:37 GMT
  // Nov  6 08:49:37 1994
  // 06 Nov 1994 08:49:37
  // 06-Nov-94 08:49:37
  // 1994 Nov 6 08:49:37
  // GMT 08:49:37 06-Nov-94 Sunday
  // 94 6 Nov 08:49:37
  // 1994 Nov 6
  // 06-Nov-94
  // Sun Nov 6 94
  // 1994.Nov.6
  // Sun/Nov/6/94/GMT
  // Sun, 06 Nov 1994 08:49:37 CET
  // 06 Nov 1994 08:49:37 EST
  // Sun, 12 Sep 2004 15:05:58 -0700
  // Sat, 11 Sep 2004 21:32:11 +0200
  // 20040912 15:05:58 -0700
  // 20040911 +0200
  //
  //@example : CURL_dateStringToEpoch
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 16:02:03 - 1.00.08
  //@xdoc-end
  //================================================================================

C_BOOLEAN:C305($0;$vb_ok)
C_TEXT:C284($1;$vt_dateString)
C_POINTER:C301($2;$vp_epochLongPtr)

ASSERT:C1129(Count parameters:C259>1;"requires 2 parameters")
ASSERT:C1129(Type:C295($2->)=Is longint:K8:6;"$2 should be a longint pointer")

$vt_dateString:=$1
$vp_epochLongPtr:=$2

  //<Modif> Bruno LEGAY (BLE) (25/05/2020)

  // https://github.com/miyako/4d-plugin-curl-v2 (new)
C_LONGINT:C283($vl_success;$vl_epoch)
C_TEXT:C284($vt_epochString)
$vl_epoch:=cURL_GetDate ($vt_dateString;$vt_epochString)
$vb_ok:=True:C214

  // https://github.com/miyako/4d-plugin-curl (old)

  //$vb_ok:=False
  //$vl_success:=cURL Get date($vt_dateString;$vl_epoch)
  //$vb_ok:=($vl_success=1)

  //<Modif>

$vp_epochLongPtr->:=$vl_epoch

$0:=$vb_ok
