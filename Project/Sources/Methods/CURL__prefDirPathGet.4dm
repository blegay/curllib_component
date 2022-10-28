//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
C_TEXT:C284($0; $vt_dirPath)

// "Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:"

C_TEXT:C284($vt_structPath; $vt_filename; $vt_filenameNoExt; $vt_prefDirName)
$vt_structPath:=Structure file:C489  // get component path
$vt_filename:=FS_pathToFileName($vt_structPath)  // get component name
$vt_filenameNoExt:=FS_filenameNoExtension($vt_filename)  // remove extension
$vt_prefDirName:=Replace string:C233($vt_filenameNoExt; "_"; "-"; *)


$vt_dirPath:=System folder:C487(User preferences_all:K41:3)
// "Macintosh HD:Library:Application Support:"

//FIXER TEXTE DANS CONTENEUR($vt_dirPath)
//MONTRER SUR DISQUE($vt_dirPath)
//ALERTE($vt_dirPath)

$vt_dirPath:=$vt_dirPath+"4D"+Folder separator:K24:12
//<Modif> Bruno LEGAY (BLE) (09/02/2019)
//  Si (Tester chemin acces($vt_dirPath)#Est un dossier)
//  CREER DOSSIER($vt_dirPath)
//  Fin de si 
//<Modif>

//<Modif> Bruno LEGAY (BLE) (30/11/2020)
If (Test path name:C476($vt_dirPath)#Is a folder:K24:2)
	CURL__moduleDebugDateTimeLine(2; Current method name:C684; "dir : \""+$vt_dirPath+"\" does not exist.")
	
	$vt_dirPath:=System folder:C487(User preferences_user:K41:4)
	$vt_dirPath:=$vt_dirPath+"4D"+Folder separator:K24:12
End if 
//<Modif>

$vt_dirPath:=$vt_dirPath+"com.ac-consulting"+Folder separator:K24:12
//<Modif> Bruno LEGAY (BLE) (09/02/2019)
//  Si (Tester chemin acces($vt_dirPath)#Est un dossier)
//  CREER DOSSIER($vt_dirPath)
//  Fin de si 
//<Modif>

//<Modif> Bruno LEGAY (BLE) (12/12/2017)
$vt_dirPath:=$vt_dirPath+$vt_prefDirName+Folder separator:K24:12
//$vt_dirPath:=$vt_dirPath+"curllib-component"+Séparateur dossier
//<Modif>

//<Modif> Bruno LEGAY (BLE) (09/02/2019)
If (Test path name:C476($vt_dirPath)#Is a folder:K24:2)
	CREATE FOLDER:C475($vt_dirPath; *)
	
	C_BOOLEAN:C305($vb_dirCreated)
	$vb_dirCreated:=(ok=1)
	ASSERT:C1129($vb_dirCreated; "error creating \""+$vt_dirPath+"\"")
	CURL__moduleDebugDateTimeLine(Choose:C955($vb_dirCreated; 4; 2); Current method name:C684; "curllib pref dir \""+$vt_dirPath+"\" creation "+Choose:C955($vb_dirCreated; "success. [OK]"; "failure. [KO]"))
Else 
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "curllib pref dir : \""+$vt_dirPath+"\" exists. [OK]")
End if 
//Si (Tester chemin acces($vt_dirPath)#Est un dossier)
//CREER DOSSIER($vt_dirPath)
//Fin de si 
//<Modif>

If (False:C215)
	//SHOW ON DISK($vt_dirPath)
End if 

ASSERT:C1129(Test path name:C476($vt_dirPath)=Is a folder:K24:2; "dir \""+$vt_dirPath+"\" not found")

$0:=$vt_dirPath

//"Macintosh HD:Library:Application Support:4D:com.ac-consulting:curllib-component:"

//FIXER TEXTE DANS CONTENEUR($vt_dirPath)
//MONTRER SUR DISQUE($vt_dirPath)


//$vt_dirPath:=Dossier système(Préférences utilisateur)
//  // "Macintosh HD:Users:ble:Library:Application Support:"

//FIXER TEXTE DANS CONTENEUR($vt_dirPath)

//ALERTE($vt_dirPath)
