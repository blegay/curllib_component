//%attributes = {"invisible":true,"shared":false}
C_BOOLEAN:C305($0;$vb_ok)
C_POINTER:C301($1;$vp_pemBlobPtr)
C_TEXT:C284($2;$vt_dateIso8601)
C_POINTER:C301($1;$vp_filePathPtr)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameters")
ASSERT:C1129(Type:C295($1->)=Is BLOB:K8:12;"$1 should be a blob pointer")
ASSERT:C1129(BLOB size:C605($1->)>0;"$1-> should not be an empty blob")
ASSERT:C1129(Type:C295($3->)=Is text:K8:3;"$3 should be a text pointer")

$vp_pemBlobPtr:=$1
$vt_dateIso8601:=$2
$vp_filePathPtr:=$3

C_TEXT:C284($vt_prefDir;$vt_prefPath;$vt_caPath)
$vt_prefDir:=CURL__prefDirPathGet 

$vt_caPath:=$vt_prefDir+"cacert.pem"
$vt_prefPath:=$vt_prefDir+"curllibPreferences.xml"

BLOB TO DOCUMENT:C526($vt_caPath;$vp_pemBlobPtr->)
$vb_ok:=(ok=1)

CURL__moduleDebugDateTimeLine (Choose:C955($vb_ok;4;2);Current method name:C684;"Certifcate Authorites (CA) certificates file : \""+$vt_caPath+"\" creation : "+Choose:C955($vb_ok;"ok";"error"))

ASSERT:C1129($vb_ok;"error writing pem file to file \""+$vt_caPath+"\"")
If ($vb_ok)
	
	  // <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
	  // <curllibPreferences 
	  //     xmlns="http://www.ac-consulting.fr/tech/namespace/curllibPreferences" 
	  //     version="1.0" 
	  //     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	  //     xsi:schemaLocation="http://www.ac-consulting.fr/tech/namespace/curllibPreferences curllibPreferences.xsd">
	  //   <!--created automatically by "CURL__caPrefSave" in "curllib_component" on 2019-02-09T12:31:32Z-->
	  //   <caFile 
	  //      date="2019-01-23T04:12:10Z" 
	  //      sha1="6fa389fde2f3d24c0756a7ff1cce8aef6aee7060" 
	  //      size="219596">Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:cacert.pem</caFile>
	  // </curllibPreferences>
	
	
	C_TEXT:C284($vt_domRef)
	$vt_domRef:=DOM Create XML Ref:C861("curllibPreferences";\
		"http://www.ac-consulting.fr/tech/namespace/curllibPreferences";\
		"xmlns:xsi";"http://www.w3.org/2001/XMLSchema-instance";\
		"xsi:schemaLocation";"http://www.ac-consulting.fr/tech/namespace/curllibPreferences curllibPreferences.xsd";\
		"version";"1.0")
	$vb_ok:=(ok=1)
	
	ASSERT:C1129($vb_ok;"Failed creating dom ref")
	If ($vb_ok)
		
		C_TEXT:C284($vt_commentNodeDomRef)
		$vt_commentNodeDomRef:=DOM Append XML child node:C1080($vt_domRef;XML comment:K45:8;"created automatically by \"CURL__caPrefSave\" in \"curllib_component\" on "+String:C10(Current date:C33;ISO date GMT:K1:10;Current time:C178))
		
		C_TEXT:C284($vt_caFileElementdomRef)
		$vt_caFileElementdomRef:=DOM Create XML element:C865($vt_domRef;"caFile";\
			"size";BLOB size:C605($vp_pemBlobPtr->);\
			"sha1";Generate digest:C1147($vp_pemBlobPtr->;SHA1 digest:K66:2);\
			"date";$vt_dateIso8601)
		DOM SET XML ELEMENT VALUE:C868($vt_caFileElementdomRef;$vt_caPath)
		
		DOM EXPORT TO FILE:C862($vt_domRef;$vt_prefPath)
		$vb_ok:=(ok=1)
		
		If (False:C215)
			SHOW ON DISK:C922($vt_prefPath)
		End if 
		
		DOM CLOSE XML:C722($vt_domRef)
		
		CURL__moduleDebugDateTimeLine (Choose:C955($vb_ok;4;2);Current method name:C684;"xml file : \""+$vt_prefPath+"\" creation : "+Choose:C955($vb_ok;"ok";"error"))
	Else 
		CURL__moduleDebugDateTimeLine (2;Current method name:C684;"Failed creating dom ref")
	End if 
	
End if 

$vp_filePathPtr->:=Choose:C955($vb_ok;$vt_caPath;"")
$0:=$vb_ok