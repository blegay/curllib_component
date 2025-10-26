//%attributes = {"invisible":true,"shared":false}
//================================================================================
//@xdoc-start : en
//@name : CURL__sftpLineParser_unitTest
//@scope : private 
//@deprecated : no
//@description : This function test the sftpLineParser class
//@notes : 
//@example : CURL__sftpLineParser_unitTest
//@see : 
//@version : 1.00.00
//@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting 2025
//@history : 
//  CREATION : Bruno LEGAY (BLE) - 25/10/2025, 08:59:36 - 4.00.01
//@xdoc-end
//================================================================================

SET ASSERT ENABLED:C1131(True:C214)

var $ftpLineParser : cs:C1710.sftpLineParser
$ftpLineParser:=cs:C1710.sftpLineParser.new()

// for unit testing
$ftpLineParser._today:=!2025-10-26!
$ftpLineParser._currentYear2Digit:=25

var $line : Text
var $obj; $objExpected : Object

$line:="-rw-r--r--    1 admin    admin           1 Oct 14 21:15 test.tmp"
$obj:=$ftpLineParser.parseLine($line)

/*
$objExpected:={\
type: "file"; \
permissions: "rw-r--r--"; \
owner: "admin"; \
group: "admin"; \
size: 1; \
date: "2025-10-14"; \
time: "21:15:00"; \
modify: "20251014211500"; \
path: "test.tmp"; \
isDir: False}
*/

$objExpected:=New object:C1471(\
"type"; "file"; \
"permissions"; "rw-r--r--"; \
"owner"; "admin"; \
"group"; "admin"; \
"size"; 1; \
"date"; "2025-10-14"; \
"time"; "21:15:00"; \
"modify"; "20251014211500"; \
"path"; "test.tmp"; \
"isDir"; False:C215)
ASSERT:C1129(JSON Stringify:C1217($obj)=JSON Stringify:C1217($objExpected))


$line:="-rw-r--r--    1 admin    admin           1 Oct 14  2024 test.tmp"
$obj:=$ftpLineParser.parseLine($line)

/*
$objExpected:={\
type: "file"; \
permissions: "rw-r--r--"; \
owner: "admin"; \
group: "admin"; \
size: 1; \
date: "2024-10-14"; \
time: "00:00:00"; \
modify: "20241014000000"; \
path: "test.tmp"; \
isDir: False}
*/

$objExpected:=New object:C1471(\
"type"; "file"; \
"permissions"; "rw-r--r--"; \
"owner"; "admin"; \
"group"; "admin"; \
"size"; 1; \
"date"; "2024-10-14"; \
"time"; "00:00:00"; \
"modify"; "20241014000000"; \
"path"; "test.tmp"; \
"isDir"; False:C215)
ASSERT:C1129(JSON Stringify:C1217($obj)=JSON Stringify:C1217($objExpected))

$line:="10-14-25  09:15PM                  1 test.tmp"
$obj:=$ftpLineParser.parseLine($line)

/*
$objExpected:={\
type: "file"; \
size: 1; \
date: "2025-10-14"; \
time: "21:15:00"; \
modify: "20251014211500"; \
path: "test.tmp"; \
isDir: False}
*/

$objExpected:=New object:C1471(\
"type"; "file"; \
"size"; 1; \
"date"; "2025-10-14"; \
"time"; "21:15:00"; \
"modify"; "20251014211500"; \
"path"; "test.tmp"; \
"isDir"; False:C215)

ASSERT:C1129(JSON Stringify:C1217($obj)=JSON Stringify:C1217($objExpected))

