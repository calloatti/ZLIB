*!* _zlibapideflateend

*!*	All dynamically allocated data structures for this stream are freed.
*!*	This function discards any unprocessed input and does not flush any pending
*!*	output.

*!*	deflateEnd returns Z_OK if success, Z_STREAM_ERROR if the
*!*	stream state was inconsistent, Z_DATA_ERROR if the stream was freed
*!*	prematurely (some input or output was discarded).  In the error case, msg
*!*	may be set but then points to a static string (which must not be
*!*	deallocated).

lparameters strm

declare integer deflateEnd in zlib1.dll as _zlibapideflateend ;
	integer strm

return _zlibapideflateend(m.strm)