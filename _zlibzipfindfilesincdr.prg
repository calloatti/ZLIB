*!* _zlibzipfindfilesincdr

*!* finds file in zip central directory

*!* pbytes: string that contains n central directory file headers

*!* pbytes must start at a central file header signature (0h504b0102)

*!* pfilename: name of file to find and return info about
*!* can be fullpath in the form folder1/folder2/filename.ext

*!* returns a collection of file properties objects as stored in the central directory file header

*!* Using zzoffset and zzsize the bytes for the file can be extracted from the zip file and unzipped.
*!* The local file header has to be analyzed to find the actual offset of the compressed
*!* data, since the local file header may not be the same size as the central directory file header 
*!* due to differences in content in file comment and extra field

*!* https://users.cs.jmu.edu/buchhofp/forensics/formats/pkzip.html
*!* https://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT

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

#Define HEAP_ZERO_MEMORY	8

#Define PMSF_NORMAL				0x00000000
#Define PMSF_MULTIPLE			0x00000001
#Define S_OK					0
#Define S_FALSE					1

Lparameters pbytes, pszspec

Local ocd As 'empty'
Local ofiles As 'collection'
Local dwflags, hcdr, heap, npos, nsize, zzextrafieldlen, zzfilecommentlen, zzfilename, zzfilenamelen

If Vartype(m.pszspec) # 'C'

	m.pszspec = '*'

Endif

m.pszspec = Chrtran(m.pszspec, '\', '/')

m.heap = _apigetprocessheap()

m.hcdr = _apiHeapAlloc(m.heap, HEAP_ZERO_MEMORY, Len(m.pbytes))

Sys(2600, m.hcdr, Len(m.pbytes), m.pbytes)

m.npos	= 0

m.nsize	= Len(m.pbytes)

m.ofiles = Createobject('collection')

If ';' $ m.pszspec

	m.dwflags = PMSF_MULTIPLE

Else

	m.dwflags = PMSF_NORMAL

Endif

Do While m.npos < m.nsize

	m.zzfilenamelen	   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 28, 2))
	m.zzfilename	   = Sys(2600, m.hcdr + m.npos + 46, m.zzfilenamelen)
	m.zzextrafieldlen  = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 30, 2))
	m.zzfilecommentlen = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 32, 2))

	Debugout m.zzfilename, m.pszspec, m.dwflags, _apiPathMatchSpecEx(m.zzfilename, m.pszspec, m.dwflags)

	If _apiPathMatchSpecEx(m.zzfilename, m.pszspec, m.dwflags) = S_FALSE

		m.npos = m.npos + 46 + m.zzfilenamelen + m.zzextrafieldlen + m.zzfilecommentlen

		Loop

	Endif

	m.ocd = Createobject('empty')

	AddProperty(m.ocd, 'zzsignature', '')
	AddProperty(m.ocd, 'zzversion1', 0)
	AddProperty(m.ocd, 'zzversion2', 0)
	AddProperty(m.ocd, 'zzversiontoextract', 0)
	AddProperty(m.ocd, 'zzbitflags', 0)
	AddProperty(m.ocd, 'zzmethod', 0)
	AddProperty(m.ocd, 'zzfiletime', '')
	AddProperty(m.ocd, 'zzfiledate', '')
	AddProperty(m.ocd, 'zzcrc32', 0)
	AddProperty(m.ocd, 'zzcompressedsize', 0)
	AddProperty(m.ocd, 'zzuncompressedsize', 0)
	AddProperty(m.ocd, 'zzfilenamelen', 0)
	AddProperty(m.ocd, 'zzextrafieldlen', 0)
	AddProperty(m.ocd, 'zzfilecommentlen', 0)
	AddProperty(m.ocd, 'zzdisknumstart', 0)
	AddProperty(m.ocd, 'zzinternalfileattributes', 0)
	AddProperty(m.ocd, 'zzexternalfileattributes', 0)
	AddProperty(m.ocd, 'zzoffset', 0)
	AddProperty(m.ocd, 'zzfilename', '')
	AddProperty(m.ocd, 'zzextrafield', '')
	AddProperty(m.ocd, 'zzfilecomment', '')
	AddProperty(m.ocd, 'zzsize', 0)

	m.ocd.zzfilenamelen	   = m.zzfilenamelen
	m.ocd.zzfilename	   = m.zzfilename

	m.ocd.zzextrafieldlen  = m.zzextrafieldlen
	m.ocd.zzfilecommentlen = m.zzfilecommentlen

	m.ocd.zzsignature			   = 0h + Sys(2600, m.hcdr + m.npos, 4)
	m.ocd.zzversion1			   = Asc(Sys(2600, m.hcdr + m.npos + 4, 1))
	m.ocd.zzversion2			   = Asc(Sys(2600, m.hcdr + m.npos + 5, 1))
	m.ocd.zzversiontoextract	   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 6, 2))
	m.ocd.zzbitflags			   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 8, 2))
	m.ocd.zzmethod				   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 10, 2))
	m.ocd.zzfiletime			   = 0h + Sys(2600, m.hcdr + m.npos + 12, 2)
	m.ocd.zzfiledate			   = 0h + Sys(2600, m.hcdr + m.npos + 14, 2)
	m.ocd.zzcrc32				   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 16, 4))
	m.ocd.zzcompressedsize		   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 20, 4))
	m.ocd.zzuncompressedsize	   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 24, 4))
	m.ocd.zzdisknumstart		   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 34, 2))
	m.ocd.zzinternalfileattributes = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 36, 2))
	m.ocd.zzexternalfileattributes = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 38, 4))
	m.ocd.zzoffset				   = _zlibctoubin(Sys(2600, m.hcdr + m.npos + 42, 4))
	m.ocd.zzextrafield			   = 0h + Sys(2600, m.hcdr + m.npos + 46 + m.ocd.zzfilenamelen, m.ocd.zzextrafieldlen)
	m.ocd.zzfilecomment			   = Sys(2600, m.hcdr + m.npos + 46 + m.ocd.zzfilenamelen + m.ocd.zzextrafieldlen, m.ocd.zzfilecommentlen)

	*!* calculate aproximate size of local file header + file compressed data

	*!* we assume the local file header is not larger than the central directory file header
	*!* add bytes for data descriptor:
	*!*	crc-32                          4 bytes
	*!*	compressed size                 4 bytes
	*!*	uncompressed size               4 bytes

	*!* ADD SOME BYTES TO ACCOUNT FOR ZIP FILES WITH LARGE EXTRA DATA IN LOCAL FILE HEADER
	
	m.ocd.zzsize = 46 + m.ocd.zzfilenamelen + m.ocd.zzextrafieldlen + m.ocd.zzfilecommentlen + m.ocd.zzcompressedsize + 128

	m.ofiles.Add(m.ocd)

	m.npos = m.npos + 46 + m.ocd.zzfilenamelen + m.ocd.zzextrafieldlen + m.ocd.zzfilecommentlen

Enddo

_apiHeapFree(m.heap, 0, m.hcdr)

Return m.ofiles

