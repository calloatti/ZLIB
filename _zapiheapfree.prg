*!* _zapiheapfree

lparameters hHeap, dwFlags, lpMem

declare integer HeapFree in win32api as _zapiheapfree;
	integer hHeap, ;
	integer dwFlags, ;
	integer lpMem

return _zapiheapfree(m.hHeap, m.dwFlags, m.lpMem)