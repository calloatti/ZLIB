*!* _zugetfiletimes

*!*	BOOL WINAPI GetFileTime(
*!*	  __in       HANDLE hFile,
*!*	  __out_opt  LPFILETIME lpCreationTime,
*!*	  __out_opt  LPFILETIME lpLastAccessTime,
*!*	  __out_opt  LPFILETIME lpLastWriteTime
*!*	);

#define GENERIC_READ				0x80000000
#define OPEN_EXISTING				0x03
#define FILE_ATTRIBUTE_NORMAL		0x80
#define FILE_SHARE_READ				0x01
#define FILE_FLAG_BACKUP_SEMANTICS	0x02000000

lparameters pfile, pcreationtime, plastaccesstime, plastwritetime

m.hfile = _zapicreatefile(m.pfile, GENERIC_READ, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL + FILE_FLAG_BACKUP_SEMANTICS, 0)

m.lastwritetime = datetime(1980, 1, 1, 0, 0, 0)

m.pcreationtime	  = 0h0080D5E19FE7A8010000000000000000
m.plastaccesstime = 0h0080D5E19FE7A8010000000000000000
m.plastwritetime  = 0h0080D5E19FE7A8010000000000000000

if m.hfile > 0 then

	m.result = _zapigetfiletime(m.hfile, @m.pcreationtime, @m.plastaccesstime, @m.plastwritetime)

	_zapiclosehandle(m.hfile)

	if m.result # 0 then

		m.lpsystemtime = 0h00000000000000000000000000000000

		m.result = _zapifiletimetosystemtime(m.plastwritetime, @m.lpsystemtime)

		if m.result # 0 then

			m.lplocaltime = 0h00000000000000000000000000000000

			m.result = _zapisystemtimetotzspecificlocaltime(0, m.lpsystemtime, @m.lplocaltime)

			if m.result # 0 then

				m.yy = _zuctobin(substr(m.lplocaltime, 1, 2))
				m.mm = _zuctobin(substr(m.lplocaltime, 3, 2))
				m.dd = _zuctobin(substr(m.lplocaltime, 7, 2))
				m.hh = _zuctobin(substr(m.lplocaltime, 9, 2))
				m.ms = _zuctobin(substr(m.lplocaltime, 11, 2))
				m.ss = _zuctobin(substr(m.lplocaltime, 13, 2))

				m.lastwritetime = datetime(m.yy, m.mm, m.dd, m.hh, m.ms, m.ss)

			endif

		endif

	endif

endif

return m.lastwritetime





