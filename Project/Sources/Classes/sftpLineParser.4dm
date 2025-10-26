// Class sftpLineParser
// This class is used because curl with getDirList returns
// ftpparse collection
// with object with one "path" porterty : a line
// "-rw-r--r--    1 admin    admin           0 Oct 14 21:15 .myfilename"
// whereas in a ftp connexion, we get a object
// https://github.com/miyako/4d-plugin-curl-v3/releases
// v4.8.4 / 4.8.8.2
// Bruno LEGAY 2025-10-25

//property _regexUnix : Text
//property _regexDos : Text
//property _today : Date
//property _currentYear2Digit : Integer

Class constructor()
	
	This:C1470._regexUnix:="^([\\-d])([rwx\\-]{9})\\s+\\d+\\s+(\\S+)\\s+(\\S+)\\s+(\\d+)\\s+([A-Za-z]{3})\\s+(\\d{1,2})\\s+([\\d:]{4,5})\\s(.+)$"
	This:C1470._regexDos:="^(\\d{2})-(\\d{2})-(\\d{2})\\s+(\\d{2}):(\\d{2})(AM|PM)\\s+(<DIR>|\\d+)\\s+(.+)$"
	
	// permet de forcer les tests unitaires
	This:C1470._today:=Current date:C33
	This:C1470._currentYear2Digit:=Year of:C25(This:C1470._today)%100  // 0..99
	
Function parseLine($line : Text)->$lineObj : Object
	
	If ($line#"")
		ARRAY LONGINT:C221($tl_pos; 0)
		ARRAY LONGINT:C221($tl_len; 0)
		
		var $fileType; $permissions; $owner; $group; $dayTxt; $monthTxt; $name; $timeTxt; $timestamp : Text
		var $size : Real
		var $date : Date
		var $isDir : Boolean
		
		Case of 
			: (Match regex:C1019(This:C1470._regexUnix; $line; 1; $tl_pos; $tl_len; *))
				$lineObj:=New object:C1471
				
				var $timeOrYearTxt : Text
				
				$fileType:=Substring:C12($line; $tl_pos{1}; $tl_len{1})
				$permissions:=Substring:C12($line; $tl_pos{2}; $tl_len{2})
				$owner:=Substring:C12($line; $tl_pos{3}; $tl_len{3})
				$group:=Substring:C12($line; $tl_pos{4}; $tl_len{4})
				$size:=Num:C11(Substring:C12($line; $tl_pos{5}; $tl_len{5}))
				$monthTxt:=Substring:C12($line; $tl_pos{6}; $tl_len{6})
				$dayTxt:=Substring:C12($line; $tl_pos{7}; $tl_len{7})
				$timeOrYearTxt:=Substring:C12($line; $tl_pos{8}; $tl_len{8})
				$name:=Substring:C12($line; $tl_pos{9}; $tl_len{9})
				
				$isDir:=($fileType="d")
				Case of 
					: ($isDir & ($name="."))
						$fileType:="cdir"
						
					: ($isDir & ($name=".."))
						$fileType:="pdir"
						
					: ($isDir)
						$fileType:="dir"
						
					Else 
						//: (($fileType="-"))
						$fileType:="file"
				End case 
				
				$date:=This:C1470._dateUnixTxtToDate($dayTxt; $monthTxt; $timeOrYearTxt)
				$timeTxt:=Choose:C955(Match regex:C1019("\\d{2}:\\d{2}"; $timeOrYearTxt; 1); $timeOrYearTxt+":00"; "00:00:00")
				$timestamp:=This:C1470._timestamp($date; $timeTxt)
				
				$lineObj.type:=$fileType
				$lineObj.permissions:=$permissions
				$lineObj.owner:=$owner
				$lineObj.group:=$group
				$lineObj.size:=$size
				$lineObj.date:=$date
				$lineObj.time:=$timeTxt
				$lineObj.modify:=$timestamp
				$lineObj.path:=$name
				$lineObj.isDir:=$isDir
				
			: (Match regex:C1019(This:C1470._regexDos; $line; 1; $tl_pos; $tl_len; *))
				$lineObj:=New object:C1471
				
				var $yearTxt; $ampm; $sizeOrDir : Text
				var $hour; $minute : Integer
				
				$monthTxt:=Substring:C12($line; $tl_pos{1}; $tl_len{1})
				$dayTxt:=Substring:C12($line; $tl_pos{2}; $tl_len{2})
				$yearTxt:=Substring:C12($line; $tl_pos{3}; $tl_len{3})
				$hour:=Num:C11(Substring:C12($line; $tl_pos{4}; $tl_len{4}))
				$minute:=Num:C11(Substring:C12($line; $tl_pos{5}; $tl_len{5}))
				$ampm:=Substring:C12($line; $tl_pos{6}; $tl_len{6})
				$sizeOrDir:=Substring:C12($line; $tl_pos{7}; $tl_len{7})
				$name:=Substring:C12($line; $tl_pos{8}; $tl_len{8})
				
				Case of 
					: (($ampm="PM") & ($hour#12))
						$hour:=$hour+12
						
					: (($ampm="AM") & ($hour=12))
						$hour:=0
				End case 
				
				$isDir:=($sizeOrDir="<DIR>")
				
				$size:=Choose:C955($isDir; 0; Num:C11($sizeOrDir))
				
				Case of 
					: ($isDir & ($name="."))
						$fileType:="cdir"
						
					: ($isDir & ($name=".."))
						$fileType:="pdir"
						
					: ($isDir)
						$fileType:="dir"
						
					Else 
						$fileType:="file"
				End case 
				
				$date:=This:C1470._dateDosTxtToDate($dayTxt; $monthTxt; $yearTxt)
				$timeTxt:=Time string:C180(($hour*3600)+($minute*60))
				$timestamp:=This:C1470._timestamp($date; $timeTxt)
				
				$lineObj.type:=$fileType
				$lineObj.size:=$size
				$lineObj.date:=$date
				$lineObj.time:=$timeTxt
				$lineObj.modify:=$timestamp
				$lineObj.path:=$name
				$lineObj.isDir:=$isDir
				
		End case 
		
		ARRAY LONGINT:C221($tl_pos; 0)
		ARRAY LONGINT:C221($tl_len; 0)
	End if 
	
	
Function _dateUnixTxtToDate($dayTxt : Text; $monthTxt : Text; $timeOrYearTxt : Text)->$date : Date
	
	$date:=!00-00-00!
	If (Count parameters:C259>2)
		
		// Mar 10  2013
		// pour une date de moins de 6 moins unix, affiche l'heure du fichier (et pas l'année)
		// Apr 26 02:30
		// Jun 22 04:15
		
		var $months : Collection
		$months:=New collection:C1472("jan"; "feb"; "mar"; "apr"; "may"; "jun"; "jul"; "aug"; "sep"; "oct"; "nov"; "dec")
		//$months:=["Jan"; "Feb"; "Mar"; "Apr"; "May"; "Jun"; "Jul"; "Aug"; "Sep"; "Oct"; "Nov"; "Dec"]
		
		var $day : Integer
		$day:=Num:C11($dayTxt)
		
		var $monthIndex : Integer
		$monthIndex:=$months.indexOf(Lowercase:C14($monthTxt))+1
		If ($monthIndex>0)
			
			var $time : Time
			var $year : Integer
			
			var $regex : Text
			$regex:="\\d{2}:\\d{2}"  // "\d{2}:\d{2}"
			If (Match regex:C1019($regex; $timeOrYearTxt; 1))  //heure
				
				$time:=Time:C179($timeOrYearTxt+":00")
				
				var $today : Date
				$today:=This:C1470._today
				
				var $currentYear : Integer
				$currentYear:=Year of:C25($today)
				
				// "-rw-r--r--    1 admin    admin           0 Oct 14 21:15 .sudo_as_admin_successful"
				// "-rw-r--r--    1 admin    admin           0 Oct 14  2024 .sudo_as_admin_successful"
				// unix affiche l'heure si le fichier à moins de 6 mois
				// l'année sinon
				$date:=Add to date:C393(!00-00-00!; $currentYear; $monthIndex; $day)
				If ($date>($today+31))
					$date:=Add to date:C393($date; -1; 0; 0)
				End if 
				
			Else 
				$time:=?12:00:00?
				$year:=Num:C11($timeOrYearTxt)
				$date:=Add to date:C393(!00-00-00!; $year; $monthIndex; $day)
			End if 
			
		End if 
		
	End if 
	
	
Function _dateDosTxtToDate($dayTxt : Text; $monthTxt : Text; $timeOrYearTxt : Text)->$date : Date
	
	$date:=!00-00-00!
	If (Count parameters:C259>2)
		
		var $day; $month; $year : Integer
		$day:=Num:C11($dayTxt)
		$month:=Num:C11($monthTxt)
		$year:=Num:C11(This:C1470._year2digitTxtTo4digitTxt($timeOrYearTxt))
		
		$date:=Add to date:C393(!00-00-00!; $year; $month; $day)
	End if 
	
	
Function _year2digitTxtTo4digitTxt($year2digitTxt : Text)->$year4digitTxt : Text
	If (Length:C16($year2digitTxt)=4)
		$year4digitTxt:=$year2digitTxt
	Else 
		var $year2digitNum : Integer
		$year2digitNum:=Num:C11($year2digitTxt)
		If ($year2digitNum>This:C1470._currentYear2Digit)
			$year4digitTxt:="19"+$year2digitTxt
		Else 
			$year4digitTxt:="20"+$year2digitTxt
		End if 
	End if 
	
	
Function _timestamp($date : Date; $timeTxt : Text)->$timestamp : Text
	$timestamp:=String:C10(Year of:C25($date); "0000")+String:C10(Month of:C24($date); "00")+String:C10(Day of:C23($date); "00")+Replace string:C233($timeTxt; ":"; ""; *)
	// "20251014211500"
	// 
	//$timestamp:=String(Year of($date); "0000")+"-"+String(Month of($date); "00")+"-"+String(Day of($date); "00")+"T"+$timeTxt
	// "2025-10-14T21:15:00"