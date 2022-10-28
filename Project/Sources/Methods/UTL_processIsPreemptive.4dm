//%attributes = {"invisible":true,"preemptive":"capable"}

C_BOOLEAN:C305($0; $vb_isPreemptive)

C_TEXT:C284($vt_name)
C_LONGINT:C283($vl_state; $vl_time; $vl_flags)
PROCESS PROPERTIES:C336(Current process:C322; $vt_name; $vl_state; $vl_time; $vl_flags)

$vb_isPreemptive:=($vl_flags ?? 1)

$0:=$vb_isPreemptive