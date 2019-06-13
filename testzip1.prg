*!* testzip

Local cbytes, cfile, fh, lbytes, lnx, ocd, oecdr, ofiles, olfh, ubytes, usejustfname


Clear

m.cfile = "C:\VFPPA\CURSE\mods\HarvestTweaks-1.10.2-0.1.2.jar"

m.cfile = "C:\VFPPA\CURSE\mods\MC1.7.10_mcheli_1.0.3.zip"

m.cfile = "C:\VFPPA\CURSE\mods\RedstoneExtended.zip"

*!* get last 2kb from zip file

m.fh = Fopen(m.cfile, 0)

Fseek(m.fh, -2048, 2)

m.lbytes = Fread(m.fh, 2048)

Fclose(m.fh)

m.oecdr = _zlibzipreadeocdr(m.lbytes)

?'zzfound  ', m.oecdr.zzfound
?'zzcount  ', m.oecdr.zzcount
?'zzsize   ', m.oecdr.zzsize
?'zzoffset ', m.oecdr.zzoffset

If m.oecdr.zzfound = 0

	Return

Endif

*!* get zzsize bytes starting at offset from zip file

m.fh = Fopen(m.cfile, 0)

Fseek(m.fh, m.oecdr.zzoffset, 0)

m.lbytes = Fread(m.fh, m.oecdr.zzsize)

Fclose(m.fh)

*!* get central directory files headers

m.ofiles = _zlibzipfindfilesincdr(m.lbytes, '*.png')

For m.lnx = 1 To m.ofiles.Count

	?'zzfilename              ', m.ofiles(m.lnx).zzfilename
	?'zzsignature             ', m.ofiles(m.lnx).zzsignature
	?'zzversion1              ', m.ofiles(m.lnx).zzversion1
	?'zzversion2              ', m.ofiles(m.lnx).zzversion2
	?'zzversiontoextract      ', m.ofiles(m.lnx).zzversiontoextract
	?'zzbitflags              ', m.ofiles(m.lnx).zzbitflags
	?'zzmethod                ', m.ofiles(m.lnx).zzmethod
	?'zzfiletime              ', m.ofiles(m.lnx).zzfiletime
	?'zzfiledate              ', m.ofiles(m.lnx).zzfiledate
	?'zzcrc32                 ', m.ofiles(m.lnx).zzcrc32
	?'zzcompressedsize        ', m.ofiles(m.lnx).zzcompressedsize
	?'zzuncompressedsize      ', m.ofiles(m.lnx).zzuncompressedsize
	?'zzfilenamelen           ', m.ofiles(m.lnx).zzfilenamelen
	?'zzextrafieldlen         ', m.ofiles(m.lnx).zzextrafieldlen
	?'zzfilecommentlen        ', m.ofiles(m.lnx).zzfilecommentlen
	?'zzdisknumstart          ', m.ofiles(m.lnx).zzdisknumstart
	?'zzinternalfileattributes', m.ofiles(m.lnx).zzinternalfileattributes
	?'zzexternalfileattributes', m.ofiles(m.lnx).zzexternalfileattributes
	?'zzoffset                ', m.ofiles(m.lnx).zzoffset
	?'zzextrafield            ', m.ofiles(m.lnx).zzextrafield
	?'zzfilecomment           ', m.ofiles(m.lnx).zzfilecomment
	?'zzsize                  ', m.ofiles(m.lnx).zzsize

Endfor

Return

*!* GET FILE HEADER + DATA FROM ZIP FILE

m.fh = Fopen(m.cfile, 0)

Fseek(m.fh, m.ocd.zzoffset, 0)

m.lbytes = Fread(m.fh, m.ocd.zzsize)

Fclose(m.fh)

m.olfh = _zlibzipreadlfh(m.lbytes)

?'-------------------------------'
?'zzfilename        ', m.olfh.zzfilename
?'zzsignature       ', m.olfh.zzsignature
?'zzversiontoextract', m.olfh.zzversiontoextract
?'zzbitflags        ', m.olfh.zzbitflags
?'zzmethod          ', m.olfh.zzmethod
?'zzfiletime        ', m.olfh.zzfiletime
?'zzfiledate        ', m.olfh.zzfiledate
?'zzcrc32           ', m.olfh.zzcrc32
?'zzcompressedsize  ', m.olfh.zzcompressedsize
?'zzuncompressedsize', m.olfh.zzuncompressedsize
?'zzfilenamelen     ', m.olfh.zzfilenamelen
?'zzextrafieldlen   ', m.olfh.zzextrafieldlen
?'zzextrafield      ', m.olfh.zzextrafield
?'zzoffset          ', m.olfh.zzoffset


*!* USE CRC32, zzcompressedsize, zzuncompressedsize FROM THE CENTRAL DIRECTORY
*!* SOMETIMES THOSE VALUES ARE NOT STORED IN THE LOCAL FILE HEADER

m.cbytes = Substr(m.lbytes, m.olfh.zzoffset + 1, m.ocd.zzcompressedsize)

If m.olfh.zzmethod = 8

	m.ubytes = _zlibuncompresszip(m.cbytes, m.ocd.zzuncompressedsize, m.ocd.crc32)

Else

	m.ubytes = m.cbytes

Endif

_Cliptext = m.ubytes

