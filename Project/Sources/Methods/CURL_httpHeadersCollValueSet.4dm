//%attributes = {"shared":true,"invisible":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_httpHeadersCollValueSet
  //@scope : public 
  //@deprecated : no
  //@description : This method will set a header key/value in a collection of headers
  //@parameter[1-INOUT-headersCollection-COLLECTION] : headers collection (modified)
  //@parameter[2-IN-headerKey-TEXT] : header key
  //@parameter[3-IN-headerValue-TEXT] : header value
  //@parameter[4-IN-override-BOOLEAN] : if TRUE will override the existing value (optional, default TRUE)
  //@notes : header key is not case sensitive
  //@example : CURL_httpHeadersCollValueSet
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2022
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 04/01/2022, 18:39:05 - 3.00.00
  //@xdoc-end
  //================================================================================

C_COLLECTION:C1488($1;$c_headersCollection)
C_TEXT:C284($2;$vt_headerKey)
C_TEXT:C284($3;$vt_headerValue)
C_BOOLEAN:C305($4;$vb_override)

ASSERT:C1129(Count parameters:C259>2;"requires 3 parameter")
  //ASSERT(Type($1->)=Text array;"$1 should be a text array pointer")
ASSERT:C1129(Length:C16($2)>0;"$2 should not be empty")
ASSERT:C1129($1#Null:C1517;"$1 should be a collection")

  //Si (Nombre de paramètres>1)
$c_headersCollection:=$1
$vt_headerKey:=$2
$vt_headerValue:=$3

If (Count parameters:C259>3)
	$vb_override:=$4
Else 
	$vb_override:=True:C214
End if 

If ($c_headersCollection#Null:C1517)  //  indexOf fails on an Null collection
	
	If (Position:C15(":";$vt_headerKey;*)=0)
		$vt_headerKey:=$vt_headerKey+":"
	End if 
	
	C_TEXT:C284($vt_headerLine)
	If (Length:C16($vt_headerValue)=0)
		$vt_headerLine:=$vt_headerKey
	Else 
		$vt_headerLine:=$vt_headerKey+" "+$vt_headerValue
	End if 
	
	C_LONGINT:C283($vl_index)
	$vl_index:=$c_headersCollection.indexOf($vt_headerKey+"@")
	  // "Content-Type:@" matches "content-type:"
	If ($vl_index>=0)
		If ($vb_override)
			$c_headersCollection[$vl_index]:=$vt_headerLine
		End if 
	Else 
		$c_headersCollection.push($vt_headerLine)
	End if 
	
	  //If ($vl_index>=0)
	  //C_TEXT($vt_headerLine)
	  //$vt_headerLine:=$c_headersCollection[$vl_index]
	
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


