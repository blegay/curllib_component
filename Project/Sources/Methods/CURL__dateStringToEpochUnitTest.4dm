//%attributes = {"invisible":true,"preemptive":"capable","executedOnServer":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"publishedWeb":false,"published4DMobile":{"scope":"none"},"publishedSoap":false}
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
//C_LONGINT($vl_epoch)
//SET ASSERT ENABLED(True)
//ASSERT(CURL_dateStringToEpoch ("Sun, 06 Nov 1994 08:49:37 GMT";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("Sunday, 06-Nov-94 08:49:37 GMT";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("Sun Nov  6 08:49:37 1994";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37 GMT";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("06-Nov-94 08:49:37 GMT";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("Nov  6 08:49:37 1994";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("06-Nov-94 08:49:37";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("1994 Nov 6 08:49:37";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("GMT 08:49:37 06-Nov-94 Sunday";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("94 6 Nov 08:49:37";->$vl_epoch))
//ASSERT($vl_epoch=784111777)
//ASSERT(CURL_dateStringToEpoch ("1994 Nov 6";->$vl_epoch))
//ASSERT($vl_epoch=784080000)
//ASSERT(CURL_dateStringToEpoch ("06-Nov-94";->$vl_epoch))
//ASSERT($vl_epoch=784080000)
//ASSERT(CURL_dateStringToEpoch ("Sun Nov 6 94";->$vl_epoch))
//ASSERT($vl_epoch=784080000)
//ASSERT(CURL_dateStringToEpoch ("1994.Nov.6";->$vl_epoch))
//ASSERT($vl_epoch=784080000)
//ASSERT(CURL_dateStringToEpoch ("Sun/Nov/6/94/GMT";->$vl_epoch))
//ASSERT($vl_epoch=784080000)
//ASSERT(CURL_dateStringToEpoch ("Sun, 06 Nov 1994 08:49:37 CET";->$vl_epoch))
//ASSERT($vl_epoch=784108177)
//ASSERT(CURL_dateStringToEpoch ("06 Nov 1994 08:49:37 EST";->$vl_epoch))
//ASSERT($vl_epoch=784129777)
//ASSERT(CURL_dateStringToEpoch ("Sun, 12 Sep 2004 15:05:58 -0700";->$vl_epoch))
//ASSERT($vl_epoch=1095026758)
//ASSERT(CURL_dateStringToEpoch ("Sat, 11 Sep 2004 21:32:11 +0200";->$vl_epoch))
//ASSERT($vl_epoch=1094931131)
//ASSERT(CURL_dateStringToEpoch ("20040912 15:05:58 -0700";->$vl_epoch))
//ASSERT($vl_epoch=1095026758)
//ASSERT(CURL_dateStringToEpoch ("20040911 +0200";->$vl_epoch))
//ASSERT($vl_epoch=1094853600)