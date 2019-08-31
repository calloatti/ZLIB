*!* _zipclose

*!*	Overall .ZIP file format:
*!* ------------------------------------------------------------------------------------------------------
*!*	[local file header 1]
*!*	[encryption header 1]
*!*	[file data 1]
*!*	[data descriptor 1]
*!*	.
*!*	.
*!*	.
*!*	[local file header n]
*!*	[encryption header n]
*!*	[file data n]
*!*	[data descriptor n]
*!*	[archive decryption header]
*!*	[archive extra data record]
*!*	[central directory header 1]
*!*	.
*!*	.
*!*	.
*!*	[central directory header n]
*!*	[zip64 end of central directory record]
*!*	[zip64 end of central directory locator]
*!*	[end of central directory record]
*!* ------------------------------------------------------------------------------------------------------
*!* Local file header:
*!* ------------------------------------------------------------------------------------------------------
*!*	local file header signature     4 bytes  (0x04034b50)
*!*	version needed to extract       2 bytes
*!*	general purpose bit flag        2 bytes
*!*	compression method              2 bytes
*!*	last mod file time              2 bytes
*!*	last mod file date              2 bytes
*!*	crc - 32                          4 bytes
*!*	compressed size                 4 bytes
*!*	uncompressed size               4 bytes
*!*	file name length                2 bytes
*!*	extra field length              2 bytes
*!*	file name                       variable size
*!*	extra field                     variable size
*!* ------------------------------------------------------------------------------------------------------
*!*	Data descriptor:
*!* ------------------------------------------------------------------------------------------------------
*!*	crc - 32                          4 bytes
*!*	compressed size                 4 bytes
*!*	uncompressed size               4 bytes
*!* ------------------------------------------------------------------------------------------------------
*!*	Central Directory Header:
*!* ------------------------------------------------------------------------------------------------------
*!*	central file header signature   4 bytes  (0x02014b50)
*!*	version made by                 2 bytes
*!*	version needed to extract       2 bytes
*!*	general purpose bit flag        2 bytes
*!*	compression method              2 bytes
*!*	last mod file time              2 bytes
*!*	last mod file date              2 bytes
*!*	crc - 32                          4 bytes
*!*	compressed size                 4 bytes
*!*	uncompressed size               4 bytes
*!*	file name length                2 bytes
*!*	extra field length              2 bytes
*!*	file comment length             2 bytes
*!*	disk number start               2 bytes
*!*	internal file attributes        2 bytes
*!*	external file attributes        4 bytes
*!*	relative offset of local header 4 bytes
*!*	file name                       variable size
*!*	extra field                     variable size
*!*	file comment                    variable size
*!* ------------------------------------------------------------------------------------------------------
*!*	End of central directory record:
*!* ------------------------------------------------------------------------------------------------------
*!*	end of central dir signature                                                   4 bytes  (0x06054b50)
*!*	number of this disk                                                            2 bytes
*!*	number of the disk with the start of the central directory                     2 bytes
*!*	total number of entries in the central directory on this disk                  2 bytes
*!*	total number of entries in the central directory                               2 bytes
*!*	size of the central directory                                                  4 bytes
*!*	offset of start of central directory with respect to the starting disk number  4 bytes
*!*	.ZIP file comment length                                                       2 bytes
*!*	.ZIP file comment                                                              variable size
*!* ------------------------------------------------------------------------------------------------------

*!* version needed to extract
*!* ------------------------------------------------------------------------------------------------------
*!*	The minimum supported ZIP specification version needed to extract the file. The value / 10 indicates the major
*!*	version number, and the value mod 10 is the minor version number.
*!*	1.0 - 0h0A00 Default value
*!*	2.0 - 0h1400 File is compressed using Deflate compression
*!*	6.3 - 0h3F00 File is compressed using LZMA
*!* ------------------------------------------------------------------------------------------------------

*!* external file attributes LINUX (Right 2 bytes. Left 2 bytes are for MSDOS)
*!* ------------------------------------------------------------------------------------------------------
*!*	0x81E40000 for sh files
*!*	0x81A40000 for normal files
*!*	0x41ED0000 for folders
*!* ------------------------------------------------------------------------------------------------------
*!* https://unix.stackexchange.com/questions/14705/the-zip-formats-external-file-attribute
*!* ------------------------------------------------------------------------------------------------------
*!* THE FOLLOWING VALUES ARE OCTAL!!
*!*
*!* #define S_IFDIR  0040000  /* directory */
*!* #define S_IFREG  0100000  /* regular */
*!* PERMISSIONS: 755 folders, 644 other files, 744 sh files

#define EFA_DOS_FOLDER		0x00000010
#define EFA_DOS_FILE		0x00000020
#define EFA_UNIX_FOLDER		0x41ed0000		&& octal 040000  + 0755 << 16
#define EFA_UNIX_FILE		0x81a40000		&& octal 0100000 + 0644 << 16
#define EFA_UNIX_FILE_SH	0x81e40000		&& octal 0100000 + 0744 << 16

#define EFA_FOLDER			(EFA_DOS_FOLDER + EFA_UNIX_FOLDER)
#define EFA_FILE			(EFA_DOS_FILE + EFA_UNIX_FILE)
#define EFA_FILE_SH			(EFA_DOS_FILE + EFA_UNIX_FILE_SH)

lparameters pzipfilename, pzipfilecomment, puselzma

local ozip as 'zip' of '_zip.vcx'
local fcreationtime, flastaccesstime, flastwritetime, hfile, lfhlastmodfiledatetime, narea
local ntfslastmodfiledatetime

m.narea = select()

select * from 'zip_temp' order by zip_temp.zfilepath into cursor 'zip_cursor' readwrite

use in 'zip_temp'

select 'zip_cursor'

m.hfile = fcreate(m.pzipfilename, 0)

if m.hfile < 0 then

	error 'FCREATE ' + m.pzipfilename

endif

m.ozip = newobject('zip', '_zip.vcx')

m.ozip.zipuselzma = m.puselzma

m.ozip.eocdsizeofthecentraldirectory = 0

m.lfhlastmodfiledatetime = datetime()

m.ntfslastmodfiledatetime = _zugetsystemtimeasfiletime()

scan

	wait 'ZIPPING FILES...' window nowait

	m.ozip.cfhfilecomment = zip_cursor.filecmnt

	if not empty(zip_cursor.filetime)

		m.ozip.lfhlastmodfiledatetime = zip_cursor.filetime

	else

		if directory(zip_cursor.sfilepath) or file(zip_cursor.sfilepath)

			m.fcreationtime	  = 0h00000000000000000000000000000000
			m.flastaccesstime = 0h00000000000000000000000000000000
			m.flastwritetime  = 0h00000000000000000000000000000000

			m.ozip.lfhlastmodfiledatetime = _zugetfiletimes(zip_cursor.sfilepath, @m.fcreationtime, @m.flastaccesstime, @m.flastwritetime )

			m.ozip.ntfscreationtime	  = m.fcreationtime
			m.ozip.ntfslastaccesstime = m.flastaccesstime
			m.ozip.ntfslastwritetime  = m.flastwritetime

		else

			m.ozip.lfhlastmodfiledatetime = m.lfhlastmodfiledatetime
			m.ozip.ntfscreationtime		  = m.ntfslastmodfiledatetime
			m.ozip.ntfslastaccesstime	  = m.ntfslastmodfiledatetime
			m.ozip.ntfslastwritetime	  = m.ntfslastmodfiledatetime

		endif

	endif

	if zip_cursor.isfile = 0

		*!* FOLDER

		m.ozip.lfhfilename = chrtran(addbs(zip_cursor.zfilepath), '\', '/')

		m.ozip.lfhuncompressedbytes = ''

		m.ozip.cfhexternalfileattributes = EFA_FOLDER

	else

		*!* FILE

		m.ozip.lfhfilename = chrtran(zip_cursor.zfilepath, '\', '/')

		if not file(zip_cursor.sfilepath) and empty(zip_cursor.blobdata)

			error 'FILE NOT FOUND AND BLOBDATA IS EMPTY'

		endif

		if file(zip_cursor.sfilepath)

			m.ozip.lfhuncompressedbytes = filetostr(zip_cursor.sfilepath)

		else

			m.ozip.lfhuncompressedbytes = zip_cursor.blobdata

		endif

		if lower(justext(zip_cursor.sfilepath)) == 'sh'

			m.ozip.cfhexternalfileattributes = EFA_FILE_SH

		else

			m.ozip.cfhexternalfileattributes = EFA_FILE

		endif

	endif

	*!* SAVE OFFSET OF LOCAL FILE HEADER FOR CENTRAL FILE HEADER

	m.ozip.cfhrelativeoffsetoflocalheader  = fseek(m.hfile, 0, 1)

	*!* WRITE LOCAL FILE HEADER

	fwrite(m.hfile, m.ozip.zipgetlocalfileheader())

	*!* SAVE COMPRESSED FILE DATA

	fwrite(m.hfile, m.ozip.lfhcompressedbytes)

	*!* WRITE DATA DESCRIPTOR

	fwrite(m.hfile, m.ozip.zipgetdatadescriptor())

	m.ozip.eocdtotalnumber = m.ozip.eocdtotalnumber + 1

	*!* SAVE CURRENT CENTRAL FILE HEADER RECORD TO CURSOR

	replace zip_cursor.cfheader with m.ozip.zipgetcentralfileheader() in 'zip_cursor'

	m.ozip.eocdsizeofthecentraldirectory = m.ozip.eocdsizeofthecentraldirectory + len(zip_cursor.cfheader)

endscan

wait clear

*!* SAVE OFFSET OF START OF CENTRAL DIRECTORY

m.ozip.eocdoffsetofstartofcentraldirectory = fseek(m.hfile, 0, 1)

*!* WRITE CENTRAL FILE HEADERS

scan

	fwrite(m.hfile, zip_cursor.cfheader)

endscan

wait clear

*!* WRITE END OF CENTRAL DIRECTORY RECORD

if vartype(m.pzipfilecomment) $ 'CQ'

	m.ozip.eocdzipfilecomment = m.pzipfilecomment

endif

fwrite(m.hfile, m.ozip.zipgeteocdrecord())

fclose(m.hfile)

use in 'zip_cursor'

_zuselect(m.narea)












