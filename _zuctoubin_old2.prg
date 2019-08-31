*!* _zuctoubinold2

*!* Converts a binary character representation to an unsigned numeric value

lparameters pbytes

local res

m.res = ctobin(m.pbytes, transform(len(m.pbytes)) + 'rs')

if m.res < 0 then

	m.res =  m.res + 2^(len(m.pbytes) * 8)

	m.res = int(m.res)

endif

return m.res

