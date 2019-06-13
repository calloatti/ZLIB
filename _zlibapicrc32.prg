*!* _zlibapicrc32

*!* Update a running Adler-32 checksum with the bytes buf[0..len-1] and
*!*	 return the updated checksum.  If buf is Z_NULL, this function returns the   
*!*	 required initial value for the checksum.     
*!*	 An Adler-32 checksum is almost as reliable as a CRC32 but can be computed   
*!*	 much faster.

Lparameters crc, buf, nlen

Declare Integer crc32 In ZLIB1.Dll As _zlibapicrc32 ;
	Integer crc, ;
	String  buf, ;
	Integer nlen

Return _zlibapicrc32(m.crc, m.buf, m.nlen)
