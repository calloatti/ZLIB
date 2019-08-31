*!* _zapifiletimetosystemtime

lparameters lpFileTime, lpSystemTime

declare integer FileTimeToSystemTime in win32api as _zapifiletimetosystemtime;
	string lpFileTime, ;
	string @lpSystemTime

return _zapifiletimetosystemtime(m.lpFileTime, @m.lpSystemTime)