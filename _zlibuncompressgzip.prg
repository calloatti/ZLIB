*!* _zlibuncompressgzip

*!* UNCOMPRESSES GZIP STRINGS LIKE THE ONES SENT BY WEB SERVERS 
*!* WHEN THE HEADER Accept-Encoding: gzip, deflate IS SENT

*!*	typedef struct z_stream_s {
*!*	    z_const Bytef *next_in;     /* next input byte */
*!*	    uInt     avail_in;  /* number of bytes available at next_in */
*!*	    uLong    total_in;  /* total number of input bytes read so far */

*!*	    Bytef    *next_out; /* next output byte will go here */
*!*	    uInt     avail_out; /* remaining free space at next_out */
*!*	    uLong    total_out; /* total number of bytes output so far */

*!*	    z_const char *msg;  /* last error message, NULL if no error */
*!*	    struct internal_state FAR *state; /* not visible by applications */

*!*	    alloc_func zalloc;  /* used to allocate the internal state */
*!*	    free_func  zfree;   /* used to free the internal state */
*!*	    voidpf     opaque;  /* private data object passed to zalloc and zfree */

*!*	    int     data_type;  /* best guess about the data type: binary or text
*!*	                           for deflate, or the decoding state for inflate */
*!*	    uLong   adler;      /* Adler-32 or CRC-32 value of the uncompressed data */
*!*	    uLong   reserved;   /* reserved for future use */
*!*	} z_stream;

#Include _zlib1.h

#define HEAP_ZERO_MEMORY	8

lparameters pstring

local avail_in, avail_out, heap, next_in, next_out, outstring, result, stream_size, strm, total_out
local windowsbits, zlibversion

if empty(m.pstring) then

	return ''

endif

m.heap = _zapigetprocessheap()

m.avail_in = len(m.pstring)	&& number of bytes available at next_in

m.next_in = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.avail_in)	&& next input byte

sys(2600, m.next_in, m.avail_in, m.pstring) && copy pstring to m.next_in

*!* remaining free space at next_out
m.avail_out	= ctobin(right(m.pstring, 4), '4rs') && len of uncompressed string is stored in last 4 bytes of pstring

*!*  next output byte will go here

m.next_out = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.avail_out)

*!* CREATE A z_stream STRUCTURE AND SET SOME MEMBER VALUES

m.stream_size = 56

m.strm = _zapiheapalloc(m.heap, HEAP_ZERO_MEMORY, m.stream_size)

*!*	00 next_in
*!*	04 avail_in
*!*	08 total_in
*!*	12 next_out
*!*	16 avail_out
*!*	20 total_out
*!*	24 msg
*!*	28 state
*!*	32 zalloc
*!*	36 zfree
*!*	40 opaque
*!*	44 data_type
*!*	48 adler
*!*	52 reserved

sys(2600, m.strm, 4, bintoc(m.next_in, '4rs'))				&& next_in
sys(2600, m.strm + 4, 4, bintoc(m.avail_in, '4rs'))			&& avail_in
sys(2600, m.strm + 12, 4, bintoc(m.next_out, '4rs'))		&& next_out
sys(2600, m.strm + 16, 4, bintoc(m.avail_out, '4rs'))		&& avail_out

*!* windowBits can also be greater than MAX_WBITS for optional gzip decoding. Add 32 to windowBits 
*!* to enable zlib and gzip decoding with automatic header detection

m.windowsbits = MAX_WBITS + 32

m.zlibversion = _zlibapizlibversion()

m.result = _zlibapiinflateinit2(m.strm, m.windowsbits, m.zlibversion, m.stream_size)

if m.result # Z_OK then

	error '_zlibapiinflateinit2:' + transform(m.result)

endif

m.result = _zlibapiinflate(m.strm, Z_FINISH)

if m.result # Z_STREAM_END then

	error '_zlibapiinflate:' + transform(m.result)

endif

m.result = _zlibapiinflateend(m.strm)

if m.result # Z_OK then

	error '_zlibapiinflateend:' + transform(m.result)

endif

m.total_out = ctobin(sys(2600, m.strm + 20, 4), '4rs')

m.outstring = sys(2600, m.next_out, m.total_out)

_zapiheapfree(m.heap, 0, m.strm)

_zapiheapfree(m.heap, 0, m.next_out)

_zapiheapfree(m.heap, 0, m.next_in)

return m.outstring