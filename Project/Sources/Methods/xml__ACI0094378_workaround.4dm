//%attributes = {"invisible":true,"shared":false}
C_POINTER:C301($1;$vp_xsdPathTempPtr)
C_POINTER:C301($2;$vp_xsdPathPtr)

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>0)
	
	Case of 
		: ($vl_nbParam=1)
			$vp_xsdPathTempPtr:=$1
			ASSERT:C1129(Type:C295($vp_xsdPathTempPtr->)=Is text:K8:3)
			
		Else 
			  //: ($vl_nbParam=2)
			$vp_xsdPathTempPtr:=$1
			$vp_xsdPathPtr:=$2
			ASSERT:C1129(Type:C295($vp_xsdPathTempPtr->)=Is text:K8:3)
			ASSERT:C1129(Type:C295($vp_xsdPathPtr->)=Is text:K8:3)
	End case 
	
	
	Case of 
		: ($vl_nbParam=1)  // executed after (deleting temp file)
			
			If (Length:C16($vp_xsdPathTempPtr->)>0)
				
				DELETE DOCUMENT:C159($vp_xsdPathTempPtr->)
				ASSERT:C1129(ok=1)
				
			End if 
			
		Else   // executed before (copying xsd to a temp file)
			  //: ($vl_nbParam=2)
			
			ASSERT:C1129(Test path name:C476($vp_xsdPathPtr->)=Is a document:K24:1)
			
			  // note : si validate est mis à faux, il n'y a pas d'erreur : c'est un pb de validation et pas un pb de lecture du document xml
			If (Substring:C12($vp_xsdPathPtr->;1;2)="\\\\")
				
				  //CONFIRMER("Use work around ?")
				  //Si (ok=1)  
				If (True:C214)  // copy file path to local temp dir and use that file for validation
					$vp_xsdPathTempPtr->:=Temporary folder:C486+"ACI0094378-workaround-"+Generate UUID:C1066+".xsd"  // get a unique name in the temp dir
					COPY DOCUMENT:C541($vp_xsdPathPtr->;$vp_xsdPathTempPtr->)
					ASSERT:C1129(ok=1)
					$vp_xsdPathPtr->:=$vp_xsdPathTempPtr->
				End if 
				
			End if 
			
	End case 
	
End if 