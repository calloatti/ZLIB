*!* _zuctobinold1

*!* CONVERTS LITTLE ENDIAN 4 BYTE STRING TO UNSIGNED INTEGER. RANGE 0x00000000 TO 0xffffffff

lparameters pbin

m.pbin = padr(m.pbin, 4, chr(0))

return asc(substr(m.pbin, 4, 1)) * 0x1000000 + asc(substr(m.pbin, 3, 1)) * 0x10000 + asc(substr(m.pbin, 2, 1)) * 0x100 + asc(substr(m.pbin, 1, 1))


