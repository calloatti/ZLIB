*!* _zlibgetecdrfromfile

#define HEAP_ZERO_MEMORY	8

#define LOCAL_FILE_HEADER_SIGNATURE   0h504b0304
#define CENTRAL_FILE_HEADER_SIGNATURE 0h504b0102
#define DIGITAL_SIGNATURE             0h504b0505
#define ZIP64_EOCD_SIGNATURE          0h504b0606
#define ZIP64_EOCD_LOCATOR_SIGNATURE  0h504b0607
#define EOCD_SIGNATURE                0h504b0506
#define DATA_DESCRIPTOR_SIGNATURE     0h504b0708

*!* central directory file header

*!*	central file header signature   4 bytes	00	(0x02014b50)
*!*	version made by 1               1 bytes	04
*!*	version made by 2               1 bytes	05
*!*	version needed to extract       2 bytes	06
*!*	general purpose bit flag        2 bytes	08
*!*	compression method              2 bytes	10
*!*	last mod file time              2 bytes	12
*!*	last mod file date              2 bytes	14
*!*	crc-32                          4 bytes	16
*!*	compressed size                 4 bytes	20
*!*	uncompressed size               4 bytes	24
*!*	file name length                2 bytes	28
*!*	extra field length              2 bytes	30
*!*	file comment length             2 bytes	32
*!*	disk number start               2 bytes	34
*!*	internal file attributes        2 bytes	36
*!*	external file attributes        4 bytes	38
*!*	relative offset of local header 4 bytes	42
*!*	file name (variable size)				46
*!*	extra field (variable size)
*!*	file comment (variable size)

*!*	local file header signature     4 bytes 00  (0x04034b50)
*!*	version needed to extract       2 bytes 04 
*!*	general purpose bit flag        2 bytes 06
*!*	compression method              2 bytes 08
*!*	last mod file time              2 bytes 10
*!*	last mod file date              2 bytes 12
*!*	crc-32                          4 bytes 14
*!*	compressed size                 4 bytes 18
*!*	uncompressed size               4 bytes 22
*!*	file name length                2 bytes 26
*!*	extra field length              2 bytes 28
*!*	file name (variable size)               30
*!*	extra field (variable size)

lparameters pfile

local zitem as 'empty'
local zitems as 'collection'
local bytes, cdrbytes, cdoffset, cdsize, hcdr, hfile, npos

m.zitems = createobject('collection')

m.hfile = fopen(m.pfile, 0)

if m.hfile > 0

	fseek(m.hfile, -8192, 2)

	m.bytes = fread(m.hfile, 8192)

	*!* GET End of central directory record

	m.npos = rat(EOCD_SIGNATURE, m.bytes, 1)

	if m.npos > 0 then

		m.cdsize   = _zuctobin(substr(m.bytes, m.npos + 12, 4))
		m.cdoffset = _zuctobin(substr(m.bytes, m.npos + 16, 4))

		fseek(m.hfile, m.cdoffset, 0)

		m.cdrbytes = fread(m.hfile, m.cdsize)

		m.hcdr = _zapiheapalloc(_zapigetprocessheap(), HEAP_ZERO_MEMORY, m.cdsize)

		sys(2600, m.hcdr, m.cdsize, m.cdrbytes)

		m.npos	= 0

		do while m.npos < m.cdsize

			m.zitem = createobject('empty')

			addproperty(m.zitem, 'cdfh_signature', '')
			addproperty(m.zitem, 'cdfh_version1', 0)
			addproperty(m.zitem, 'cdfh_version2', 0)
			addproperty(m.zitem, 'cdfh_versiontoextract', 0)
			addproperty(m.zitem, 'cdfh_bitflags', 0)
			addproperty(m.zitem, 'cdfh_method', 0)
			addproperty(m.zitem, 'cdfh_filetime', '')
			addproperty(m.zitem, 'cdfh_filedate', '')
			addproperty(m.zitem, 'cdfh_crc32', 0)
			addproperty(m.zitem, 'cdfh_compressedsize', 0)
			addproperty(m.zitem, 'cdfh_uncompressedsize', 0)
			addproperty(m.zitem, 'cdfh_filenamelen', 0)
			addproperty(m.zitem, 'cdfh_extrafieldlen', 0)
			addproperty(m.zitem, 'cdfh_filecommentlen', 0)
			addproperty(m.zitem, 'cdfh_disknumstart', 0)
			addproperty(m.zitem, 'cdfh_internalfileattributes', 0)
			addproperty(m.zitem, 'cdfh_externalfileattributes', 0)
			addproperty(m.zitem, 'cdfh_offset', 0)
			addproperty(m.zitem, 'cdfh_filename', '')
			addproperty(m.zitem, 'cdfh_extrafield', '')
			addproperty(m.zitem, 'cdfh_filecomment', '')
			addproperty(m.zitem, 'cdfh_size', 0)

			m.zitem.cdfh_signature				= 0h + sys(2600, m.hcdr + m.npos, 4)

			if not m.zitem.cdfh_signature == CENTRAL_FILE_HEADER_SIGNATURE

				error 'CENTRAL_FILE_HEADER_SIGNATURE '

			endif

			m.zitem.cdfh_filenamelen			= _zuctobin(sys(2600, m.hcdr + m.npos + 28, 2))
			m.zitem.cdfh_extrafieldlen			= _zuctobin(sys(2600, m.hcdr + m.npos + 30, 2))
			m.zitem.cdfh_filecommentlen			= _zuctobin(sys(2600, m.hcdr + m.npos + 32, 2))
			m.zitem.cdfh_filename				= sys(2600, m.hcdr + m.npos + 46, m.zitem.cdfh_filenamelen)
			m.zitem.cdfh_version1				= 0h + sys(2600, m.hcdr + m.npos + 4, 1)
			m.zitem.cdfh_version2				= 0h + sys(2600, m.hcdr + m.npos + 5, 1)
			m.zitem.cdfh_versiontoextract		= 0h + sys(2600, m.hcdr + m.npos + 6, 2)
			m.zitem.cdfh_bitflags				= 0h + sys(2600, m.hcdr + m.npos + 8, 2)
			m.zitem.cdfh_method					= 0h + sys(2600, m.hcdr + m.npos + 10, 2)
			m.zitem.cdfh_filetime				= 0h + sys(2600, m.hcdr + m.npos + 12, 2)
			m.zitem.cdfh_filedate				= 0h + sys(2600, m.hcdr + m.npos + 14, 2)
			m.zitem.cdfh_crc32					= _zuctobin(sys(2600, m.hcdr + m.npos + 16, 4))
			m.zitem.cdfh_compressedsize			= _zuctobin(sys(2600, m.hcdr + m.npos + 20, 4))
			m.zitem.cdfh_uncompressedsize		= _zuctobin(sys(2600, m.hcdr + m.npos + 24, 4))
			m.zitem.cdfh_disknumstart			= 0h + sys(2600, m.hcdr + m.npos + 34, 2)
			m.zitem.cdfh_internalfileattributes	= 0h + sys(2600, m.hcdr + m.npos + 36, 2)
			m.zitem.cdfh_externalfileattributes	= 0h + sys(2600, m.hcdr + m.npos + 38, 4)
			m.zitem.cdfh_offset					= _zuctobin(sys(2600, m.hcdr + m.npos + 42, 4))
			m.zitem.cdfh_extrafield				= 0h + sys(2600, m.hcdr + m.npos + 46 + m.zitem.cdfh_filenamelen, m.zitem.cdfh_extrafieldlen)
			m.zitem.cdfh_filecomment			= sys(2600, m.hcdr + m.npos + 46 + m.zitem.cdfh_filenamelen + m.zitem.cdfh_extrafieldlen, m.zitem.cdfh_filecommentlen)

			addproperty(m.zitem, 'lfh_signature', '')
			addproperty(m.zitem, 'lfh_versiontoextract', 0)
			addproperty(m.zitem, 'lfh_bitflags', 0)
			addproperty(m.zitem, 'lfh_method', 0)
			addproperty(m.zitem, 'lfh_filetime', '')
			addproperty(m.zitem, 'lfh_filedate', '')
			addproperty(m.zitem, 'lfh_crc32', 0)
			addproperty(m.zitem, 'lfh_compressedsize', 0)
			addproperty(m.zitem, 'lfh_uncompressedsize', 0)
			addproperty(m.zitem, 'lfh_filenamelen', 0)
			addproperty(m.zitem, 'lfh_extrafieldlen', 0)
			addproperty(m.zitem, 'lfh_filename', '')
			addproperty(m.zitem, 'lfh_extrafield', '')
			addproperty(m.zitem, 'lfh_dataoffset', 0)


			fseek(m.hfile, m.zitem.cdfh_offset, 0)

			m.bytes = fread(m.hfile, 30)

			m.zitem.lfh_signature = 0h + substr(m.bytes, 1, 4)

			if not m.zitem.lfh_signature == LOCAL_FILE_HEADER_SIGNATURE

				error 'LOCAL_FILE_HEADER_SIGNATURE'

			endif

			m.zitem.lfh_versiontoextract = 0h + substr(m.bytes, 1+4, 2)
			m.zitem.lfh_bitflags		 = 0h + substr(m.bytes, 1+6, 2)
			m.zitem.lfh_method			 = 0h + substr(m.bytes, 1+8, 2)
			m.zitem.lfh_filetime		 = 0h + substr(m.bytes, 1+10, 2)
			m.zitem.lfh_filedate		 = 0h + substr(m.bytes, 1+12, 2)
			m.zitem.lfh_crc32			 = _zuctobin(substr(m.bytes, 1+14, 4))
			m.zitem.lfh_compressedsize	 = _zuctobin(substr(m.bytes, 1+18, 4))
			m.zitem.lfh_uncompressedsize = _zuctobin(substr(m.bytes, 1+22, 4))
			m.zitem.lfh_filenamelen		 = _zuctobin(substr(m.bytes, 1+26, 2))
			m.zitem.lfh_extrafieldlen	 = _zuctobin(substr(m.bytes, 1+28, 2))


			m.zitem.lfh_filename   = fread(m.hfile, m.zitem.lfh_filenamelen)
			m.zitem.lfh_extrafield = 0h + fread(m.hfile, m.zitem.lfh_extrafieldlen)
			m.zitem.lfh_dataoffset = m.zitem.cdfh_offset + 30 + m.zitem.lfh_filenamelen + m.zitem.lfh_extrafieldlen

			m.zitems.add(m.zitem)

			m.npos = m.npos + 46 + m.zitem.cdfh_filenamelen + m.zitem.cdfh_extrafieldlen + m.zitem.cdfh_filecommentlen

		enddo

		_zapiheapfree(_zapigetprocessheap(), 0, m.hcdr)

	endif

	fclose(m.hfile)

endif

return m.zitems
