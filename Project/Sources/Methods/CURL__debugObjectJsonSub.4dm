//%attributes = {"invisible":true,"preemptive":"capable","shared":false}
//C_OBJECT($1;$vo_object)
C_VARIANT:C1683($1; $vo_object)
C_COLLECTION:C1488($2; $co_passwordProp)

$vo_object:=$1
$co_passwordProp:=$2


C_LONGINT:C283($vl_valueType)
$vl_valueType:=Value type:C1509($vo_object)
Case of 
	: ($vl_valueType=Is undefined:K8:13)
	: ($vl_valueType=Is object:K8:27)
		
		ARRAY TEXT:C222($tl_names; 0)
		ARRAY LONGINT:C221($tl_types; 0)
		OB GET PROPERTY NAMES:C1232($vo_object; $tt_names; $tl_types)
		
		C_LONGINT:C283($vl_propertyIndex; $vl_propCount)
		$vl_propCount:=Size of array:C274($tt_names)
		For ($vl_propertyIndex; 1; $vl_propCount)
			
			C_LONGINT:C283($vl_propertyType)
			$vl_propertyType:=$tl_types{$vl_propertyIndex}
			
			C_TEXT:C284($vt_propertyName)
			$vt_propertyName:=$tt_names{$vl_propertyIndex}
			
			Case of 
				: ($vl_propertyType=Is null:K8:31)
				: ($vl_propertyType=Is boolean:K8:9)
				: ($vl_propertyType=Is real:K8:4)
				: ($vl_propertyType=Is text:K8:3)
					
					C_LONGINT:C283($vl_index)
					$vl_index:=$co_passwordProp.indexOf($vt_propertyName)
					If ($vl_index>=0)
						// sanitize password
						C_TEXT:C284($vt_password)
						$vt_password:=OB Get:C1224($vo_object; $vt_propertyName)
						
						OB SET:C1220($vo_object; $vt_propertyName; DBG_passwordDebug($vt_password))
						$vt_password:=""
					End if 
					
				: ($vl_propertyType=Is object:K8:27)
					
					CURL__debugObjectJsonSub(OB Get:C1224($vo_object; $vt_propertyName); $co_passwordProp)
					
				: ($vl_propertyType=Object array:K8:28)
					
					ARRAY OBJECT:C1221($to_objects; 0)
					OB GET ARRAY:C1229($vo_object; $vt_propertyName; $to_objects)
					
					C_LONGINT:C283($vl_index; $vl_arraySize)
					$vl_arraySize:=Size of array:C274($to_objects)
					
					For ($vl_index; 1; $vl_arraySize)
						CURL__debugObjectJsonSub($to_objects{$vl_index}; $co_passwordProp)
					End for 
					
					OB SET ARRAY:C1227($vo_object; $vt_propertyName; $to_objects)
					ARRAY OBJECT:C1221($to_objects; 0)
					
				: ($vl_propertyType=Is collection:K8:32)
					
					C_COLLECTION:C1488($c_collection)
					$c_collection:=$vo_object[$vt_propertyName]
					CURL__debugObjectJsonSub($c_collection; $co_passwordProp)
					
				Else 
					//%T-
					TRACE:C157
					//%T+
			End case 
			
		End for 
		
	: ($vl_valueType=Is collection:K8:32)
		
		C_VARIANT:C1683($vv_subObject)
		For each ($vv_subObject; $vo_object)
			CURL__debugObjectJsonSub($vv_subObject; $co_passwordProp)
		End for each 
		
		
	Else 
		//%T-
		//TRACE
		//%T+
End case 
