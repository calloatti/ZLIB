*!* _zipgetfileheaders

#define HEAP_ZERO_MEMORY	8

#define LOCAL_FILE_HEADER_SIGNATURE   0h504b0304
#define CENTRAL_FILE_HEADER_SIGNATURE 0h504b0102
#define DIGITAL_SIGNATURE             0h504b0505
#define ZIP64_EOCD_SIGNATURE          0h504b0606
#define ZIP64_EOCD_LOCATOR_SIGNATURE  0h504b0607
#define EOCD_SIGNATURE                0h504b0506
#define DATA_DESCRIPTOR_SIGNATURE     0h504b0708

lparameters pfile

*!*	central file header signature   4 bytes 04 (0x02014b50)
*!*	version made by                 2 bytes	06
*!*	version needed to extract       2 bytes	08
*!*	general purpose bit flag        2 bytes	10
*!*	compression method              2 bytes	12
*!*	last mod file time              2 bytes	14
*!*	last mod file date              2 bytes	16
*!*	crc-32                          4 bytes	20
*!*	compressed size                 4 bytes	24
*!*	uncompressed size               4 bytes	28
*!*	file name length                2 bytes	30
*!*	extra field length              2 bytes	32
*!*	file comment length             2 bytes	34
*!*	disk number start               2 bytes	36
*!*	internal file attributes        2 bytes	38	
*!*	external file attributes        4 bytes	42
*!*	relative offset of local header 4 bytes	46
*!*	file name                       variable size
*!*	extra field                     variable size
*!*	file comment                    variable size

*!*	local file header signature     4 bytes  (0x04034b50)
*!*	version needed to extract       2 bytes
*!*	general purpose bit flag        2 bytes
*!*	compression method              2 bytes
*!*	last mod file time              2 bytes
*!*	last mod file date              2 bytes
*!*	crc-32                          4 bytes
*!*	compressed size                 4 bytes
*!*	uncompressed size               4 bytes
*!*	file name length                2 bytes
*!*	extra field length              2 bytes
*!*	file name                       variable size
*!*	extra field                     variable size

local fhe as 'empty'
local fileheaders as 'collection'
local bytes, eocd, fh, hfile, lnx

m.fileheaders = createobject('collection')

m.eocd = _zipgeteocdrecord(m.pfile)

?m.eocd.offsetofstartofcentraldirectory

m.hfile = fopen(m.pfile, 0)

if m.hfile > 0

	fseek(m.hfile, m.eocd.offsetofstartofcentraldirectory, 0)

	for m.lnx = 1 to m.eocd.totalnumber

		m.bytes = fread(m.hfile, 46)

		m.fh = createobject('empty')

		addproperty(m.fh, 'cfhsignature', '')
		addproperty(m.fh, 'cfhversionmadeby', '')
		addproperty(m.fh, 'cfhversiontoextract', '')
		addproperty(m.fh, 'cfhgeneralpurposebitflag', '')
		addproperty(m.fh, 'cfhcompressionmethod', '')
		addproperty(m.fh, 'cfhlastmodfiletime', '')
		addproperty(m.fh, 'cfhlastmodfiledate', '')
		addproperty(m.fh, 'cfhcrc32', '')
		addproperty(m.fh, 'cfhcompressedsize', '')
		addproperty(m.fh, 'cfhuncompressedsize', '')
		addproperty(m.fh, 'cfhfilenamelength', '')
		addproperty(m.fh, 'cfhextrafieldlength', '')
		addproperty(m.fh, 'cfhfilecommentlength', '')
		addproperty(m.fh, 'cfhdisknumberstart', '')
		addproperty(m.fh, 'cfhinternalfileattributes', '')
		addproperty(m.fh, 'cfhexternalfileattributes', '')
		addproperty(m.fh, 'cfhrelativeoffsetoflocalheader', '')
		addproperty(m.fh, 'cfhfilename', '')
		addproperty(m.fh, 'cfhextrafield', '')
		addproperty(m.fh, 'cfhfilecomment', '')

		addproperty(m.fh, 'lfhsignature', '')
		addproperty(m.fh, 'lfhversiontoextract', '')
		addproperty(m.fh, 'lfhgeneralpurposebitflag', '')
		addproperty(m.fh, 'lfhcompressionmethod', '')
		addproperty(m.fh, 'lfhlastmodfiletime', '')
		addproperty(m.fh, 'lfhlastmodfiledate', '')
		addproperty(m.fh, 'lfhcrc32', '')
		addproperty(m.fh, 'lfhcompressedsize', '')
		addproperty(m.fh, 'lfhuncompressedsize', '')
		addproperty(m.fh, 'lfhfilenamelength', '')
		addproperty(m.fh, 'lfhextrafieldlength', '')
		addproperty(m.fh, 'lfhfilename', '')
		addproperty(m.fh, 'lfhextrafield', '')

		m.fh.cfhsignature					= 0h + substr(m.bytes, 1, 4)
		m.fh.cfhversionmadeby				= 0h + substr(m.bytes, 5, 2)
		m.fh.cfhversiontoextract			= 0h + substr(m.bytes, 7, 2)
		m.fh.cfhgeneralpurposebitflag		= 0h + substr(m.bytes, 9, 2)
		m.fh.cfhcompressionmethod			= 0h + substr(m.bytes, 11, 2)
		m.fh.cfhlastmodfiletime				= 0h + (substr(m.bytes, 13, 2))
		m.fh.cfhlastmodfiledate				= 0h + (substr(m.bytes, 15, 2))
		m.fh.cfhcrc32						= 0h + substr(m.bytes, 17, 4)
		m.fh.cfhcompressedsize				= _zuctobin(substr(m.bytes, 21, 4))
		m.fh.cfhuncompressedsize			= _zuctobin(substr(m.bytes, 25, 4))
		m.fh.cfhfilenamelength				= _zuctobin(substr(m.bytes, 29, 2))
		m.fh.cfhextrafieldlength			= _zuctobin(substr(m.bytes, 31, 2))
		m.fh.cfhfilecommentlength			= _zuctobin(substr(m.bytes, 33, 2))
		m.fh.cfhdisknumberstart				= _zuctobin(substr(m.bytes, 35, 2))
		m.fh.cfhinternalfileattributes		= 0h + substr(m.bytes, 37, 2)
		m.fh.cfhexternalfileattributes		= 0h + substr(m.bytes, 39, 4)
		m.fh.cfhrelativeoffsetoflocalheader	= _zuctobin(substr(m.bytes, 43, 4))

		m.fh.cfhfilename	= fread(m.hfile, m.fh.cfhfilenamelength)
		m.fh.cfhextrafield	= 0h + fread(m.hfile, m.fh.cfhextrafieldlength)
		m.fh.cfhfilecomment	= 0h + fread(m.hfile, m.fh.cfhfilecommentlength)

		m.fileheaders.add(m.fh)

	endfor

	for m.lnx = 1 to m.eocd.totalnumber

		m.fh = m.fileheaders.item[m.lnx]

		fseek(m.hfile, m.fh.cfhrelativeoffsetoflocalheader, 0)

		m.bytes = fread(m.hfile, 30)

		m.fh.lfhsignature			  = 0h + substr(m.bytes, 1, 4)
		m.fh.lfhversiontoextract	  = 0h + substr(m.bytes, 5, 2)
		m.fh.lfhgeneralpurposebitflag = 0h + substr(m.bytes, 7, 2)
		m.fh.lfhcompressionmethod	  = 0h + substr(m.bytes, 9, 2)
		m.fh.lfhlastmodfiletime		  = 0h + substr(m.bytes, 11, 2)
		m.fh.lfhlastmodfiledate		  = 0h + substr(m.bytes, 13, 2)
		m.fh.lfhcrc32				  = 0h + substr(m.bytes, 15, 4)
		m.fh.lfhcompressedsize		  = _zuctobin(substr(m.bytes, 19, 4))
		m.fh.lfhuncompressedsize	  = _zuctobin(substr(m.bytes, 23, 4))
		m.fh.lfhfilenamelength		  = _zuctobin(substr(m.bytes, 27, 2))
		m.fh.lfhextrafieldlength	  = _zuctobin(substr(m.bytes, 29, 2))

		m.fh.lfhfilename   = fread(m.hfile, m.fh.lfhfilenamelength)
		m.fh.lfhextrafield = 0h + fread(m.hfile, m.fh.lfhextrafieldlength)

	endfor

	fclose(m.hfile)

endif

return m.fileheaders