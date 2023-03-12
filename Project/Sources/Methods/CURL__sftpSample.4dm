//%attributes = {"shared":false,"invisible":true}

C_OBJECT:C1216($options; $error)
$options:=New object:C1471

var $compiledFile : 4D:C1709.File
$compiledFile:=File:C1566("")


var $ftpHost; $user; $password; $dir; $remotePath; $remotePathEscaped; $welcome : Text
$ftpHost:="sftp.example.com"
$user:="xxxxx"
$password:="xxxxx"
$dir:="/nightly builds/"
$remotePath:=$dir+$compiledFile.fullName

// do url escape but do not escape "/"
$remotePathEscaped:=CURL_urlPathEscape($remotePath)

var $options : Object
$options.URL:="sftp://"+$ftpHost+$remotePathEscaped
$options.USERNAME:=$user
$options.PASSWORD:=$password

// si on utilise une authentification par clé privée, on ne passe pas $options.PASSWORD et on spécifie le fichier qui contient la clé privée
// $options.SSH_PRIVATE_KEYFILE:="Macintosh HD:Users:...:.ssh:id_rsa"
// $options.KEYPASSWD:="xxx" // if the private key is password protected...


// si le serveur sftp utilise un certificat auto-signé, on va utiliser cette otion :
$options.SSL_VERIFYPEER:=0

// si le certfificat du serveur ne correspond pas au "host" :
$options.SSL_VERIFYHOST:=0

// Si on veut être plus exigent sur la sécurité, on peut utiliser ces options
// ou le fichier cacert.pem contient la liste des certificats racine
// par exemple ce fichier "https://curl.se/ca/cacert.pem"
// $vo_curlOpts.SSL_VERIFYPEER:=1
// $vo_curlOpts.SSL_VERIFYHOST:=2
// $vo_curlOpts.USE_SSL:="CURLUSESSL_ALL"
// $vo_curlOpts.CAINFO:="Macintosh HD:Users:...:Resources:certs:cacert.pem"

// $options.UPLOAD:=1  // nécessaire ?
$options.READDATA:=$compiledFile.platformPath

var $error : Object
var $data : Blob  // optional
var $callback : Text
$error:=cURL_FTP_Send($options; $data; $callback)
