//%attributes = {"shared":true,"preemptive":"capable","invisible":false}
  //================================================================================
  //@xdoc-start : en
  //@name : CURL_errorToText
  //@scope : public
  //@deprecated : no
  //@description : This function returns a text error code from an error message
  //@parameter[0-OUT-errorCode-TEXT] : error code
  //@parameter[1-IN-error-LONGINT] : error number
  //@notes : 
  //@example : CURL_errorToText(58) => "CURLE_SSL_CERTPROBLEM (58) : problem with the local client certificate."
  //@see : 
  //  https://curl.haxx.se/libcurl/c/libcurl-errors.html
  //@version : 1.00.00
  //@author : 
  //@history : 
  //  CREATION : Bruno LEGAY (BLE) - 26/09/2017, 17:53:35 - 1.00.00
  //@xdoc-end
  //================================================================================

C_TEXT:C284($0;$vt_errorMessage)
C_LONGINT:C283($1;$vl_error)

ASSERT:C1129(Count parameters:C259>0;"require 1 parameter")
$vl_error:=$1

EXECUTE METHOD:C1007("CURL__init")

C_TEXT:C284($vt_errorCode;$vt_errorDetail)

Case of 
	: ($vl_error=0)
		$vt_errorCode:="OK"
		
	: ($vl_error=1)
		$vt_errorCode:="CURLE_UNSUPPORTED_PROTOCOL"
		$vt_errorDetail:="The URL you passed to libcurl used a protocol that this libcurl does not support. The support might be a compile-time option that you didn't use, it can be a misspelled protocol string or just a protocol libcurl has no code for."
		
	: ($vl_error=2)
		$vt_errorCode:="CURLE_FAILED_INIT"
		$vt_errorDetail:="Very early initialization code failed. This is likely to be an internal error or problem, or a resource problem where something fundamental couldn't get done at init time."
		
	: ($vl_error=3)
		$vt_errorCode:="CURLE_URL_MALFORMAT"
		$vt_errorDetail:="The URL was not properly formatted."
		
	: ($vl_error=4)
		$vt_errorCode:="CURLE_NOT_BUILT_IN"
		$vt_errorDetail:="A requested feature, protocol or option was not found built-in in this libcurl due to a build-time decision. This means that a feature or option was not enabled or explicitly disabled when libcurl was built and in order to get it to function you have "+"to get a rebuilt libcurl."
		
	: ($vl_error=5)
		$vt_errorCode:="CURLE_COULDNT_RESOLVE_PROXY"
		$vt_errorDetail:="Couldn't resolve proxy. The given proxy host could not be resolved."
		
	: ($vl_error=6)
		$vt_errorCode:="CURLE_COULDNT_RESOLVE_HOST"
		$vt_errorDetail:="Couldn't resolve host. The given remote host was not resolved."
		
	: ($vl_error=7)
		$vt_errorCode:="CURLE_COULDNT_CONNECT"
		$vt_errorDetail:="Failed to connect() to host or proxy."
		
	: ($vl_error=8)
		$vt_errorCode:="CURLE_FTP_WEIRD_SERVER_REPLY"
		$vt_errorDetail:="The server sent data libcurl couldn't parse. This error code was known as as CURLE_FTP_WEIRD_SERVER_REPLY before 7.51.0."
		
	: ($vl_error=9)
		$vt_errorCode:="CURLE_REMOTE_ACCESS_DENIED"
		$vt_errorDetail:="We were denied access to the resource given in the URL. For FTP, this occurs while trying to change to the remote directory."
		
	: ($vl_error=10)
		$vt_errorCode:="CURLE_FTP_ACCEPT_FAILED"
		$vt_errorDetail:="While waiting for the server to connect back when an active FTP session is used, an error code was sent over the control connection or similar."
		
	: ($vl_error=11)
		$vt_errorCode:="CURLE_FTP_WEIRD_PASS_REPLY"
		$vt_errorDetail:="After having sent the FTP password to the server, libcurl expects a proper reply. This error code indicates that an unexpected code was returned."
		
	: ($vl_error=12)
		$vt_errorCode:="CURLE_FTP_ACCEPT_TIMEOUT"
		$vt_errorDetail:="During an active FTP session while waiting for the server to connect, the CURLOPT_ACCEPTTIMEOUT_MS (or the internal default) timeout expired."
		
	: ($vl_error=13)
		$vt_errorCode:="CURLE_FTP_WEIRD_PASV_REPLY"
		$vt_errorDetail:="libcurl failed to get a sensible result back from the server as a response to either a PASV or a EPSV command. The server is flawed."
		
	: ($vl_error=14)
		$vt_errorCode:="CURLE_FTP_WEIRD_227_FORMAT"
		$vt_errorDetail:="FTP servers return a 227-line as a response to a PASV command. If libcurl fails to parse that line, this return code is passed back."
		
	: ($vl_error=15)
		$vt_errorCode:="CURLE_FTP_CANT_GET_HOST"
		$vt_errorDetail:="An internal failure to lookup the host used for the new connection."
		
	: ($vl_error=16)
		$vt_errorCode:="CURLE_HTTP2"
		$vt_errorDetail:="A problem was detected in the HTTP2 framing layer. This is somewhat generic and can be one out of several problems, see the error buffer for details."
		
	: ($vl_error=17)
		$vt_errorCode:="CURLE_FTP_COULDNT_SET_TYPE"
		$vt_errorDetail:="Received an error when trying to set the transfer mode to binary or ASCII."
		
	: ($vl_error=18)
		$vt_errorCode:="CURLE_PARTIAL_FILE"
		$vt_errorDetail:="A file transfer was shorter or larger than expected. This happens when the server first reports an expected transfer size, and then delivers data that doesn't match the previously given size."
		
	: ($vl_error=19)
		$vt_errorCode:="CURLE_FTP_COULDNT_RETR_FILE"
		$vt_errorDetail:="This was either a weird reply to a 'RETR' command or a zero byte transfer complete."
		
	: ($vl_error=21)
		$vt_errorCode:="CURLE_QUOTE_ERROR"
		$vt_errorDetail:="When sending custom \"QUOTE\" commands to the remote server, one of the commands returned an error code that was 400 or higher (for FTP) or otherwise indicated unsuccessful completion of the command."
		
	: ($vl_error=22)
		$vt_errorCode:="CURLE_HTTP_RETURNED_ERROR"
		$vt_errorDetail:="This is returned if CURLOPT_FAILONERROR is set TRUE and the HTTP server returns an error code that is >= 400."
		
	: ($vl_error=23)
		$vt_errorCode:="CURLE_WRITE_ERROR"
		$vt_errorDetail:="An error occurred when writing received data to a local file, or an error was returned to libcurl from a write callback."
		
	: ($vl_error=25)
		$vt_errorCode:="CURLE_UPLOAD_FAILED"
		$vt_errorDetail:="Failed starting the upload. For FTP, the server typically denied the STOR command. The error buffer usually contains the server's explanation for this."
		
	: ($vl_error=26)
		$vt_errorCode:="CURLE_READ_ERROR"
		$vt_errorDetail:="There was a problem reading a local file or an error returned by the read callback."
		
	: ($vl_error=27)
		$vt_errorCode:="CURLE_OUT_OF_MEMORY"
		$vt_errorDetail:="A memory allocation request failed. This is serious badness and things are severely screwed up if this ever occurs."
		
	: ($vl_error=28)
		$vt_errorCode:="CURLE_OPERATION_TIMEDOUT"
		$vt_errorDetail:="Operation timeout. The specified time-out period was reached according to the conditions."
		
	: ($vl_error=30)
		$vt_errorCode:="CURLE_FTP_PORT_FAILED"
		$vt_errorDetail:="The FTP PORT command returned error. This mostly happens when you haven't specified a good enough address for libcurl to use. See CURLOPT_FTPPORT."
		
	: ($vl_error=31)
		$vt_errorCode:="CURLE_FTP_COULDNT_USE_REST"
		$vt_errorDetail:="The FTP REST command returned error. This should never happen if the server is sane."
		
	: ($vl_error=33)
		$vt_errorCode:="CURLE_RANGE_ERROR"
		$vt_errorDetail:="The server does not support or accept range requests."
		
	: ($vl_error=34)
		$vt_errorCode:="CURLE_HTTP_POST_ERROR"
		$vt_errorDetail:="This is an odd error that mainly occurs due to internal confusion."
		
	: ($vl_error=35)
		$vt_errorCode:="CURLE_SSL_CONNECT_ERROR"
		$vt_errorDetail:="A problem occurred somewhere in the SSL/TLS handshake. You really want the error buffer and read the message there as it pinpoints the problem slightly more. Could be certificates (file formats, paths, permissions), passwords, and others."
		
	: ($vl_error=36)
		$vt_errorCode:="CURLE_BAD_DOWNLOAD_RESUME"
		$vt_errorDetail:="The download could not be resumed because the specified offset was out of the file boundary."
		
	: ($vl_error=37)
		$vt_errorCode:="CURLE_FILE_COULDNT_READ_FILE"
		$vt_errorDetail:="A file given with FILE:// couldn't be opened. Most likely because the file path doesn't identify an existing file. Did you check file permissions?"
		
	: ($vl_error=38)
		$vt_errorCode:="CURLE_LDAP_CANNOT_BIND"
		$vt_errorDetail:="LDAP cannot bind. LDAP bind operation failed."
		
	: ($vl_error=39)
		$vt_errorCode:="CURLE_LDAP_SEARCH_FAILED"
		$vt_errorDetail:="LDAP search failed."
		
	: ($vl_error=41)
		$vt_errorCode:="CURLE_FUNCTION_NOT_FOUND"
		$vt_errorDetail:="Function not found. A required zlib function was not found."
		
	: ($vl_error=42)
		$vt_errorCode:="CURLE_ABORTED_BY_CALLBACK"
		$vt_errorDetail:="Aborted by callback. A callback returned \"abort\" to libcurl."
		
	: ($vl_error=43)
		$vt_errorCode:="CURLE_BAD_FUNCTION_ARGUMENT"
		$vt_errorDetail:="A function was called with a bad parameter."
		
	: ($vl_error=45)
		$vt_errorCode:="CURLE_INTERFACE_FAILED"
		$vt_errorDetail:="Interface error. A specified outgoing interface could not be used. Set which interface to use for outgoing connections' source IP address with CURLOPT_INTERFACE."
		
	: ($vl_error=47)
		$vt_errorCode:="CURLE_TOO_MANY_REDIRECTS"
		$vt_errorDetail:="Too many redirects. When following redirects, libcurl hit the maximum amount. Set your limit with CURLOPT_MAXREDIRS."
		
	: ($vl_error=48)
		$vt_errorCode:="CURLE_UNKNOWN_OPTION"
		$vt_errorDetail:="An option passed to libcurl is not recognized/known. Refer to the appropriate documentation. This is most likely a problem in the program that uses libcurl. The error buffer might contain more specific information about which exact option it concerns."
		
	: ($vl_error=49)
		$vt_errorCode:="CURLE_TELNET_OPTION_SYNTAX"
		$vt_errorDetail:="A telnet option string was Illegally formatted."
		
	: ($vl_error=51)
		$vt_errorCode:="CURLE_PEER_FAILED_VERIFICATION"
		$vt_errorDetail:="The remote server's SSL certificate or SSH md5 fingerprint was deemed not OK."
		  // see error 60
		
	: ($vl_error=52)
		$vt_errorCode:="CURLE_GOT_NOTHING"
		$vt_errorDetail:="Nothing was returned from the server, and under the circumstances, getting nothing is considered an error."
		
	: ($vl_error=53)
		$vt_errorCode:="CURLE_SSL_ENGINE_NOTFOUND"
		$vt_errorDetail:="The specified crypto engine wasn't found."
		
	: ($vl_error=54)
		$vt_errorCode:="CURLE_SSL_ENGINE_SETFAILED"
		$vt_errorDetail:="Failed setting the selected SSL crypto engine as default!"
		
	: ($vl_error=55)
		$vt_errorCode:="CURLE_SEND_ERROR"
		$vt_errorDetail:="Failed sending network data."
		
	: ($vl_error=56)
		$vt_errorCode:="CURLE_RECV_ERROR"
		$vt_errorDetail:="Failure with receiving network data."
		
	: ($vl_error=58)
		$vt_errorCode:="CURLE_SSL_CERTPROBLEM"
		$vt_errorDetail:="problem with the local client certificate."
		
	: ($vl_error=59)
		$vt_errorCode:="CURLE_SSL_CIPHER"
		$vt_errorDetail:="Couldn't use specified cipher."
		
	: ($vl_error=60)
		  //$vt_errorCode:="CURLE_SSL_CACERT"
		$vt_errorCode:="CURLE_PEER_FAILED_VERIFICATION"
		$vt_errorDetail:="The remote server's SSL certificate or SSH md5 fingerprint was deemed not OK."
		  // This error code has been unified with CURLE_SSL_CACERT since 7.62.0. Its previous value was 51.
		
	: ($vl_error=61)
		$vt_errorCode:="CURLE_BAD_CONTENT_ENCODING"
		$vt_errorDetail:="Unrecognized transfer encoding."
		
	: ($vl_error=62)
		$vt_errorCode:="CURLE_LDAP_INVALID_URL"
		$vt_errorDetail:="Invalid LDAP URL."
		
	: ($vl_error=63)
		$vt_errorCode:="CURLE_FILESIZE_EXCEEDED"
		$vt_errorDetail:="Maximum file size exceeded."
		
	: ($vl_error=64)
		$vt_errorCode:="CURLE_USE_SSL_FAILED"
		$vt_errorDetail:="Requested FTP SSL level failed."
		
	: ($vl_error=65)
		$vt_errorCode:="CURLE_SEND_FAIL_REWIND"
		$vt_errorDetail:="When doing a send operation curl had to rewind the data to retransmit, but the rewinding operation failed."
		
	: ($vl_error=66)
		$vt_errorCode:="CURLE_SSL_ENGINE_INITFAILED"
		$vt_errorDetail:="Initiating the SSL Engine failed."
		
	: ($vl_error=67)
		$vt_errorCode:="CURLE_LOGIN_DENIED"
		$vt_errorDetail:="The remote server denied curl to login."  //"(Added in 7.13.1)"
		
	: ($vl_error=68)
		$vt_errorCode:="CURLE_TFTP_NOTFOUND"
		$vt_errorDetail:="File not found on TFTP server."
		
	: ($vl_error=69)
		$vt_errorCode:="CURLE_TFTP_PERM"
		$vt_errorDetail:="Permission problem on TFTP server."
		
	: ($vl_error=70)
		$vt_errorCode:="CURLE_REMOTE_DISK_FULL"
		$vt_errorDetail:="Out of disk space on the server."
		
	: ($vl_error=71)
		$vt_errorCode:="CURLE_TFTP_ILLEGAL"
		$vt_errorDetail:="Illegal TFTP operation."
		
	: ($vl_error=72)
		$vt_errorCode:="CURLE_TFTP_UNKNOWNID"
		$vt_errorDetail:="Unknown TFTP transfer ID."
		
	: ($vl_error=73)
		$vt_errorCode:="CURLE_REMOTE_FILE_EXISTS"
		$vt_errorDetail:="File already exists and will not be overwritten."
		
	: ($vl_error=74)
		$vt_errorCode:="CURLE_TFTP_NOSUCHUSER"
		$vt_errorDetail:="This error should never be returned by a properly functioning TFTP server."
		
	: ($vl_error=75)
		$vt_errorCode:="CURLE_CONV_FAILED"
		$vt_errorDetail:="Character conversion failed."
		
	: ($vl_error=76)
		$vt_errorCode:="CURLE_CONV_REQD"
		$vt_errorDetail:="Caller must register conversion callbacks."
		
	: ($vl_error=77)
		$vt_errorCode:="CURLE_SSL_CACERT_BADFILE"
		$vt_errorDetail:="Problem with reading the SSL CA cert (path? access rights?)"
		
	: ($vl_error=78)
		$vt_errorCode:="CURLE_REMOTE_FILE_NOT_FOUND"
		$vt_errorDetail:="The resource referenced in the URL does not exist."
		
	: ($vl_error=79)
		$vt_errorCode:="CURLE_SSH"
		$vt_errorDetail:="An unspecified error occurred during the SSH session."
		
	: ($vl_error=80)
		$vt_errorCode:="CURLE_SSL_SHUTDOWN_FAILED"
		$vt_errorDetail:="Failed to shut down the SSL connection."
		
	: ($vl_error=81)
		$vt_errorCode:="CURLE_AGAIN"
		$vt_errorDetail:="Socket is not ready for send/recv wait till it's ready and try again. This return code is only returned from curl_easy_recv and curl_easy_send."  // (Added in 7.18.2)
		
	: ($vl_error=82)
		$vt_errorCode:="CURLE_SSL_CRL_BADFILE"
		$vt_errorDetail:="Failed to load CRL file."  // (Added in 7.19.0)"
		
	: ($vl_error=83)
		$vt_errorCode:="CURLE_SSL_ISSUER_ERROR"
		$vt_errorDetail:="Issuer check failed."  // (Added in 7.19.0)"
		
	: ($vl_error=84)
		$vt_errorCode:="CURLE_FTP_PRET_FAILED"
		$vt_errorDetail:="The FTP server does not understand the PRET command at all or does not support the given argument. Be careful when using CURLOPT_CUSTOMREQUEST, a custom LIST command will be sent with PRET CMD before PASV as well."  // (Added in 7.20.0)"
		
	: ($vl_error=85)
		$vt_errorCode:="CURLE_RTSP_CSEQ_ERROR"
		$vt_errorDetail:="Mismatch of RTSP CSeq numbers."
		
	: ($vl_error=86)
		$vt_errorCode:="CURLE_RTSP_SESSION_ERROR"
		$vt_errorDetail:="Mismatch of RTSP Session Identifiers."
		
	: ($vl_error=87)
		$vt_errorCode:="CURLE_FTP_BAD_FILE_LIST"
		$vt_errorDetail:="Unable to parse FTP file list (during FTP wildcard downloading)."
		
	: ($vl_error=88)
		$vt_errorCode:="CURLE_CHUNK_FAILED"
		$vt_errorDetail:="Chunk callback reported error."
		
	: ($vl_error=89)
		$vt_errorCode:="CURLE_NO_CONNECTION_AVAILABLE"
		$vt_errorDetail:="(For internal use only, will never be returned by libcurl) No connection available, the session will be queued."  // (added in 7.30.0)"
		
	: ($vl_error=90)
		$vt_errorCode:="CURLE_SSL_PINNEDPUBKEYNOTMATCH"
		$vt_errorDetail:="Failed to match the pinned key specified with CURLOPT_PINNEDPUBLICKEY."
		
	: ($vl_error=91)
		$vt_errorCode:="CURLE_SSL_INVALIDCERTSTATUS"
		$vt_errorDetail:="Status returned failure when asked with CURLOPT_SSL_VERIFYSTATUS."
		
	: ($vl_error=92)
		$vt_errorCode:="CURLE_HTTP2_STREAM"
		$vt_errorDetail:="Stream error in the HTTP/2 framing layer."
		
	: ($vl_error=93)
		$vt_errorCode:="CURLE_RECURSIVE_API_CALL"
		$vt_errorDetail:="An API function was called from inside a callback."
		
	: ($vl_error=94)
		$vt_errorCode:="CURLE_AUTH_ERROR"
		$vt_errorDetail:="An authentication function returned an error."
		
	: ($vl_error=95)
		$vt_errorCode:="CURLE_HTTP3"
		$vt_errorDetail:="A problem was detected in the HTTP/3 layer. This is somewhat generic and can be one out of several problems, see the error buffer for details."
		
	: ($vl_error=95)
		$vt_errorCode:="CURLE_QUIC_CONNECT_ERROR"
		$vt_errorDetail:="QUIC connection error. This error may be caused by an SSL library error. QUIC is the protocol used for HTTP/3 transfers."
		
	Else 
		$vt_errorCode:="UNKNOWN_ERROR"
		$vt_errorDetail:="???"
End case 

If ($vl_error=0)
	$vt_errorMessage:=$vt_errorCode  // "OK"
Else 
	$vt_errorMessage:=$vt_errorCode+" ("+String:C10($vl_error)+") : "+$vt_errorDetail
End if 

$0:=$vt_errorMessage
