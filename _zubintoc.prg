*!* _zubintoc

*!* CONVERTS UNSIGNED value TO LITTLE ENDIAN 1/2/4 BYTE STRING.
*!* RANGE 0x0 TO 0xff
*!* RANGE 0x0 TO 0xffff
*!* RANGE 0x0 TO 0xffffffff

lparameters pnum, plen

if vartype(m.plen) # 'N'

	m.plen = 4

endif

do case

case m.plen = 1

	if m.pnum > 0xff or m.pnum < -0x80  then

		error 11

	endif

	if m.pnum < 0 then

		m.pnum = m.pnum + 0x100

	endif

	m.cret = chr(bitand(m.pnum, 0x000000FF))

case m.plen = 2

	if m.pnum > 0xffff or m.pnum < -0x8000  then

		error 11

	endif

	if m.pnum < 0 then

		m.pnum = m.pnum + 0x10000

	endif

	m.cret = chr(bitand(m.pnum, 0x000000FF)) + chr(bitrshift(bitand(m.pnum, 0x0000FF00), 8))

otherwise

	if m.pnum > 0xffffffff or m.pnum < -0x80000000  then

		error 11

	endif

	if m.pnum < 0 then

		m.pnum = m.pnum + 0x100000000

	endif

	m.cret = chr(bitand(m.pnum, 0x000000FF)) + chr(bitrshift(bitand(m.pnum, 0x0000FF00), 8)) + chr(bitrshift(bitand(m.pnum, 0x00FF0000), 16)) + chr(bitrshift(bitand(m.pnum, 0xFF000000), 24))

endcase

return m.cret







