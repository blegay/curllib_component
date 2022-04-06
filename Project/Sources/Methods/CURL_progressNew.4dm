//%attributes = {"invisible":false,"preemptive":"incapable","shared":true}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_progressNew
  //@scope : private 
  //@deprecated : no
  //@description : This method is a wapper on "Progress New"
  //@parameter[0-OUT-progressId-LONGINT] : progress identifier
  //@parameter[1-IN-title-TEXT] : title (optional)
  //@parameter[2-IN-progressAbortable-BOOLEAN] : progressAbortable (optional)
  //@notes : 
  //@example : CURL_progressNew
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 06/04/2022, 14:19:06 - 3.00.03
  //@xdoc-end
  //================================================================================

C_LONGINT:C283($0;$vl_progressId)
C_TEXT:C284($1;$vt_title)
C_BOOLEAN:C305($2;$vb_progressAbortable)

Case of 
	: (Count parameters:C259>1)
		$vt_title:=$1
		$vb_progressAbortable:=$2
		
	: (Count parameters:C259>0)
		$vt_title:=$1
		$vb_progressAbortable:=False:C215
		
	Else 
		$vt_title:=""
		$vb_progressAbortable:=False:C215
End case 

$vl_progressId:=Progress New 

Progress SET PROGRESS ($vl_progressId;-1)

If (Length:C16($vt_title)>0)
	Progress SET TITLE ($vl_progressId;$vt_title)
End if 

Progress SET BUTTON ENABLED ($vl_progressId;$vb_progressAbortable)

$0:=$vl_progressId


