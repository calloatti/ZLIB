*!* _zlib.h

#define ZLIB_VERSION			"1.2.8"
#define ZLIB_VERNUM				0x1280
#define ZLIB_VER_MAJOR			1
#define ZLIB_VER_MINOR			2
#define ZLIB_VER_REVISION		8
#define ZLIB_VER_SUBREVISION	0

#Define MAX_WBITS		15

*!* Allowed flush values; see deflate() and inflate() below for details */

#Define Z_NO_FLUSH      0
#Define Z_PARTIAL_FLUSH 1
#Define Z_SYNC_FLUSH    2
#Define Z_FULL_FLUSH    3
#Define Z_FINISH        4
#Define Z_BLOCK         5
#Define Z_TREES         6

*!* Return codes for the compression/decompression functions. Negative values
*!* are errors, positive values are used for special but normal events.

#Define Z_OK			0
#Define Z_STREAM_END	1
#Define Z_NEED_DICT		2
#Define Z_ERRNO			(-1)
#Define Z_STREAM_ERROR	(-2)
#Define Z_DATA_ERROR	(-3)
#Define Z_MEM_ERROR		(-4)
#Define Z_BUF_ERROR		(-5)
#Define Z_VERSION_ERROR	(-6)

*!* compression levels */

#Define Z_NO_COMPRESSION         0
#Define Z_BEST_SPEED             1
#Define Z_BEST_COMPRESSION       9
#Define Z_DEFAULT_COMPRESSION  (-1)

*!* compression strategy; see deflateInit2() below for details */

#Define Z_FILTERED            1
#Define Z_HUFFMAN_ONLY        2
#Define Z_RLE                 3
#Define Z_FIXED               4
#Define Z_DEFAULT_STRATEGY    0

*!* Possible values of the data_type field (though see inflate()) */

#Define Z_BINARY   0
#Define Z_TEXT     1
#Define Z_ASCII    Z_TEXT   && for compatibility with 1.2.2 and earlier */
#Define Z_UNKNOWN  2

*!* The deflate compression method (the only one supported in this version) */

#Define Z_DEFLATED   8

#Define Z_NULL  0  && for initializing zalloc, zfree, opaque */

*!* Maximum value for memLevel in deflateInit2

#Define MAX_MEM_LEVEL 8



