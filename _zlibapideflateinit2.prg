*!* _zlibapideflateinit2

*!*	 This is another version of deflateInit with more compression options.  The
*!*	fields next_in, zalloc, zfree and opaque must be initialized before by the
*!*	caller.

*!*	 The method parameter is the compression method.  It must be Z_DEFLATED in
*!*	this version of the library.

*!*	 The windowBits parameter is the base two logarithm of the window size
*!*	(the size of the history buffer).  It should be in the range 8..15 for this
*!*	version of the library.  Larger values of this parameter result in better
*!*	compression at the expense of memory usage.  The default value is 15 if
*!*	deflateInit is used instead.

*!*	 windowBits can also be -8..-15 for raw deflate.  In this case, -windowBits
*!*	determines the window size.  deflate() will then generate raw deflate data
*!*	with no zlib header or trailer, and will not compute an adler32 check value.

*!*	 windowBits can also be greater than 15 for optional gzip encoding.  Add
*!*	16 to windowBits to write a simple gzip header and trailer around the
*!*	compressed data instead of a zlib wrapper.  The gzip header will have no
*!*	file name, no extra data, no comment, no modification time (set to zero), no
*!*	header crc, and the operating system will be set to 255 (unknown).  If a
*!*	gzip stream is being written, strm->adler is a crc32 instead of an adler32.

*!*	 The memLevel parameter specifies how much memory should be allocated
*!*	for the internal compression state.  memLevel=1 uses minimum memory but is
*!*	slow and reduces compression ratio; memLevel=9 uses maximum memory for
*!*	optimal speed.  The default value is 8.  See zconf.h for total memory usage
*!*	as a function of windowBits and memLevel.

*!*	 The strategy parameter is used to tune the compression algorithm.  Use the
*!*	value Z_DEFAULT_STRATEGY for normal data, Z_FILTERED for data produced by a
*!*	filter (or predictor), Z_HUFFMAN_ONLY to force Huffman encoding only (no
*!*	string match), or Z_RLE to limit match distances to one (run-length
*!*	encoding).  Filtered data consists mostly of small values with a somewhat
*!*	random distribution.  In this case, the compression algorithm is tuned to
*!*	compress them better.  The effect of Z_FILTERED is to force more Huffman
*!*	coding and less string matching; it is somewhat intermediate between
*!*	Z_DEFAULT_STRATEGY and Z_HUFFMAN_ONLY.  Z_RLE is designed to be almost as
*!*	fast as Z_HUFFMAN_ONLY, but give better compression for PNG image data.  The
*!*	strategy parameter only affects the compression ratio but not the
*!*	correctness of the compressed output even if it is not set appropriately.
*!*	Z_FIXED prevents the use of dynamic Huffman codes, allowing for a simpler
*!*	decoder for special applications.

*!*	 deflateInit2 returns Z_OK if success, Z_MEM_ERROR if there was not enough
*!*	memory, Z_STREAM_ERROR if any parameter is invalid (such as an invalid
*!*	method), or Z_VERSION_ERROR if the zlib library version (zlib_version) is
*!*	incompatible with the version assumed by the caller (ZLIB_VERSION).  msg is
*!*	set to null if there is no error message.  deflateInit2 does not perform any
*!*	compression: this will be done by deflate().

*!* int DeflateInit2_(TZStreamRec strm, int level, int method, int windowBits, int memLevel, int strategy, const char * version, int recsize);

Lparameters strm, nlevel, nmethod, windowsbits, memlevel, strategy, zlibversion, stream_size

Declare Integer deflateInit2_ In ZLIB1.Dll As _zlibapideflateinit2 ;
	Integer strm, ;
	Integer nlevel, ;
	Integer nmethod, ;
	Integer windowsbits, ;
	Integer memlevel, ;
	Integer strategy, ;
	String  zlibversion, ;
	Integer stream_size

Return _zlibapideflateinit2(m.strm, m.nlevel, m.nmethod, m.windowsbits, m.memlevel, strategy, m.zlibversion, m.stream_size)