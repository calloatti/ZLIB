*!* _zipgeteocdrecord

*!*	end of central dir signature                                                   4 bytes  (0x06054b50)
*!*	number of this disk                                                            2 bytes
*!*	number of the disk with the start of the central directory                     2 bytes
*!*	total number of entries in the central directory on this disk                  2 bytes
*!*	total number of entries in the central directory                               2 bytes
*!*	size of the central directory                                                  4 bytes
*!*	offset of start of central directory with respect to the starting disk number  4 bytes
*!*	.ZIP file comment length                                                       2 bytes
*!*	.ZIP file comment                                                              variable size

#define LOCAL_FILE_HEADER_SIGNATURE   0h504b0304
#define CENTRAL_FILE_HEADER_SIGNATURE 0h504b0102
#define DIGITAL_SIGNATURE             0h504b0505
#define ZIP64_EOCD_SIGNATURE          0h504b0606
#define ZIP64_EOCD_LOCATOR_SIGNATURE  0h504b0607
#define EOCD_SIGNATURE                0h504b0506
#define DATA_DESCRIPTOR_SIGNATURE     0h504b0708

lparameters pfile

local eocd as 'empty'
local bytes, hfile, npos

m.eocd = createobject('empty')

addproperty(m.eocd, 'signature', '')
addproperty(m.eocd, 'numberofthisdisk', '')
addproperty(m.eocd, 'numberofthedisk', '')
addproperty(m.eocd, 'totalnumberonthisdisk', '')
addproperty(m.eocd, 'totalnumber', '')
addproperty(m.eocd, 'sizeofthecentraldirectory', '')
addproperty(m.eocd, 'offsetofstartofcentraldirectory', '')
addproperty(m.eocd, 'zipfilecommentlength', '')
addproperty(m.eocd, 'zipfilecomment', '')
addproperty(m.eocd, 'bytes', '')

m.hfile = fopen(m.pfile, 0)

if m.hfile > 0

	fseek(m.hfile, -8192, 2)

	m.bytes = fread(m.hfile, 8192)

	fclose(m.hfile)

	m.npos = rat(EOCD_SIGNATURE, m.bytes, 1)

	if m.npos > 0 then

		m.eocd.signature					   = 0h + substr(m.bytes, m.npos, 4)
		m.eocd.numberofthisdisk				   = _zuctobin(substr(m.bytes, m.npos + 4, 2))
		m.eocd.numberofthedisk				   = _zuctobin(substr(m.bytes, m.npos + 6, 2))
		m.eocd.totalnumberonthisdisk		   = _zuctobin(substr(m.bytes, m.npos + 8, 2))
		m.eocd.totalnumber					   = _zuctobin(substr(m.bytes, m.npos + 10, 2))
		m.eocd.sizeofthecentraldirectory	   = _zuctobin(substr(m.bytes, m.npos + 12, 4))
		m.eocd.offsetofstartofcentraldirectory = _zuctobin(substr(m.bytes, m.npos + 16, 4))
		m.eocd.zipfilecommentlength			   = _zuctobin(substr(m.bytes, m.npos + 20, 2))

		m.eocd.zipfilecomment= substr(m.bytes, m.npos + 22, m.eocd.zipfilecommentlength)

		m.eocd.bytes= 0h + substr(m.bytes, m.npos, 22) + m.eocd.zipfilecomment

	endif

endif

return m.eocd
