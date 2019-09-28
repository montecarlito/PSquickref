(get-process).modules | sort-object -Unique |Select-Object modulename #enumerates all DLLs loaded into processes
