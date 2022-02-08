//%attributes = {"invisible":true,"shared":false}
  //================================================================================
  //@xdoc-start : en
  //@name : UTL_fileCreationDateTimeSet
  //@scope : public
  //@deprecated : no
  //@description : This method sets creation date and time for a given document
  //@parameter[1-IN-filepath-TEXT] : file path
  //@parameter[2-IN-date-DATE] : creation date
  //@parameter[3-IN-time-TIME] : creation time
  //@notes : 
  //@example : UTL_fileCreationDateTimeSet
  //@see : 
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 29/09/2017, 14:28:48 - 1.00.00
  //@xdoc-end
  //================================================================================
  // 
  //  CREATION : Bruno LEGAY (BLE) - 

C_TEXT:C284($1;$vt_filepath)
C_DATE:C307($2;$vd_date)
C_TIME:C306($3;$vh_time)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129($2#!00-00-00!;"$2 : null date not allowed")

If (Count parameters:C259>2)
	$vt_filepath:=$1
	$vd_date:=$2
	$vh_time:=$3
	
	If ($vd_date#!00-00-00!)
		If (Test path name:C476($vt_filepath)=Is a document:K24:1)
			
			C_BOOLEAN:C305($vb_locked;$vb_invisible)
			C_DATE:C307($vd_createdDate;$vd_modifiedDate)
			C_TIME:C306($vh_createdTime;$vh_modifiedTime)
			GET DOCUMENT PROPERTIES:C477($vt_filepath;$vb_locked;$vb_invisible;$vd_createdDate;$vh_createdTime;$vd_modifiedDate;$vh_modifiedTime)
			$vd_createdDate:=$vd_date
			$vh_createdTime:=$vh_time
			  //$vd_modifiedDate:=$vd_date
			  //$vh_modifiedTime:=$vh_time
			SET DOCUMENT PROPERTIES:C478($vt_filepath;$vb_locked;$vb_invisible;$vd_createdDate;$vh_createdTime;$vd_modifiedDate;$vh_modifiedTime)
			
		End if 
	End if 
End if 