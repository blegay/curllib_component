//%attributes = {"invisible":true,"preemptive":"capable","shared":false}


C_OBJECT:C1216($vo_object)
$vo_object:=New object:C1471("name";"Bruno";"Surname";"LEGAY";"PASSWORD";"veryComplicated";"request";New object:C1471("KEYPASSWD";"veryComplicated");"coll";New collection:C1472("test";"PASSWORD";New collection:C1472("test";"PASSWORD")))

C_TEXT:C284($vt_json)
$vt_json:=CURL__debugObjectJson ($vo_object)
