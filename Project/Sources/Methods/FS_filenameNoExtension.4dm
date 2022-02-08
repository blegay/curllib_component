//%attributes = {"invisible":true,"shared":false}

  //================================================================================
  //@xdoc-start : en
  //@name : FS_filenameNoExtension
  //@scope : public
  //@deprecated : no
  //@description : This function removes the extension from a filename 
  //@parameter[0-OUT-filenameWithoutExtension-TEXT] : the filename without the extension
  //@parameter[1-IN-filename-TEXT] : filename
  //@notes :
  //@example : FS_filenameNoExtension 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 06/05/2009, 10:21:40 - v1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_filenameWithoutExt)  //filename without the extension
C_TEXT:C284($1;$vt_filename)  //filename

$vt_filenameWithoutExt:=""
If (Count parameters:C259>0)
	$vt_filename:=$1
	
	$vt_filenameWithoutExt:=$vt_filename
	
	C_LONGINT:C283($vl_sepExtensionAscii)
	$vl_sepExtensionAscii:=Character code:C91(".")
	
	  // stop before first char (".invisible")
	C_LONGINT:C283($i)
	For ($i;Length:C16($vt_filenameWithoutExt);2;-1)
		If (Character code:C91($vt_filenameWithoutExt[[$i]])=$vl_sepExtensionAscii)
			$vt_filenameWithoutExt:=Substring:C12($vt_filenameWithoutExt;1;$i-1)
			$i:=0
		End if 
	End for 
	
End if 
$0:=$vt_filenameWithoutExt
