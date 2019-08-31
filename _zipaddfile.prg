* ! * _zipaddfile

lparameters psfilepath, pzfilepath, pfilecomment, pfiletime

local pblobdata

m.pblobdata = ''

_zipadd('FILE', m.psfilepath, m.pblobdata, m.pzfilepath, m.pfilecomment, m.pfiletime)