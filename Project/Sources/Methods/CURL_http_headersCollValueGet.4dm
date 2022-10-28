//%attributes = {"shared":true,"preemptive":"capable","invisible":false}

C_TEXT:C284($0; $vt_headerValue)
C_COLLECTION:C1488($1; $co_headersCollection)
C_TEXT:C284($2; $vt_headerKey)

ASSERT:C1129(Count parameters:C259>1; "requires 2 parameter")
//ASSERT(Type($1->)=Text array;"$1 should be a text array pointer")
ASSERT:C1129(Length:C16($2)>0; "$2 should not be empty")
ASSERT:C1129($1#Null:C1517; "$1 should be a collection")

$vt_headerValue:=""
//Si (Nombre de paramètres>1)
$co_headersCollection:=$1
$vt_headerKey:=$2

If ($co_headersCollection#Null:C1517)  //  indexOf fails on an Null collection
	
	If (Position:C15(":"; $vt_headerKey; *)=0)
		$vt_headerKey:=$vt_headerKey+":"
	End if 
	
	C_LONGINT:C283($vl_index)
	$vl_index:=$co_headersCollection.indexOf($vt_headerKey+"@")
	// "Content-Type:@" matches "content-type:"
	
	If ($vl_index>=0)
		C_TEXT:C284($vt_headerLine)
		$vt_headerLine:=$co_headersCollection[$vl_index]
		
		C_LONGINT:C283($vl_start)
		$vl_start:=Length:C16($vt_headerKey)+1
		If (Substring:C12($vt_headerLine; $vl_start; 1)=" ")  // "content-type: 1234"
			$vl_start:=$vl_start+1
		End if 
		$vt_headerValue:=Substring:C12($vt_headerLine; $vl_start)
		
		//$vt_headerValue:=Substring($vt_headerLine;Length($vt_headerKey)+1)
		//If (Substring($vt_headerValue;1;1)=" ")
		//$vt_headerValue:=Substring($vt_headerValue;2)
		//End if 
	End if 
	
End if 

$0:=$vt_headerValue
