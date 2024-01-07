

Class constructor($protocol : Text; $host : Text; $login : Text; $password : Text; $dir : Text)
	
	//This.protocol:=$protocol  // "ftp", "sftp", "ftps"
	This:C1470.host:=$host
	Case of 
		: ($protocol="ftp")
			This:C1470.protocol:="ftp"
			This:C1470.port:=21
			
		: ($protocol="sftp")
			This:C1470.protocol:="sftp"
			This:C1470.port:=22
			
		: ($protocol="ftps")
			This:C1470.protocol:="ftps"
			This:C1470.port:=990  // default to implicit ftps, but can also be 21 for explicit ftps
			
		Else 
			This:C1470.protocol:="ftp"
			This:C1470.port:=21
	End case 
	
	This:C1470.login:=$login
	This:C1470.password:=$password
	
	This:C1470.defaultOptions:=New object:C1471
	If ($protocol#"ftp")
		This:C1470.defaultOptions.SSL_VERIFYPEER:=2
		This:C1470.defaultOptions.SSL_VERIFYHOST:=1
		CURL_sslParamsObj(This:C1470.defaultOptions)
	End if 
	
	This:C1470.cwd:="/"
	If (Count parameters:C259>4)
		This:C1470.setCurrentWorkingDir($dir)
	End if 
	
	This:C1470.progress:=False:C215
	This:C1470.progressAbortable:=False:C215
	This:C1470.progressTitle:=""
	This:C1470.progressCallback:="CURL_callback"
	This:C1470.progressId:=0
	
Function setCurrentWorkingDir($dir : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	
	If (Length:C16($dir)>0)
		
		If (Substring:C12($dir; Length:C16($dir); 1)#"/")
			$dir:=$dir+"/"
		End if 
		
		If (Substring:C12($dir; 1; 1)="/")  // absolute dir
			//This.cwd:=$dir
		Else   // relative dir
			$dir:=This:C1470.cwd+$dir
			//This.cwd:=$dir
		End if 
		
		$result:=This:C1470.printDir($dir)
		If ($result.success)
			This:C1470.cwd:=$dir
		End if 
		
	End if 
	
Function getCurrentWorkingDir->$dir : Text
	$dir:=This:C1470.cwd
	
Function send($file : 4D:C1709.file; $remoteFilename : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	
	If ($file.exists)
		Case of 
			: ($remoteFilename=Null:C1517)
				$remoteFilename:=$file.fullName
				
			: ($remoteFilename="")
				$remoteFilename:=$file.fullName
		End case 
		
		var $options : Object
		$options:=This:C1470._defaultOptions($remoteFilename)
		
		$options.FTP_CREATE_MISSING_DIRS:=1
		
		$options.READDATA:=$file.platformPath
		
		var $error : Object
		var $data : Blob
		SET BLOB SIZE:C606($data; 0)
		//$data:=$file.getContent()
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
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
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.aborted:=($error.status=42)  // aborted
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Send error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			// par exemple $error.status=9 si le dossier n'existait pas (contourné avec l'option FTP_CREATE_MISSING_DIRS)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Send error : "+String:C10($error.status)+", file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
	Else   // File not found
		$result.errorCode:=-43
		$result.errorMessage:="file : \""+$file.path+"\" not found"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" not found")
	End if 
	
Function receive($remoteFilename : Text; $file : 4D:C1709.file)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	
	If (Not:C34($file.exists))
		
		If ($remoteFilename="")
			$remoteFilename:=$file.fullName
		End if 
		
		var $options : Object
		$options:=This:C1470._defaultOptions($remoteFilename)
		
		$options.WRITEDATA:=$file.platformPath
		
		var $error : Object
		var $data : Blob
		SET BLOB SIZE:C606($data; 0)
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
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
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "file : \""+$file.path+"\" ("+String:C10($file.size)+" bytes), options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.aborted:=($error.status=42)  // aborted
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Receive error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Receive error : "+String:C10($error.status)+", file : \""+$file.path+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
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
	
	var $options : Object
	$options:=This:C1470._defaultOptions($remoteFilename)
	
	var $error : Object
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_Delete($options)
	//%W+533.4
	
	$result.errorDetail:=$error
	
	If ($error.status=0)
		$result.success:=True:C214
		$result.errorCode:=0
		$result.errorMessage:=""
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Delete error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Delete error : "+String:C10($error.status)+", remote filename : \""+$remoteFilename+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
Function system($systemPtr : Pointer)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	
	var $options : Object
	$options:=This:C1470._defaultOptions()
	
	var $error : Object
	var $system : Text
	$system:=""
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
	
	//%W-533.4
	$error:=cURL_FTP_System($options; $system)
	//%W+533.4
	
	$result.errorDetail:=$error
	
	$systemPtr->:=$system
	
	If ($error.status=0)
		
		If ($system="")  // bug in plugin v4.6.2 ?
			
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "system : \"\" empty, bug in plugin ?, options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
			
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
						$systemPtr->:=$system
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
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "system : \""+$system+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_System error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_System error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
Function getDirList()->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	
	var $options : Object
	$options:=This:C1470._defaultOptions()
	
	$options.FTP_USE_MLSD:=True:C214
	
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
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
	
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
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_GetDirList error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_System error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
Function getFileInfos($filename : Text)->$result : Object
	
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.fileInfo:=Null:C1517
	
	If ($filename#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($filename)
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
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
			//$result.ftpparse:=$error.ftpparse
			
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "cURL_FTP_GetFileInfo \""+$filename+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_GetFileInfo \""+$filename+"\", error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_GetFileInfo \""+$filename+"\", error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
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
	
	If ($dirName#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($dirName)
		
		$options.FTP_CREATE_MISSING_DIRS:=1
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_MakeDir($options)
		//%W+533.4
		
		$result.errorDetail:=$error
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_MakeDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_MakeDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
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
	
	If ($dirName#"")
		
		var $options : Object
		$options:=This:C1470._defaultOptions($dirName)
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
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
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remove dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_RemoveDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_RemoveDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
	Else   // empty dir name
		$result.errorCode:=-43
		$result.errorMessage:="empty dir name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty dir name")
	End if 
	
Function printDir($dirName : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	$result.dirList:=""
	$result.ftpparse:=Null:C1517
	
	var $dir : Text
	$dir:=$dirName
	If ($dir#"")
		If (Substring:C12($dir; 1; 1)="/")
			$dir:=Substring:C12($dir; 2)
		End if 
		If (Substring:C12($dir; Length:C16($dir); 1)#"/")
			$dir:=$dir+"/"
		End if 
	End if 
	
	var $options : Object
	$options:=This:C1470._defaultOptions($dir)
	
	$options.FTP_CREATE_MISSING_DIRS:=1
	
	var $error : Object
	
	CURL__moduleDebugDateTimeLine(4; Current method name:C684; "create dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
	
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
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "remove dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	Else 
		$result.errorCode:=$error.status
		$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_RemoveDir error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
		CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_RemoveDir error : "+String:C10($error.status)+", dir : \""+$dirName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
	End if 
	
Function rename($oldName : Text; $newName : Text)->$result : Object
	
	$result:=New object:C1471
	$result.success:=False:C215
	$result.errorCode:=-1
	$result.errorMessage:="unkown error"
	$result.errorDetail:=New object:C1471
	
	If (($oldName#"") & ($newName#""))
		
		var $options : Object
		$options:=This:C1470._defaultOptions($oldName)
		$options.RENAME_TO:=$newName
		
		var $error : Object
		
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+"...")
		
		//%W-533.4
		$error:=cURL_FTP_Rename($options)
		//%W+533.
		
		$result.errorDetail:=$error
		
		If ($error.status=0)
			$result.success:=True:C214
			$result.errorCode:=0
			$result.errorMessage:=""
			
			CURL__moduleDebugDateTimeLine(4; Current method name:C684; "cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		Else 
			$result.errorCode:=$error.status
			$result.errorMessage:="curl "+This:C1470.protocol+" cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", error : "+String:C10($error.status)+" - "+CURL_errorToText($error.status)
			CURL__moduleDebugDateTimeLine(2; Current method name:C684; "cURL_FTP_Rename \""+$oldName+"\" => \""+$newName+"\", error : "+String:C10($error.status)+", options : "+JSON Stringify:C1217(This:C1470._toDebug($options))+", error : "+JSON Stringify:C1217($error))
		End if 
		
	Else   // empty file name
		$result.errorCode:=-43
		$result.errorMessage:="empty file name"
		CURL__moduleDebugDateTimeLine(4; Current method name:C684; "empty file name")
	End if 
	
Function _defaultOptions($remoteFilename : Text)->$options : Object
	
	var $remotePath : Text
	Case of 
		: (Count parameters:C259=0)
			$remotePath:=This:C1470.cwd
			
		: ($remoteFilename=Null:C1517)
			$remotePath:=This:C1470.cwd
			
		Else 
			$remotePath:=This:C1470.cwd+$remoteFilename
	End case 
	
	$options:=OB Copy:C1225(This:C1470.defaultOptions)
	
	$options.URL:=This:C1470.protocol+"://"+This:C1470.host+Choose:C955(This:C1470.port>0; ":"+String:C10(This:C1470.port); "")+CURL_urlPathEscape($remotePath)
	$options.USERNAME:=This:C1470.login
	$options.PASSWORD:=This:C1470.password
	
	If (Bool:C1537($options.debug))
		
		var $folder : 4D:C1709.Folder
		If (OB Instance of:C1731($options.debugDir; 4D:C1709.Folder))
			$folder:=$options.debugDir
			If (Not:C34($folder.exists))
				$folder.create()
			End if 
		Else 
			$folder:=Folder:C1567(Temporary folder:C486; fk posix path:K87:1)
		End if 
		
		var $timestamp : Text
		$timestamp:=Timestamp:C1445  // 2016-12-12T13:31:29.477Z
		$timestamp:=Replace string:C233($timestamp; ":"; "-"; *)  // 2016-12-12T13-31-29.477Z
		$timestamp:=Replace string:C233($timestamp; "."; "-"; *)  // 2016-12-12T13-31-29-477Z
		
		var $debugDir : 4D:C1709.Folder
		$debugDir:=$folder.folder("debug_"+$timestamp+"_"+Lowercase:C14(Generate UUID:C1066))
		$debugDir.create()
		
		$options.DEBUG:=$debugDir.platformPath
		
	End if 
	
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
		This:C1470.PRIVATE:=""
	End if 
	
Function _toDebug($options : Object)->$optionsDebug : Object
	
	$optionsDebug:=OB Copy:C1225($options)
	If ($optionsDebug.PASSWORD#Null:C1517)
		$optionsDebug.PASSWORD:=DBG_passwordDebug($optionsDebug.PASSWORD)
	End if 
	