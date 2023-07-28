//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_TEXT:C284($0; $vt_dirPath)

// "Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:"
// /Library/Application Support/4D/com.ac-consulting/curllib-component/

C_TEXT:C284($vt_filenameNoExt; $vt_prefDirName)

var $structureFile : 4D:C1709.File
$structureFile:=File:C1566(Structure file:C489; fk platform path:K87:2)  // get component file
$vt_filenameNoExt:=$structureFile.name  // name without extension
// "curllib_component"

$vt_prefDirName:=Replace string:C233($vt_filenameNoExt; "_"; "-"; *)

C_TEXT:C284($vt_prefsAllUsers)
$vt_prefsAllUsers:=System folder:C487(User preferences_all:K41:3)
// C:\ProgramData\4D\com.ac-consulting\curllib-component\cacert.pem
// https://redmine.ac-consulting.fr/issues/4483
// TODO : bug à corriger...

C_BOOLEAN:C305($vb_ok)
$vb_ok:=False:C215

// if we cannot write to dir, we will get an error message
C_TEXT:C284($vt_errorHandler)
$vt_errorHandler:=Method called on error:C704
ON ERR CALL:C155("ERR_onErrCall")

var $folderPrefs : 4D:C1709.Folder
$folderPrefs:=Folder:C1567($vt_prefsAllUsers; fk platform path:K87:2).folder("4D").folder("com.ac-consulting").folder($vt_prefDirName)
// "/Library/Application Support/4D/com.ac-consulting/curllib-component"
If ($folderPrefs.exists)
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "dir : \""+$folderPrefs.path+"\" exists, testing if we can write into it...")
	
	// https://redmine.ac-consulting.fr/issues/3911
	// $ cd /Library/Application\ Support/4D
	// 
	// $ ls -al
	// total 328
	// drwxrwxr-x  24 root  wheel   816  9 fév 18:44 .
	// drwxr-xr-x  51 root  admin  1734 25 oct 12:42 ..
	// 
	// $ mkdir com.ac-consulting.fr
	// mkdir: com.ac-consulting.fr: Permission denied
	// 
	// $ sudo chmod a+w .
	// 
	// $ mkdir com.ac-consulting.fr
	// $ ls -al
	// total 328
	// drwxrwxrwx  25 root  wheel   850  9 fév 18:51 .
	// drwxr-xr-x  51 root  admin  1734 25 oct 12:42 ..
	// .. 
	// drwxr-xr-x   2 nri   wheel    68  9 fév 18:51 com.ac-consulting.fr
	
	// test if we can read/write into it
	var $testFile : 4D:C1709.File
	$testFile:=$folderPrefs.file(Generate UUID:C1066+".tmp")
	If ($testFile.create())
		$testFile.delete()
		$vb_ok:=True:C214
	Else 
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "failed creating file : \""+$testFile.path+"\". [KO]")
	End if 
	
Else 
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "dir : \""+$folderPrefs.path+"\" does not exist, going to create it...")
	$vb_ok:=$folderPrefs.create()
	If (Not:C34($vb_ok))
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "failed creating dir : \""+$folderPrefs.path+"\". [KO]")
	End if 
End if 

If (Not:C34($vb_ok))
	C_TEXT:C284($vt_prefsUser)
	$vt_prefsUser:=System folder:C487(User preferences_user:K41:4)
	
	var $folderPrefs : 4D:C1709.Folder
	$folderPrefs:=Folder:C1567($vt_prefsUser; fk platform path:K87:2).folder("4D").folder("com.ac-consulting").folder($vt_prefDirName)
	// "/Users/ble/Library/Application Support/4D/com.ac-consulting/curllib-component"
	
	If ($folderPrefs.exists)
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "dir : \""+$folderPrefs.path+"\" exists.")
	Else 
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "dir : \""+$folderPrefs.path+"\" does not exist, going to create it...")
		$vb_ok:=$folderPrefs.create()
		If (Not:C34($vb_ok))
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "failed creating dir : \""+$folderPrefs.path+"\". [KO]")
		End if 
	End if 
	
End if 

ON ERR CALL:C155($vt_errorHandler)

$vt_dirPath:=$folderPrefs.platformPath
// "Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:"

ASSERT:C1129(Test path name:C476($vt_dirPath)=Is a folder:K24:2; "dir \""+$vt_dirPath+"\" not found")

$0:=$vt_dirPath
