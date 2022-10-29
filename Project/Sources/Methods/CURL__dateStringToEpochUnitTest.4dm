//%attributes = {"invisible":true,"shared":false,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL__dateStringToEpochUnitTest
  //@scope : public
  //@deprecated : no
  //@description : This method runs unit tests for the command CURL_dateStringToEpoch
  //@notes :
  //@example : CURL__dateStringToEpochUnitTest
  //@see :
  //@version : 1.00.00
  //@author : Bruno LEGAY (BLE) - Copyrights A&C Consulting - 2019
  //@history :
  //  CREATION : Bruno LEGAY (BLE) - 19/11/2019, 16:05:25 - 1.00.08
  //@xdoc-end
  //================================================================================

SET ASSERT ENABLED:C1131(True:C214)

C_LONGINT:C283($vl_epoch)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun, 06 Nov 1994 08:49:37 UTC";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun, 06 Nov 1994 08:49:37 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("Sunday, 06-Nov-94 08:49:37 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun Nov  6 08:49:37 1994";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("06-Nov-94 08:49:37 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("Nov  6 08:49:37 1994";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("06-Nov-94 08:49:37";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("1994 Nov 6 08:49:37";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("GMT 08:49:37 06-Nov-94 Sunday";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("94 6 Nov 08:49:37";->$vl_epoch))
ASSERT:C1129($vl_epoch=784111777)

ASSERT:C1129(CURL_dateStringToEpoch ("1994 Nov 6";->$vl_epoch))
ASSERT:C1129($vl_epoch=784080000)

ASSERT:C1129(CURL_dateStringToEpoch ("06-Nov-94";->$vl_epoch))
ASSERT:C1129($vl_epoch=784080000)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun Nov 6 94";->$vl_epoch))
ASSERT:C1129($vl_epoch=784080000)

ASSERT:C1129(CURL_dateStringToEpoch ("1994.Nov.6";->$vl_epoch))
ASSERT:C1129($vl_epoch=784080000)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun/Nov/6/94/GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=784080000)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun, 06 Nov 1994 08:49:37 CET";->$vl_epoch))
ASSERT:C1129($vl_epoch=784108177)

ASSERT:C1129(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37 EST";->$vl_epoch))
ASSERT:C1129($vl_epoch=784129777)

ASSERT:C1129(CURL_dateStringToEpoch ("Sun, 12 Sep 2004 15:05:58 -0700";->$vl_epoch))
ASSERT:C1129($vl_epoch=1095026758)

ASSERT:C1129(CURL_dateStringToEpoch ("Sat, 11 Sep 2004 21:32:11 +0200";->$vl_epoch))
ASSERT:C1129($vl_epoch=1094931131)

ASSERT:C1129(CURL_dateStringToEpoch ("20040912 15:05:58 -0700";->$vl_epoch))
ASSERT:C1129($vl_epoch=1095026758)

ASSERT:C1129(CURL_dateStringToEpoch ("20040911 +0200";->$vl_epoch))
ASSERT:C1129($vl_epoch=1094853600)

  // date older than unix epoch => -1
ASSERT:C1129(CURL_dateStringToEpoch ("31 Dec 1969 23:00:00 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=-1)

  // unix epoch => 0
ASSERT:C1129(CURL_dateStringToEpoch ("01 Jan 1970 00:00:00 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=0)

ASSERT:C1129(CURL_dateStringToEpoch ("01 Jan 1970 00:00:00 UTC";->$vl_epoch))
ASSERT:C1129($vl_epoch=0)

ASSERT:C1129(CURL_dateStringToEpoch ("01 Jan 1970 00:00:01 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=1)

  // unix epoch is GMT/UTC... for CET, epoch is "01 Jan 1970 01:00:00 CET"
ASSERT:C1129(CURL_dateStringToEpoch ("01 Jan 1970 01:00:00 CET";->$vl_epoch))
ASSERT:C1129($vl_epoch=0)

ASSERT:C1129(CURL_dateStringToEpoch ("01 Jan 1970 01:00:01 CET";->$vl_epoch))
ASSERT:C1129($vl_epoch=1)

  // https://en.wikipedia.org/wiki/Year_2038_problem
  // MAXINT (32 bits signed integer)  2 147 483 647
  // 2 147 483 647 / (365*24*60*60) => 68,096

ASSERT:C1129(CURL_dateStringToEpoch ("19 Jan 2038 03:14:07 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=2147483647)  // MAXINT (32 bits signed integer)

ASSERT:C1129(CURL_dateStringToEpoch ("19 Jan 2038 03:14:08 GMT";->$vl_epoch))
ASSERT:C1129($vl_epoch=-2147483648)

