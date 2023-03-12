//%attributes = {"invisible":true,"shared":false}
SET ASSERT ENABLED:C1131(True:C214)


C_TEXT:C284($vt_path; $vt_pathExpected)
$vt_path:="/A&C livraisons/nightly builds/test.zip"
$vt_pathExpected:="/A%26C%20livraisons/nightly%20builds/test.zip"

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)


$vt_path:=""
$vt_pathExpected:=""

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)

$vt_path:="a"
$vt_pathExpected:="a"

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)

$vt_path:="/"
$vt_pathExpected:="/"

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)



$vt_path:="/A&C livraisons test.zip"
$vt_pathExpected:="/A%26C%20livraisons%20test.zip"

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)

$vt_path:="/A&C livraisons test.zip/"
$vt_pathExpected:="/A%26C%20livraisons%20test.zip/"

ASSERT:C1129(CURL_urlPathEscape($vt_path)=$vt_pathExpected)
