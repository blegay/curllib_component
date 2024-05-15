
//Class: before
Class constructor($protocol : Text; $host : Text; $login : Text; $password : Text; $dir : Text)
	//Class: before
	// MARK: - fzf
	
	CURL__init
	
	//This.protocol:=$protocol  // "ftp", "sftp", "ftps"
	This:C1470.host:=$host
	Case of 
		: ($protocol="ftp")
			This:C1470.protocol:="ftp"
			
		: ($protocol="sftp")
			This:C1470.protocol:="sftp"
			
		: ($protocol="ftps")
			This:C1470.protocol:="ftps"
			
		Else 
			This:C1470.protocol:="ftp"
	End case 
	
	This:C1470.port:=This:C1470._defaultPort(This:C1470.protocol)
	
	//If (Count parameters>2)
	This:C1470.login:=$login
	//End if 
	//If (Count parameters>3)
	This:C1470.password:=$password
	//End if 
	
	This:C1470.defaultOptions:=New object:C1471
	
	//   /* USE_SSL */
	//     CHECK_CURLOPT_VALUE("USESSL_NONE",CURLUSESSL_NONE)
	//     CHECK_CURLOPT_VALUE("USESSL_TRY",CURLUSESSL_TRY)
	//     CHECK_CURLOPT_VALUE("USESSL_CONTROL",CURLUSESSL_CONTROL)
	//     CHECK_CURLOPT_VALUE("USESSL_ALL",CURLUSESSL_ALL)
	If ($protocol="ftp")
		This:C1470.defaultOptions.USE_SSL:="USESSL_NONE"
	Else 
		This:C1470.defaultOptions.USE_SSL:="USESSL_ALL"
	End if 
	
	//     /* SSLVERSION, PROXY_SSLVERSION */
	//     CHECK_CURLOPT_VALUE("SSLVERSION_DEFAULT",CURL_SSLVERSION_DEFAULT)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_TLSv1",CURL_SSLVERSION_TLSv1)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_SSLv2",CURL_SSLVERSION_SSLv2)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_SSLv3",CURL_SSLVERSION_SSLv3)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_TLSv1_0",CURL_SSLVERSION_TLSv1_0)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_TLSv1_1",CURL_SSLVERSION_TLSv1_1)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_TLSv1_2",CURL_SSLVERSION_TLSv1_2)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_TLSv1_3",CURL_SSLVERSION_TLSv1_3)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_MAX_DEFAULT",CURL_SSLVERSION_MAX_DEFAULT)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_MAX_TLSv1_0",CURL_SSLVERSION_MAX_TLSv1_0)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_MAX_TLSv1_1",CURL_SSLVERSION_MAX_TLSv1_1)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_MAX_TLSv1_2",CURL_SSLVERSION_MAX_TLSv1_2)
	//     CHECK_CURLOPT_VALUE("SSLVERSION_MAX_TLSv1_3",CURL_SSLVERSION_MAX_TLSv1_3)
	
	This:C1470.defaultOptions.SSL_VERIFYPEER:=2
	This:C1470.defaultOptions.SSL_VERIFYHOST:=1  // use 0 for self-signed certificates
	
	CURL_sslParamsObj(This:C1470.defaultOptions)
	
	This:C1470.debug:=False:C215
	This:C1470.debugDir:=Null:C1517
	
	This:C1470.cwd:="/"
	If (Count parameters:C259>4)
		This:C1470.setCurrentWorkingDir($dir)
	End if 
	
	This:C1470.progress:=False:C215
	This:C1470.progressAbortable:=False:C215
	This:C1470.progressTitle:=""
	This:C1470.progressCallback:="CURL_callback"
	This:C1470.progressId:=0
	
Function setCurrentWorkingDir($dir : Text; $createMissingDirs : Boolean)->$result : Object
	// hello
	
	// $createMissingDirs : default false
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	$result.options:=Null:C1517
	$result.command:=""
	
	If (Length:C16($dir)>0)
		
		// should always end with "/"
		If (Substring:C12($dir; Length:C16($dir); 1)#"/")
			$dir:=$dir+"/"
		End if 
		
		If (Substring:C12($dir; 1; 1)="/")  // absolute dir
		Else   // relative dir
			$dir:=This:C1470.cwd+$dir
		End if 
		
		If (Count parameters:C259>1)
			$result:=This:C1470.printDir($dir; $createMissingDirs)
		Else 
			$result:=This:C1470.printDir($dir; False:C215)
		End if 
		If ($result.success)
			This:C1470.cwd:=$dir
		End if 
		
	End if 
	
Function getCurrentWorkingDir->$dir : Text
	$dir:=This:C1470.cwd
	
Function setCurrentWorkingDirToParent()->$result : Object
	var $pathColl : Collection
	$pathColl:=Split string:C1554(This:C1470.cwd; "/"; sk ignore empty strings:K86:1)
	
	var $cwd : Text
	If ($pathColl.length>0)
		var $last : Text
		$last:=$pathColl.pop()
		
		If ($pathColl.length>0)
			$cwd:="/"+$pathColl.join("/")+"/"
		Else 
			$cwd:="/"
		End if 
		$result:=This:C1470.setCurrentWorkingDir($cwd)
	Else 
		$cwd:="/"
		$result:=This:C1470.setCurrentWorkingDir($cwd)
		$result.success:=False:C215
		$result.errorCode:=-2
		$result.errorMessage:="already at \"/\""
	End if 
	
Function send($file : 4D:C1709.File; $remoteFilenameParam : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	If ($file.exists)
		var $remoteFilename : Text
		
		Case of 
			: (Count parameters:C259>1)
				$remoteFilename:=$remoteFilenameParam
				
			: ($remoteFilename=Null:C1517)
				$remoteFilename:=$file.fullName
				
			: ($remoteFilename="")
				$remoteFilename:=$file.fullName
		End case 
		
		var $options : Object
		$options:=This:C1470._defaultOptions($remoteFilename)
		
		$options.FTP_CREATE_MISSING_DIRS:=1
		$options.RESUME_FROM:=0
		
		$options.READDATA:=$file.platformPath
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_Send"
		
		var $error : Object
		var $data : Blob
		SET BLOB SIZE:C606($data; 0)
		//$data:=$file.getContent()
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		This:C1470._progressInit($options)
		
		//%W-533.4
		$error:=cURL_FTP_Send($options; $data; This:C1470.progressCallback)
		//%W+533.4
		
		This:C1470._progressDeinit()
		
		$result.errorDetail:=$error
		
		SET BLOB SIZE:C606($data; 0)
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.aborted:=False:C215
			$result.errorCode:=0
			$result.errorMessage:=""
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.aborted:=($error.status=42)  // aborted
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Send error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			// par exemple $error.status=9 si le dossier n'existait pas (contourné avec l'option FTP_CREATE_MISSING_DIRS)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Send error : "+String:C10($error.status)+", file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
		This:C1470._logDebugDir("send"; $result)
		
	Else   // File not found
		$result.errorCode:=-43
		$result.errorMessage:="file : \""+$file.path+"\" not found"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" not found")
	End if 
	
Function receive($remoteFilename : Text; $file : 4D:C1709.File)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	If (Not:C34($file.exists))
		
		If ($remoteFilename="")
			$remoteFilename:=$file.fullName
		End if 
		
		var $options : Object
		$options:=This:C1470._defaultOptions($remoteFilename)
		
		$options.RESUME_FROM:=0
		
		$options.WRITEDATA:=$file.platformPath
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_Receive"
		
		var $error : Object
		var $data : Blob
		SET BLOB SIZE:C606($data; 0)
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		This:C1470._progressInit($options)
		
		//%W-533.4
		$error:=cURL_FTP_Receive($options; $data; This:C1470.progressCallback)
		//%W+533.4
		
		This:C1470._progressDeinit()
		
		$result.errorDetail:=$error
		
		SET BLOB SIZE:C606($data; 0)
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.aborted:=False:C215
			$result.errorCode:=0
			$result.errorMessage:=""
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.aborted:=($error.status=42)  // aborted
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Receive error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Receive error : "+String:C10($error.status)+", file : \""+$file.path+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
		This:C1470._logDebugDir("receive"; $result)
		
	Else   // File already exist
		$result.errorCode:=-43
		$result.errorMessage:="file : \""+$file.path+"\" already exist"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" already exist")
	End if 
	
Function delete($remoteFilename : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	var $options : Object
	$options:=This:C1470._defaultOptions($remoteFilename)
	
	$result.options:=This:C1470.toDebug($options)
	$result.command:="cURL_FTP_Delete"
	
	var $error : Object
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_Delete($options)
	//%W+533.4
	
	$result.errorDetail:=$error
	
	If ($error.status=0)
		$result.success:=True:C214
		$result.errorCode:=0
		$result.errorMessage:=""
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Delete error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Delete error : "+String:C10($error.status)+", remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
	This:C1470._logDebugDir("delete"; $result)
	
Function system()->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.system:=""
	$result.options:=Null:C1517
	$result.command:=""
	
	var $options : Object
	$options:=This:C1470._defaultOptions()
	
	$result.options:=This:C1470.toDebug($options)
	$result.command:="cURL_FTP_System"
	
	var $error : Object
	var $system : Text
	$system:=""
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_System($options; $system)
	//%W+533.4
	
	$result.errorDetail:=$error
	
	
	If ($error.status=0)
		$result.system:=$system
		
		If ($system="")  // bug in plugin v4.6.2 ?
			
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "system : \"\" empty, bug in plugin ?, options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
			
			var $responseLines : Collection
			$responseLines:=Split string:C1554($error.headerInfo; "\r\n"; sk ignore empty strings:K86:1)
			// 220 ProFTPD Server (ProFTPD) [192.168.1.50]\r\n
			// 331 Password required for john\r\n
			// 230 User john logged in\r\n
			// 257 "/" is the current directory\r\n
			// 215 UNIX Type: L8\r\n
			
			If ($responseLines.length>0)
				var $systemLine
				$systemLine:=$responseLines[$responseLines.length-1]
				//$system:=$responseLines.last()
				
				If (Length:C16($systemLine)>4)
					var $regex : Text
					$regex:="^\\d{3} (.*)$"
					
					ARRAY LONGINT:C221($tl_pos; 0)
					ARRAY LONGINT:C221($tl_len; 0)
					If (Match regex:C1019($regex; $systemLine; 1; $tl_pos; $tl_len))
						$system:=Substring:C12($systemLine; $tl_pos{1}; $tl_len{1})
						$result.system:=$system
						CURL__moduleDebugDateTimeLine(2; Current method name:C684; "system : \""+$system+"\", workaround, data extracted from error.headerInfo \r"+Replace string:C233($error.headerInfo; "\r\n"; "\r"; *))
					End if 
					ARRAY LONGINT:C221($tl_pos; 0)
					ARRAY LONGINT:C221($tl_len; 0)
				End if 
			End if 
		End if 
		
		$result.success:=True:C214
		$result.errorCode:=0
		$result.errorMessage:=""
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "system : \""+$system+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_System error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_System error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
	This:C1470._logDebugDir("system"; $result)
	
Function getDirList()->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	$result.options:=Null:C1517
	$result.command:=""
	
	var $options : Object
	$options:=This:C1470._defaultOptions()
	
	$options.FTP_USE_MLSD:=True:C214
	
	$result.options:=This:C1470.toDebug($options)
	$result.command:="cURL_FTP_GetDirList"
	
	If (False:C215)
		// LIST
		If (False:C215)
			// -rw-r--r--   1 john admins      70001 Jan  3 22:18 file1.xml\n
			// -rw-r--r--   1 john admins      12852 Jan  3 21:12 file2.txt\n
			// -rw-r--r--   1 john admins      69969 Jan  3 21:12 file3.xml\n
			// -rw-r--r--   1 john admins         13 Jan  6 10:13 hello world.txt\n
			// -rw-r--r--   1 john admins     182266 Jul 17 11:06 mapSvgData.xml\n
			// -rw-r--r--   1 john admins     736344 Dec  1  2020 sh\n
			// -rw-r--r--   1 john admins       3381 Dec  1  2020 statsParam.xml\n
			// drwxr-xr-x   2 john admins       4096 Jan  3 20:44 test\n
			
			// [
			//     {
			//         "name": "file1.xml",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 70001,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2024-01-03T22:18:00+0100"
			//     },
			//     {
			//         "name": "file2.txt",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 12852,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2024-01-03T21:12:00+0100"
			//     },
			//     {
			//         "name": "file3.xml",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 69969,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2024-01-03T21:12:00+0100"
			//     },
			//     {
			//         "name": "hello world.txt",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 13,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2024-01-06T10:16:00+0100"
			//     },
			//     {
			//         "name": "mapSvgData.xml",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 182266,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2023-07-17T11:06:00+0100"
			//     },
			//     {
			//         "name": "sh",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 736344,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEDAY",
			//         "mtime": "2020-12-01T00:00:00+0100"
			//     },
			//     {
			//         "name": "statsParam.xml",
			//         "id": "",
			//         "flagtrycwd": 0,
			//         "flagtryretr": 1,
			//         "size": 3381,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEDAY",
			//         "mtime": "2020-12-01T00:00:00+0100"
			//     },
			//     {
			//         "name": "test",
			//         "id": "",
			//         "flagtrycwd": 1,
			//         "flagtryretr": 0,
			//         "size": 4096,
			//         "sizetype": 1,
			//         "idtype": "UNKNOWN",
			//         "mtimetype": "REMOTEMINUTE",
			//         "mtime": "2024-01-03T20:44:00+0100"
			//     },
			//     null
			// ]
			
		End if 
		
		// MLSD
		If (False:C215)
			// modify=20240103194429;perm=flcdmpe;type=dir;unique=801U1BB2DB;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0755;UNIX.owner=20001;UNIX.ownername=john; test\n
			// modify=20201201131228;perm=adfrw;size=736344;type=file;unique=801U1BB33D;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; sh\n
			// modify=20240103201228;perm=adfrw;size=69969;type=file;unique=801U1BB338;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; file3\n
			// modify=20240106091309;perm=flcdmpe;type=cdir;unique=801U1BB337;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0755;UNIX.owner=20001;UNIX.ownername=john; .\n
			// modify=20201201131228;perm=adfrw;size=3381;type=file;unique=801U1BB33C;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; statsParam.xml\n
			// modify=20240103201216;perm=adfrw;size=12852;type=file;unique=801U1BB33B;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; file2\n
			// modify=20230717090628;perm=adfrw;size=182266;type=file;unique=801U1BB33A;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; mapSvgData.xml\n
			// modify=20240106091309;perm=flcdmpe;type=pdir;unique=801U1BB337;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0755;UNIX.owner=20001;UNIX.ownername=john; ..\n
			// modify=20240103211815;perm=adfrw;size=70001;type=file;unique=801U1BC74D;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; file1.xml\n
			// modify=20231227155503;perm=adfrw;size=18;type=file;unique=801U1BAD15;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0755;UNIX.owner=20001;UNIX.ownername=john; .htaccess\n
			// modify=20240106092045;perm=adfrw;size=13;type=file;unique=801U1BC769;UNIX.group=1004;UNIX.groupname=admins;UNIX.mode=0644;UNIX.owner=20001;UNIX.ownername=john; hello world.txt\n
			
			// [
			//     {
			//         "modify": "20240103194429",
			//         "perm": "flcdmpe",
			//         "type": "dir",
			//         "unique": "801U1BB2DB",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0755",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "test"
			//     },
			//     {
			//         "modify": "20201201131228",
			//         "perm": "adfrw",
			//         "size": "736344",
			//         "type": "file",
			//         "unique": "801U1BB33D",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "sh"
			//     },
			//     {
			//         "modify": "20240103201228",
			//         "perm": "adfrw",
			//         "size": "69969",
			//         "type": "file",
			//         "unique": "801U1BB338",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "file3"
			//     },
			//     {
			//         "modify": "20240106091309",
			//         "perm": "flcdmpe",
			//         "type": "cdir",
			//         "unique": "801U1BB337",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0755",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "."
			//     },
			//     {
			//         "modify": "20201201131228",
			//         "perm": "adfrw",
			//         "size": "3381",
			//         "type": "file",
			//         "unique": "801U1BB33C",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "statsParam.xml"
			//     },
			//     {
			//         "modify": "20240103201216",
			//         "perm": "adfrw",
			//         "size": "12852",
			//         "type": "file",
			//         "unique": "801U1BB33B",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "file2"
			//     },
			//     {
			//         "modify": "20230717090628",
			//         "perm": "adfrw",
			//         "size": "182266",
			//         "type": "file",
			//         "unique": "801U1BB33A",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "mapSvgData.xml"
			//     },
			//     {
			//         "modify": "20240106091309",
			//         "perm": "flcdmpe",
			//         "type": "pdir",
			//         "unique": "801U1BB337",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0755",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": ".."
			//     },
			//     {
			//         "modify": "20240103211815",
			//         "perm": "adfrw",
			//         "size": "70001",
			//         "type": "file",
			//         "unique": "801U1BC74D",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "file1.xml"
			//     },
			//     {
			//         "modify": "20231227155503",
			//         "perm": "adfrw",
			//         "size": "18",
			//         "type": "file",
			//         "unique": "801U1BAD15",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0755",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": ".htaccess"
			//     },
			//     {
			//         "modify": "20240106092045",
			//         "perm": "adfrw",
			//         "size": "13",
			//         "type": "file",
			//         "unique": "801U1BC769",
			//         "UNIX.group": "1004",
			//         "UNIX.groupname": "admins",
			//         "UNIX.mode": "0644",
			//         "UNIX.owner": "20001",
			//         "UNIX.ownername": "john",
			//         "path": "hello world.txt"
			//     }
			// ]
		End if 
	End if 
	
	var $error : Object
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_GetDirList($options)
	//%W+533.4
	
	$result.errorDetail:=$error
	
	If ($error.status=0)
		$result.success:=True:C214
		$result.errorCode:=0
		$result.errorMessage:=""
		$result.dirList:=$error.dirList
		$result.ftpparse:=$error.ftpparse.copy()
		//$result.ftpparse:=$error.ftpparse
		
		// sort by filename/path
		$result.ftpparse:=$result.ftpparse.orderBy("path asc")
		
		// if all names start with a space, it is probably a bug (seen with a "ProFTPD Server (ProFTPD)")
		// so remove leading space from each path...
		If ($result.ftpparse.query("path = :1"; " @").length=$result.ftpparse.length)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "fix suprious leading space...")
			$result.dirList:=Replace string:C233($result.dirList; "; "; ";"; *)
			var $ftpItem : Object
			For each ($ftpItem; $result.ftpparse)
				$ftpItem.path:=Substring:C12($ftpItem.path; 2)
			End for each 
		End if 
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_GetDirList error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_System error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
	This:C1470._logDebugDir("getDirList"; $result)
	
Function getFileInfos($filename : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.fileInfo:=Null:C1517
	$result.fileExists:=Null:C1517
	$result.options:=Null:C1517
	$result.command:=""
	
	If ($filename#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($filename)
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_GetFileInfo"
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_GetFileInfo($options)
		//%W+533.4
		
		// $error.fileInfo :
		// {size:13,date:2024-01-06T10:21:26Z}
		// {size:-1,date:1969-12-31T23:59:59Z}
		
		// $error.headerInfo :
		// 213 20240106102126\r\n
		// Last-Modified: Sat, 06 Jan 2024 10:21:26 GMT\r\n
		// 200 Type set to I\r\n213 13\r\n
		// Content-Length: 13\r\n
		// 350 Restarting at 0. Send STORE or RETRIEVE to initiate transfer\r\n
		// Accept-ranges: bytes\r\n
		
		$result.errorDetail:=$error
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			
			$result.fileInfo:=OB Copy:C1225($error.fileInfo)
			$result.fileExists:=True:C214
			//$result.ftpparse:=$error.ftpparse
			
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "cURL_FTP_GetFileInfo \""+$filename+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			If ($error.status=78)
				$result.fileExists:=False:C215
			End if 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_GetFileInfo \""+$filename+"\", error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_GetFileInfo \""+$filename+"\", error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
		This:C1470._logDebugDir("getFileInfos"; $result)
		
	Else   // empty file name
		$result.errorCode:=-43
		$result.errorMessage:="empty file name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty file name")
	End if 
	
Function makeDir($dirName : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	If ($dirName#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($dirName)
		
		$options.FTP_CREATE_MISSING_DIRS:=1
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_MakeDir"
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_MakeDir($options)
		//%W+533.4
		
		$result.errorDetail:=$error
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_MakeDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_MakeDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
		This:C1470._logDebugDir("makeDir"; $result)
		
	Else   // empty dir name
		$result.errorCode:=-43
		$result.errorMessage:="empty dir name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty dir name")
	End if 
	
Function removeDir($dirName : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	If ($dirName#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($dirName)
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_RemoveDir"
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_RemoveDir($options)
		//%W+533.4
		
		$result.errorDetail:=$error
		
		If (($error.status=0) | ($error.headerInfo="250 @"))  // bug in plugin v4.6.2 ?
			
			// $error.headerInfo :
			// 250 RMD command successful\r\n
			// 250 CWD command successful\r\n
			// 550 test2: No such file or directory\r\n
			
			// ok
			// "ftp://ftp.example.com/test2"
			// {success:false,errorCode:-1,errorMessage:unkown error,errorDetail:{}}
			
			// ok
			// "ftp://ftp.example.com/test2"
			// {success:false,errorCode:-1,errorMessage:unkown error,errorDetail:{}}
			
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remove dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_RemoveDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_RemoveDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
	Else   // empty dir name
		$result.errorCode:=-43
		$result.errorMessage:="empty dir name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty dir name")
	End if 
	
	This:C1470._logDebugDir("removeDir"; $result)
	
Function printDir($dirName : Text; $createMissingDirs : Boolean)->$result : Object
	// $createMissingDirs : default true
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	$result.options:=Null:C1517
	$result.command:=""
	
	var $dir : Text
	$dir:=$dirName
	If ($dir#"")
		If (Substring:C12($dir; Length:C16($dir); 1)#"/")
			$dir:=$dir+"/"
		End if 
	End if 
	
	var $options : Object
	$options:=This:C1470._defaultOptions($dir)
	
	If (Count parameters:C259>1)
		$options.FTP_CREATE_MISSING_DIRS:=Choose:C955($createMissingDirs; 1; 0)
	Else 
		$options.FTP_CREATE_MISSING_DIRS:=1
	End if 
	$result.options:=This:C1470.toDebug($options)
	$result.command:="cURL_FTP_PrintDir"
	
	var $error : Object
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "print dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_PrintDir($options)
	//%W+533.
	
	$result.errorDetail:=$error
	
	If ($error.status=0)
		// "test\nsh\ncartoPublique.xml\ntest2\nstatsParam.xml\ncartoPublique.txt\nmapSvgData.xml\ncartoPublique-test3.xml\nhello world.txt\n"
		$result.dirList:=$error.dirList
		$result.ftpparse:=Split string:C1554($result.dirList; "\n"; sk ignore empty strings:K86:1).orderBy(ck ascending:K85:9)
		
		$result.success:=True:C214
		$result.errorCode:=0
		$result.errorMessage:=""
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remove dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_RemoveDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_RemoveDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
	This:C1470._logDebugDir("printDir"; $result)
	
Function rename($oldName : Text; $newName : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.options:=Null:C1517
	$result.command:=""
	
	If (($oldName#"") & ($newName#""))
		
		var $options : Object
		$options:=This:C1470._defaultOptions($oldName)
		$options.RENAME_TO:=$newName
		
		$result.options:=This:C1470.toDebug($options)
		$result.command:="cURL_FTP_Rename"
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_Rename($options)
		//%W+533.
		
		$result.errorDetail:=$error
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470.toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
		This:C1470._logDebugDir("rename"; $result)
		
	Else   // empty file name
		$result.errorCode:=-43
		$result.errorMessage:="empty file name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty file name")
	End if 
	
Function toDebug($options : Object)->$debug : Object
	
	If (Count parameters:C259=0)
		$debug:=OB Copy:C1225(This:C1470)
	Else 
		$debug:=OB Copy:C1225($options)
	End if 
	
	Case of 
		: ($debug.password#Null:C1517)  // This
			$debug.password:=DBG_passwordDebug($debug.password)
			
		: ($debug.PASSWORD#Null:C1517)  // options
			$debug.PASSWORD:=DBG_passwordDebug($debug.PASSWORD)
			
	End case 
	
Function toUrl($remotePath : Text)->$url : Text
	
	var $portStr : Text
	Case of 
		: (This:C1470._defaultPort(This:C1470.protocol)=This:C1470.port)  // This.protocol="ftp" and This.port=21
			$portStr:=""
			
		: (This:C1470.port>0)
			$portStr:=":"+String:C10(This:C1470.port)
			
		Else 
			$portStr:=""
	End case 
	
	var $remotePathEscaped : Text
	Case of 
		: (Count parameters:C259=0)
			$remotePathEscaped:=CURL_urlPathEscape(This:C1470.cwd)
			
		: (Substring:C12($remotePath; 1; 1)="/")
			$remotePathEscaped:=CURL_urlPathEscape($remotePath)
			
		Else 
			$remotePathEscaped:=CURL_urlPathEscape(This:C1470.cwd+$remotePath)
	End case 
	
	$url:=This:C1470.protocol+"://"+This:C1470.host+$portStr+$remotePathEscaped
	
Function _defaultOptions($remoteFilenameParam : Text)->$options : Object
	
	var $remoteFilename : Text
	Case of 
		: (Count parameters:C259=0)
			$remoteFilename:=""
			
		: ($remoteFilename=Null:C1517)
			$remoteFilename:=""
			
		Else 
			$remoteFilename:=$remoteFilenameParam
	End case 
	
	$options:=OB Copy:C1225(This:C1470.defaultOptions)
	
	$options.URL:=This:C1470.toUrl($remoteFilename)
	
	If (This:C1470.login#Null:C1517)
		$options.USERNAME:=This:C1470.login
	End if 
	If (This:C1470.password#Null:C1517)
		$options.PASSWORD:=This:C1470.password
	End if 
	
	If (Bool:C1537(This:C1470.debug))
		
		var $folder : 4D:C1709.Folder
		
		Case of 
			: (This:C1470.debugDir=Null:C1517)
				$folder:=This:C1470._debugDefaultDirGet()
				This:C1470.debugDir:=$folder
				
			: (OB Instance of:C1731(This:C1470.debugDir; 4D:C1709.Folder))
				$folder:=This:C1470.debugDir
				
			Else 
				$folder:=This:C1470._debugDefaultDirGet()
				This:C1470.debugDir:=$folder
				
		End case 
		If (Not:C34($folder.exists))
			$folder.create()
		End if 
		
		var $debugDir : 4D:C1709.Folder
		$debugDir:=$folder.folder(This:C1470._debugDefaultDirName())
		$debugDir.create()
		
		$options.DEBUG:=$debugDir.platformPath
		
	End if 
	
Function _debugDefaultDirGet()->$folder : 4D:C1709.Folder
	
	$folder:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).folder("curllib_component_ftp")
	
Function _debugDefaultDirName()->$dirName : Text
	// debug_2024-01-08T09-36-50-519Z_32e6374484b74037a693950dc4edb2a5
	
	var $timestamp : Text
	$timestamp:=Timestamp:C1445  // 2016-12-12T13:31:29.477Z
	$timestamp:=Replace string:C233($timestamp; ":"; "-"; *)  // 2016-12-12T13-31-29.477Z
	$timestamp:=Replace string:C233($timestamp; "."; "-"; *)  // 2016-12-12T13-31-29-477Z
	
	$dirName:="debug_"+$timestamp+"_"+Lowercase:C14(Generate UUID:C1066)
	
Function _defaultPort($protocol : Text)->$port : Integer
	
	Case of 
		: ($protocol="ftp")
			$port:=21
			
		: ($protocol="sftp")
			$port:=22
			
		: ($protocol="ftps")
			$port:=990  // default to implicit ftps, but can also be 21 for explicit ftps
			
		Else 
			$port:=21
	End case 
	
Function _progressInit($options : Object)
	
	If (This:C1470.progress)
		C_BOOLEAN:C305($vb_isPreemptive; $vb_isHeadless; $vb_launchedAsService)
		$vb_isPreemptive:=UTL_processIsPreemptive
		$vb_isHeadless:=UTL_isHeadless
		$vb_launchedAsService:=UTL_launchedAsService
		C_LONGINT:C283($vl_progressId)
		$vl_progressId:=0
		
		If ($vb_isPreemptive | $vb_isHeadless | $vb_launchedAsService)
			
		Else 
			var $progressId : Integer
			
			//%T-
			EXECUTE METHOD:C1007("CURL__progressNew"; $progressId; This:C1470.progressTitle; This:C1470.progressAbortable)
			//%T+
			
			$options.PRIVATE:=JSON Stringify:C1217(New object:C1471("progressId"; $progressId))
			This:C1470.progressId:=$progressId
		End if 
		
	End if 
	
Function _progressDeinit()
	
	
	If (This:C1470.progressId#0)
		
		//%T-
		EXECUTE METHOD:C1007("CURL__progressClose"; *; This:C1470.progressId)
		//%T+
		
		This:C1470.progressId:=0
		This:C1470.PRIVATE:=""
	End if 
	
Function _logDebugDir($context : Text; $result : Object)
	
	If (String:C10($result.options.DEBUG)#"")
		CURL__moduleDebugDateTimeLine(Choose:C955($result.success; 4; 2); Current method name:C684; $context+" debug dir : \""+$result.options.DEBUG+"\". "+Choose:C955($result.success; "[OK]"; "[KO]"))
	End if 
	
	