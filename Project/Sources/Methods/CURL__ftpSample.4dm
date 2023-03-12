//%attributes = {"invisible":true,"shared":false}
C_OBJECT:C1216($options; $error)
$options:=New object:C1471

var $compiledFile : 4D:C1709.File
$compiledFile:=File:C1566("")

var $ftpHost; $user; $password; $dir; $remotePath; $remotePathEscaped; $welcome : Text
$ftpHost:="ftp.example.com"
$user:="xxxxx"
$password:="xxxxx"
$dir:="/nightly builds/"
$remotePath:=$dir+$compiledFile.fullName

// do url escape but do not escape "/"
$remotePathEscaped:=CURL_urlPathEscape($remotePath)

var $options : Object
$options.URL:="ftp://"+$ftpHost+$remotePathEscaped
$options.USERNAME:=$user
$options.PASSWORD:=$password
// $options.UPLOAD:=1  // nécessaire ?
$options.READDATA:=$compiledFile.platformPath

var $error : Object
var $data : Blob  // optional
var $callback : Text
$error:=cURL_FTP_Send($options; $data; $callback)


//$options.WRITEDATA:=$compiledFile.platformPath

//var $error : Object
//var $data : Blob  // optional
//var $callback : Text
//$error:=cURL_FTP_Receive($options; $data; $callback)
