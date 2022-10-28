//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
C_BOOLEAN:C305($0; $vb_fileUpToDate)
C_TEXT:C284($1; $vt_dateTimeIso8601)
C_LONGINT:C283($2; $vl_fileSize)
C_POINTER:C301($3; $vp_filePathPtr)

//$vp_filepathPtr:=$1
ASSERT:C1129(Count parameters:C259>2; "requires 3 parameters")
ASSERT:C1129(Type:C295($3->)=Is text:K8:3; "$3 should be a text pointer")

$vb_fileUpToDate:=False:C215
If (Count parameters:C259>2)
	$vt_dateTimeIso8601:=$1
	$vl_fileSize:=$2
	$vp_filePathPtr:=$3
	
	C_TEXT:C284($vt_caFilepathValid)
	$vt_caFilepathValid:=""
	
	C_TEXT:C284($vt_prefPath)
	$vt_prefPath:=CURL__prefDirPathGet+"curllibPreferences.xml"
	If (Test path name:C476($vt_prefPath)=Is a document:K24:1)
		//$vb_fileUpToDate:=""
		
		C_TEXT:C284($vt_schema)
		$vt_schema:=Get 4D folder:C485(Current resources folder:K5:16)+"xml"+Folder separator:K24:12+"curllibPreferences.xsd"
		ASSERT:C1129(Test path name:C476($vt_schema)=Is a document:K24:1; "file \""+$vt_schema+"\" not found")
		
		C_BOOLEAN:C305($vb_validate)
		$vb_validate:=True:C214  //(Sous chaîne($vt_schema;1;2)#"\\\\")  // if xsd is a unc path "\\nas\share\apps\myApp\Resources\xml\curllibPreferences.xsd" validation will fail
		// http://forums.4d.fr/Post/FR/17315845/1/17315846#17315846
		// ACI0094378
		
		C_TEXT:C284($vt_domRef)
		$vt_domRef:=xml_domSourceParse($vt_prefPath; $vb_validate; $vt_schema)
		If (Length:C16($vt_domRef)>0)
			//$vt_domRef:=DOM Analyser source XML($vt_prefPath;$vb_validate;$vt_schema)
			//Si (ok=1)
			
			C_TEXT:C284($vt_xpath)
			$vt_xpath:="/curllibPreferences/caFile[1]"
			
			C_TEXT:C284($vt_caFileElementdomRef)
			$vt_caFileElementdomRef:=DOM Find XML element:C864($vt_domRef; $vt_xpath)
			
			C_LONGINT:C283($vl_fileSizeXml)
			C_TEXT:C284($vt_sha1Xml; $vt_dateTimeIso8601Xml)
			DOM GET XML ATTRIBUTE BY NAME:C728($vt_caFileElementdomRef; "size"; $vl_fileSizeXml)
			DOM GET XML ATTRIBUTE BY NAME:C728($vt_caFileElementdomRef; "sha1"; $vt_sha1Xml)
			DOM GET XML ATTRIBUTE BY NAME:C728($vt_caFileElementdomRef; "date"; $vt_dateTimeIso8601Xml)
			
			If ($vt_dateTimeIso8601=$vt_dateTimeIso8601Xml)
				If (($vl_fileSize=$vl_fileSizeXml) & ($vl_fileSize>0))
					
					C_TEXT:C284($vt_filepath)
					DOM GET XML ELEMENT VALUE:C731($vt_caFileElementdomRef; $vt_filepath)
					If (Test path name:C476($vt_filepath)=Is a document:K24:1)
						
						If (Get document size:C479($vt_filepath)=$vl_fileSize)
							C_BLOB:C604($vx_pem)
							SET BLOB SIZE:C606($vx_pem; 0)
							DOCUMENT TO BLOB:C525($vt_filepath; $vx_pem)
							If (BLOB size:C605($vx_pem)=$vl_fileSize)
								
								If (Generate digest:C1147($vx_pem; SHA1 digest:K66:2)=$vt_sha1Xml)
									$vt_caFilepathValid:=$vt_filepath
									
									CURL__moduleDebugDateTimeLine(4; Current method name:C684; "pref file : \""+$vt_prefPath+"\""+\
										", pem file : \""+$vt_filepath+"\""+\
										", size : "+String:C10($vl_fileSizeXml)+\
										", sha1 : "+$vt_sha1Xml+\
										", date : "+$vt_dateTimeIso8601Xml+\
										", file is up to date. Using file \""+$vt_caFilepathValid+"\"")
									
									$vb_fileUpToDate:=True:C214
								End if 
								
							End if 
							SET BLOB SIZE:C606($vx_pem; 0)
							
						End if 
						
					End if 
					
				End if 
			End if 
			
			DOM CLOSE XML:C722($vt_domRef)
		End if 
		
	End if 
	
	$vp_filePathPtr->:=$vt_caFilepathValid
	
End if 
$0:=$vb_fileUpToDate