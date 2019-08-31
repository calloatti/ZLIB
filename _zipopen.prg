*!* _zipopen

local narea

m.narea = select()

create cursor 'zip_temp' (sfilepath v(254), zfilepath v(254), blobdata w, filetime t, filecmnt w, isfile i, cfheader w)

_zuselect(m.narea)