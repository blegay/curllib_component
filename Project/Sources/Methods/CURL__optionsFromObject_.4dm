//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__optionsFromObject_
//@scope : public
//@deprecated : no
//@description : This method fills arrays of key and value options for curl from an object
//@parameter[1-INOUT-headerKeyPtr-POINTER] : curl option key longint array pointer (modified)
//@parameter[2-INOUT-headerValuePtr-POINTER] : curl option value text array pointer (modified)
//@parameter[3-IN-options-object] : curl options object
//@notes : 
//@example : CURL__optionsFromObject_
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 18:34:37 - 1.00.00
//@xdoc-end
//================================================================================

//C_POINTER($1;$vp_headerKeyPtr)
//C_POINTER($2;$vp_headerValuePtr)
//C_OBJECT($3;$vo_options)

//ASSERT(Count parameters>2;"requires 3 parameters")
//ASSERT(Type($1->)=LongInt array;"$1 should be a longint array pointer")
//ASSERT(Type($2->)=Text array;"$1 should be a text array pointer")
//ASSERT(Size of array($1->)=Size of array($2->);"$2-> and $2-> should be of same size")

//C_LONGINT($vl_nbParam)
//$vl_nbParam:=Count parameters

//$vp_headerKeyPtr:=$1
//$vp_headerValuePtr:=$2
//$vo_options:=$3

//If (Not(OB Is empty($vo_options)))

//If (OB Is defined($vo_options;"curlOptions"))
//ARRAY OBJECT($to_options;0)
//OB GET ARRAY($vo_options;"curlOptions";$to_options)

//C_LONGINT($i)
//For ($i;1;Size of array($to_options))
//C_LONGINT($vl_key)
//C_TEXT($vt_value)

//$vl_key:=OB Get($to_options{$i};"key";Is longint)
//$vt_value:=OB Get($to_options{$i};"value";Is text)

//CURL__options ($vp_headerKeyPtr;$vp_headerValuePtr;$vl_key;$vt_value)

//  //<Modif> Bruno LEGAY (BLE) (29/09/2017)
//C_TEXT($vt_valueDebug)
//Case of 
//  //<Modif> Bruno LEGAY (BLE) (18/09/2018) - v1.00.05
//: (($vl_key=CURLOPT_PROXYUSERPWD) | \
($vl_key=CURLOPT_PASSWORD) | \
($vl_key=CURLOPT_KEYPASSWD) | \
($vl_key=CURLOPT_TLSAUTH_PASSWORD))
//  //: (($vl_key=CURLOPT_PROXYUSERPWD) | ($vl_key=CURLOPT_PASSWORD))
//  //<Modif>
//$vt_valueDebug:=DBG_passwordDebug ($vt_value)
//Else 
//$vt_valueDebug:=$vt_value
//End case 
//  //<Modif>

//  //<Modif> Bruno LEGAY (BLE) (18/09/2018)

//CURL__moduleDebugDateTimeLine (6;Current method name;"CURLOPT key : \""+CURL__optDebug ($vl_key)+"\" ("+String($vl_key)+"), value : \""+$vt_valueDebug+"\"")
//  //CURL__moduleDebugDateTimeLine (6;Nom méthode courante;"CURLOPT key : "+Chaîne($vl_key)+", value : \""+$vt_valueDebug+"\"")

//  //<Modif>


//End for 

//ARRAY OBJECT($to_options;0)
//End if 

//End if 
