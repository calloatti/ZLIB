*!* _zipreport

lparameters pfile

local cl, eocd, fileheaders, lines[1], lnx, outfile

m.outfile = forceext(m.pfile, 'txt')

strtofile('', m.outfile)

m.eocd = _zipgeteocdrecord(m.pfile)

strtofile('end of central directory' + 0h0d0a, m.outfile, 1)
strtofile('--------------------------------------------------------------------------------' + 0h0d0a, m.outfile, 1)
strtofile('signature......................: ' + transform(m.eocd.signature) + 0h0d0a, m.outfile, 1)
strtofile('numberofthisdisk...............: ' + transform(m.eocd.numberofthisdisk) + 0h0d0a, m.outfile, 1)
strtofile('numberofthedisk................: ' + transform(m.eocd.numberofthedisk) + 0h0d0a, m.outfile, 1)
strtofile('totalnumberonthisdisk..........: ' + transform(m.eocd.totalnumberonthisdisk) + 0h0d0a, m.outfile, 1)
strtofile('totalnumber....................: ' + transform(m.eocd.totalnumber) + 0h0d0a, m.outfile, 1)
strtofile('sizeofthecentraldirectory......: ' + transform(m.eocd.sizeofthecentraldirectory) + 0h0d0a, m.outfile, 1)
strtofile('offsetofstartofcentraldirectory: ' + transform(m.eocd.offsetofstartofcentraldirectory) + 0h0d0a, m.outfile, 1)
strtofile('zipfilecommentlength...........: ' + transform(m.eocd.zipfilecommentlength) + 0h0d0a, m.outfile, 1)
strtofile('zipfilecomment.................: ' + transform(m.eocd.zipfilecomment) + 0h0d0a, m.outfile, 1)
strtofile('bytes..........................: ' + transform(m.eocd.bytes) + 0h0d0a, m.outfile, 1)
strtofile(0h0d0a0d0a, m.outfile, 1)

m.fileheaders = _zipgetfileheaders(m.pfile)

m.cl = '   #|signatur|' + padr('filename', 100) + '|ver1|ver2|gpbf|cmet|time|date|  crc-32|  compsize|uncompsize|fnlen|eflen|fclen|dsk#s|infa| extattr|lfh offset|extrafield|filecomment'

strtofile(m.cl + 0h0d0a, m.outfile, 1)

strtofile(replicate('-', len(m.cl)) + 0h0d0a, m.outfile, 1)

dimension m.lines[m.fileheaders.count]

for m.lnx = 1 to m.fileheaders.count

	m.lines[m.lnx] = ;
		transform(m.fileheaders.item[m.lnx].cfhsignature) + '|' + ;
		_zushortenpath(m.fileheaders.item[m.lnx].cfhfilename, 100) + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhversionmadeby, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhversiontoextract, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhgeneralpurposebitflag, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhcompressionmethod, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhlastmodfiletime) + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhlastmodfiledate) + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhcrc32, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhcompressedsize, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhuncompressedsize, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhfilenamelength, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhextrafieldlength, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhfilecommentlength, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhdisknumberstart, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhinternalfileattributes) + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhexternalfileattributes) + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhrelativeoffsetoflocalheader, '9999999999') + '|' + ;
		transform(0h + m.fileheaders.item[m.lnx].cfhextrafield) + '|' + ;
		transform(0h + m.fileheaders.item[m.lnx].cfhfilecomment)

endfor

asort(m.lines)

for m.lnx = 1 to m.fileheaders.count

	strtofile(transform(m.lnx, '9999') + '|' + m.lines[m.lnx] + 0h0d0a, m.outfile, 1)

endfor

strtofile('--------------------------------------------------------------------------------' + 0h0d0a, m.outfile, 1)

for m.lnx = 1 to m.fileheaders.count

	m.lines[m.lnx] = ;
		transform(m.fileheaders.item[m.lnx].lfhsignature) + '|' + ;
		padr(strextract(m.fileheaders.item[m.lnx].lfhfilename, '/'), 100) + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhversiontoextract, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhgeneralpurposebitflag, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhcompressionmethod, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhlastmodfiletime) + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhlastmodfiledate) + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhcrc32, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhcompressedsize, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].cfhuncompressedsize, '9999999999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhfilenamelength, '99999') + '|' + ;
		transform(m.fileheaders.item[m.lnx].lfhextrafieldlength, '99999') + '|' + ;
		transform(0h + m.fileheaders.item[m.lnx].lfhextrafield) + '|'

endfor

asort(m.lines)

for m.lnx = 1 to m.fileheaders.count

	strtofile(transform(m.lnx, '9999') + '|' + m.lines[m.lnx] + 0h0d0a, m.outfile, 1)

endfor




