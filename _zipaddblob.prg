*!* _zipaddblob

lparameters pblobdata, pzfilepath, pfilecomment, pfiletime

local psfilepath

m.psfilepath = ''

_zipadd('BLOB', m.psfilepath, m.pblobdata, m.pzfilepath, m.pfilecomment, m.pfiletime)


