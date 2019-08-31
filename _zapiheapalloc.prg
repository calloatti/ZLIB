*!* _zapiheapalloc

lparameters hHeap, dwFlags, dwBytes

declare integer HeapAlloc in win32api as _zapiheapalloc ;
	integer hHeap, ;
	integer dwFlags, ;
	integer dwBytes

return _zapiheapalloc(m.hHeap, m.dwFlags, m.dwBytes)