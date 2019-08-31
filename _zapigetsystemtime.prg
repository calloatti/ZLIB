*!* _zapigetsystemtime
*!*
*!*	typedef struct _SYSTEMTIME {
*!*	  WORD wYear;
*!*	  WORD wMonth;
*!*	  WORD wDayOfWeek;
*!*	  WORD wDay;
*!*	  WORD wHour;
*!*	  WORD wMinute;
*!*	  WORD wSecond;
*!*	  WORD wMilliseconds;
*!*	} SYSTEMTIME, *PSYSTEMTIME;
*!*
lparameters lpSystemTime

declare integer GetSystemTime in WIN32API as _zapigetsystemtime;
	string  @lpSystemTime

return _zapigetsystemtime(@m.lpSystemTime)