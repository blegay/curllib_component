//%attributes = {"shared":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"invisible":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}

C_COLLECTION:C1488($1; $co_headersCollection)
C_TEXT:C284($2; $vt_headerKey)
C_TEXT:C284($3; $vt_headerValue)
C_BOOLEAN:C305($4; $vb_override)


ASSERT:C1129(Count parameters:C259>2; "requires 3 parameter")
//ASSERT(Type($1->)=Text array;"$1 should be a text array pointer")
ASSERT:C1129(Length:C16($2)>0; "$2 should not be empty")
ASSERT:C1129($1#Null:C1517; "$1 should be a collection")

//Si (Nombre de paramètres>1)
$co_headersCollection:=$1
$vt_headerKey:=$2
$vt_headerValue:=$3

If (Count parameters:C259>3)
	$vb_override:=$4
Else 
	$vb_override:=True:C214
End if 

If ($co_headersCollection#Null:C1517)  //  indexOf fails on an Null collection
	
	If (Position:C15(":"; $vt_headerKey; *)=0)
		$vt_headerKey:=$vt_headerKey+":"
	End if 
	
	C_TEXT:C284($vt_headerLine)
	If (Length:C16($vt_headerValue)=0)
		$vt_headerLine:=$vt_headerKey
	Else 
		$vt_headerLine:=$vt_headerKey+" "+$vt_headerValue
	End if 
	
	C_LONGINT:C283($vl_index)
	$vl_index:=$co_headersCollection.indexOf($vt_headerKey+"@")
	// "Content-Type:@" matches "content-type:"
	If ($vl_index>=0)
		If ($vb_override)
			$co_headersCollection[$vl_index]:=$vt_headerLine
		End if 
	Else 
		$co_headersCollection.push($vt_headerLine)
	End if 
	
	//If ($vl_index>=0)
	//C_TEXT($vt_headerLine)
	//$vt_headerLine:=$co_headersCollection[$vl_index]
	
	//C_LONGINT($vl_start)
	//$vl_start:=Length($vt_headerKey)+1
	//If (Substring($vt_headerLine;$vl_start;1)=" ")  // "content-type: 1234"
	//$vl_start:=$vl_start+1
	//End if 
	//$vt_headerValue:=Substring($vt_headerLine;$vl_start)
	
	//$vt_headerValue:=Substring($vt_headerLine;Length($vt_headerKey)+1)
	//If (Substring($vt_headerValue;1;1)=" ")
	//$vt_headerValue:=Substring($vt_headerValue;2)
	//End if 
End if 


