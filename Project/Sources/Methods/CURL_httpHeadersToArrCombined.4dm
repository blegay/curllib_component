//%attributes = {"shared":true,"invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_httpHeadersToArrCombined
  //@scope : public
  //@deprecated : no
  //@description : This method/function returns 
  //@parameter[1-IN-httpRequestObj-OBJET] : http.request object
  //@parameter[2-OUT-headersArrayCombinedPtr-POINTER] : combined headers text array pointer (modified)
  //@notes :
  //@example : CURL_httpHeadersToArrCombined 
  //@see : 
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2008
  //@history : CREATION : Bruno LEGAY (BLE) - 19/11/2019, 14:15:23 - v1.00.00
  //@xdoc-end
  //================================================================================

  //C_OBJECT($1;$vo_httpRequestObj)
  //C_POINTER($2;$vp_headersArrayCombinedPtr)

  //ASSERT(OB Is defined($1;"headers");"headers object missing")
  //ASSERT(Type($2->)=Text array;"$2 should be a text array")

  //$vo_httpRequestObj:=$1
  //$vp_headersArrayCombinedPtr:=$2


  //C_OBJECT($vo_headers;0)
  //$vo_headers:=OB Get($vo_httpRequestObj;"headers";Is object)

  //ARRAY TEXT($tt_propertiesName;0)

  //OB GET PROPERTY NAMES($vo_headers;$tt_propertiesName)

  //C_LONGINT($i;$vl_count)
  //$vl_count:=Size of array($tt_propertiesName)
  //ARRAY TEXT($tt_headers;$vl_count)
  //For ($i;1;$vl_count)
  //C_TEXT($vt_value)
  //$vt_value:=OB Get($vo_headers;$tt_propertiesName{$i})
  //$tt_headers{$i}:=$tt_propertiesName{$i}+": "+$vt_value
  //End for 
  //COPY ARRAY($tt_headers;$vp_headersArrayCombinedPtr->)
  //ARRAY TEXT($tt_propertiesName;0)
