*!* testzip

Local ofiles As Collection
Local zipfiles As 'collection'
Local cbytes, cfile, fh, lbytes, lnx, ocd, oecdr, olfh, sstart, ubytes, usejustfname, zzhandle

Clear

m.cfile = "C:\VFPPA\CURSE\mods\HarvestTweaks-1.10.2-0.1.2.jar"

m.cfile = "C:\VFPPA\CURSE\mods\MC1.7.10_mcheli_1.0.3.zip"

m.cfile = "\\PC001\MultiMC\instances\IE\minecraft\mods\ViesCraft-1.10.X-4.38.42.jar"

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

m.sstart = Seconds()
m.ofiles = _zlibzipfindfilesincdr(m.lbytes, '*.png')
?Seconds() - m.sstart

For m.lnx = 1 To m.ofiles.Count

	*!*?'zzfilename              ', m.ofiles(m.lnx).zzfilename
	*!*	?'zzsignature             ', m.ofiles(m.lnx).zzsignature
	*!*	?'zzversion1              ', m.ofiles(m.lnx).zzversion1
	*!*	?'zzversion2              ', m.ofiles(m.lnx).zzversion2
	*!*	?'zzversiontoextract      ', m.ofiles(m.lnx).zzversiontoextract
	*!*	?'zzbitflags              ', m.ofiles(m.lnx).zzbitflags
	*!*	?'zzmethod                ', m.ofiles(m.lnx).zzmethod
	*!*	?'zzfiletime              ', m.ofiles(m.lnx).zzfiletime
	*!*	?'zzfiledate              ', m.ofiles(m.lnx).zzfiledate
	*!*	?'zzcrc32                 ', m.ofiles(m.lnx).zzcrc32
	*!*	?'zzcompressedsize        ', m.ofiles(m.lnx).zzcompressedsize
	*!*	?'zzuncompressedsize      ', m.ofiles(m.lnx).zzuncompressedsize
	*!*	?'zzfilenamelen           ', m.ofiles(m.lnx).zzfilenamelen
	*!*	?'zzextrafieldlen         ', m.ofiles(m.lnx).zzextrafieldlen
	*!*	?'zzfilecommentlen        ', m.ofiles(m.lnx).zzfilecommentlen
	*!*	?'zzdisknumstart          ', m.ofiles(m.lnx).zzdisknumstart
	*!*	?'zzinternalfileattributes', m.ofiles(m.lnx).zzinternalfileattributes
	*!*	?'zzexternalfileattributes', m.ofiles(m.lnx).zzexternalfileattributes
	*!*	?'zzoffset                ', m.ofiles(m.lnx).zzoffset
	*!*	?'zzextrafield            ', m.ofiles(m.lnx).zzextrafield
	*!*	?'zzfilecomment           ', m.ofiles(m.lnx).zzfilecomment
	*!*	?'zzsize                  ', m.ofiles(m.lnx).zzsize

Endfor