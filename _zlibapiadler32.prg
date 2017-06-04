*!* _zlibapiadler32

*!* Update a running Adler-32 checksum with the bytes buf[0..len-1] and
*!*	 return the updated checksum.  If buf is Z_NULL, this function returns the   
*!*	 required initial value for the checksum.     
*!*	 An Adler-32 checksum is almost as reliable as a CRC32 but can be computed   
*!*	 much faster.

Lparameters adler, buf, nlen

Declare Integer adler32 In ZLIB1.Dll As _zlibapiadler32 ;
	Integer adler, ;
	String  buf, ;
	Integer nlen

Return _zlibapicompress(m.adler, m.buf, m.nlen)
