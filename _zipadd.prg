*!* _zipadd

lparameters ptype, psfilepath, pblobdata, pzfilepath, pfilecomment, pfiletime

Local isfile, narea

if empty(m.pblobdata) and m.ptype == 'BLOB'

	error 'BLOB DATA IS EMPTY'

endif

if empty(m.psfilepath) and m.ptype == 'FILE'

	error 'BLOB DATA IS EMPTY'

endif

if empty(m.pzfilepath)

	error 'ZIP PATH IS EMPTY'

endif

if empty(m.pfiletime)

	m.pfiletime = {//::}

endif

if empty(m.pfilecomment)

	m.pfilecomment = ''

endif

m.narea = select()

select 'zip_temp'

*!* IF A ZIP FILE WITH THE SAME NAME ALREADY EXISTS, REPLACE IT

locate for zip_temp.zfilepath == m.pzfilepath

if not found('zip_temp')

	append blank in 'zip_temp'

endif

if right(m.psfilepath, 1) = '\' or directory(m.psfilepath)

	m.isfile = 0

else

	m.isfile = 1

endif

replace ;
		zip_temp.sfilepath with	m.psfilepath, ;
		zip_temp.zfilepath with	m.pzfilepath, ;
		zip_temp.blobdata  with	m.pblobdata, ;
		zip_temp.isfile	   with	m.isfile, ;
		zip_temp.filecmnt  with	m.pfilecomment, ;
		zip_temp.filetime  with	m.pfiletime in 'zip_temp'

_zuselect(m.narea) 