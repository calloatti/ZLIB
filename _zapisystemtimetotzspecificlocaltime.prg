*!* _zapisystemtimetotzspecificlocaltime

lparameters lpTimeZoneInformation, lpUniversalTime, lpLocalTime

declare integer SystemTimeToTzSpecificLocalTime in win32api as _zapisystemtimetotzspecificlocaltime;
	string lpTimeZoneInformation, ;
	string lpUniversalTime, ;
	string @lpLocalTime

return _zapisystemtimetotzspecificlocaltime(m.lpTimeZoneInformation, m.lpUniversalTime, @m.lpLocalTime)