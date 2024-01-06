//%attributes = {"invisible":false,"shared":true}
//================================================================================
//@xdoc-start : en
//@name : CURL_ftpNew
//@scope : private 
//@deprecated : no
//@description : This function returns a cs.ftp class instance
//@parameter[0-OUT-ftp-OBJECT] : cs.ftp class instance
//@parameter[2-IN-protocol-TEXT] : protocol
//@parameter[2-IN-host-TEXT] : host
//@parameter[3-IN-login-TEXT] : login
//@parameter[4-IN-password-TEXT] : password
//@parameter[5-IN-dir-TEXT] : dir (optional, default value : "/")
//@notes : 
//@example : 
//
//    // Before 4D v19R5
//
//  var $protocol; $host; $login; $password : Text
//  $protocol:="ftp"
//  $host:="ftp.example.com"
//  $login:="login"
//  $password:="password"
//
//  var $ftp : Object
//  $ftp:=CURL_ftpNew($protocol; $host; $login; $password) 
//
//    // in 4D v19R5+
//
//  var $protocol; $host; $login; $password : Text
//  $protocol:="ftp"
//  $host:="ftp.example.com"
//  $login:="login"
//  $password:="password"

//  var $ftp : cs.curl.ftp
//  $ftp:=cs.curl.ftp.new($protocol; $host; $login; $password)
//
//@see : 
//@version : 1.00.00
//@author : 
//@history : 
//  CREATION :  - 06/01/2024, 18:37:30 - 1.00.00
//@xdoc-end
//================================================================================

C_OBJECT:C1216($0; $vo_ftp)  //  cs.ftp
C_TEXT:C284($1; $vt_protocol)
C_TEXT:C284($2; $vt_host)
C_TEXT:C284($3; $vt_login)
C_TEXT:C284($4; $vt_password)
C_TEXT:C284($5; $vt_dir)

ASSERT:C1129(Count parameters:C259>3; "requires 4 paramters")

C_LONGINT:C283($vl_nbParam)
$vl_nbParam:=Count parameters:C259
If ($vl_nbParam>3)
	$vt_protocol:=$1
	$vt_host:=$2
	$vt_login:=$3
	$vt_password:=$4
	
	Case of 
		: ($vl_nbParam=4)
			
			//var $ftp : cs.ftp
			$vo_ftp:=cs:C1710.ftp.new($vt_protocol; $vt_host; $vt_login; $vt_password)
			
		Else 
			$vt_dir:=$5
			
			//var $ftp : cs.ftp
			$vo_ftp:=cs:C1710.ftp.new($vt_protocol; $vt_host; $vt_login; $vt_password; $vt_dir)
			
	End case 
	
End if 
$0:=$vo_ftp