'From Cuis 4.1 of 12 December 2012 [latest update: #1576] on 23 January 2013 at 8:49:32 pm'!
!classDefinition: #Win32Utils category: #'FFI-Win32-Examples'!
Object subclass: #Win32Utils
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Win32-Examples'!
!Win32Utils commentStamp: '<historical>' prior: 0!
This is an utility class with helpfull methods for Win32 users. Note that it uses FFI and is platform dependent.!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Win32Utils class' category: #'FFI-Win32-Examples'!
Win32Utils class
	instanceVariableNames: ''!

!Win32Utils class methodsFor: 'accessing' stamp: 'mtf 12/31/2010 15:18'!
getEnvironmentVariable: aString   "Win32Utils getEnvironmentVariable: 'windir'"   ^ self getEnvironmentVariable: aString ifAbsent: [nil]! !

!Win32Utils class methodsFor: 'accessing' stamp: 'mtf 12/31/2010 15:17'!
getEnvironmentVariable: name buffer: buffer ifAbsent: block	"Win32Utils getEnvironmentVariable: 'APPDATA' "	"Win32Utils getEnvironmentVariable: 'APPDATAx' "	"http://msdn.microsoft.com/en-us/library/ms683188(VS.85).aspx "		| retval err |	retval := self apiGetEnvironmentVariable:  name buffer: buffer size: buffer byteSize.	retval = 0		ifTrue: [			err := Win32Error lastError.			^(err errorName = 'ERROR_ENVVAR_NOT_FOUND')				ifTrue: [block value]				ifFalse: [					self error: 'Problem with retrieving env var ' , name , '. Code is ' , err errorName.					nil				]		].	^(retval < buffer byteSize)		ifTrue: [( buffer copyFrom: 1 to: retval ) asString]		ifFalse: [ self getEnvironmentVariable: name buffer: (ByteArray new: retval) ifAbsent: block ].! !

!Win32Utils class methodsFor: 'accessing' stamp: 'mtf 12/31/2010 15:17'!
getEnvironmentVariable: name ifAbsent: block	"Win32Utils getEnvironmentVariable: 'APPDATA' ifAbsent: [nil]"	"Win32Utils getEnvironmentVariable: 'APPDATAx' ifAbsent: [5]"	^self getEnvironmentVariable: name buffer: (ByteArray new: 256) ifAbsent: block! !

!Win32Utils class methodsFor: 'accessing' stamp: 'mtf 12/31/2010 15:02'!
getEnvironmentVariables	"Win32Utils getEnvironmentVariables"	| externalData strs |	externalData := self apiGetEnvironmentStrings.	strs := externalData fromCStrings.	self apiFreeEnvironmentStrings: externalData.	^strs! !


!Win32Utils class methodsFor: 'api calls' stamp: 'mtf 12/31/2010 14:53'!
apiFreeEnvironmentStrings: extData	"Win32Utils apiFreeEnvironmentStrings"	<apicall:  long 'FreeEnvironmentStrings' (void*) module: 'kernel32.dll'>	^self externalCallFailed! !

!Win32Utils class methodsFor: 'api calls' stamp: 'mtf 12/31/2010 14:54'!
apiGetEnvironmentStrings	"Win32Utils apiGetEnvironmentStrings"	<apicall:  byte* 'GetEnvironmentStrings' () module: 'kernel32.dll'>	^self externalCallFailed! !

!Win32Utils class methodsFor: 'api calls' stamp: 'mtf 12/31/2010 15:15'!
apiGetEnvironmentVariable:  name buffer: buffer size: bufferSize	"DWORD WINAPI GetEnvironmentVariable(		__in_opt   LPCTSTR lpName,		__out_opt  LPTSTR lpBuffer,		__in       DWORD nSize	);"	"http://msdn.microsoft.com/en-us/library/ms683188(VS.85).aspx"	<apicall:  ulong 'GetEnvironmentVariableA' ( char* byte*  ulong) module: 'kernel32.dll'>	^self externalCallFailed! !

!Win32Utils class methodsFor: 'api calls' stamp: 'mtf 3/14/2011 14:07'!
apiSetCursorPosX: x y: y"this is apparently how to control the mouse cursor pragmatically on windows:http://lists.squeakfoundation.org/pipermail/squeak-dev/2011-February/157676.html"	<apicall: bool 'SetCursorPos' (long long) module: 'user32.dll'>	^self externalCallFailed! !


!Win32Utils class methodsFor: 'examples' stamp: 'tbn 8/23/2005 00:00'!
getCommonEnvironmentVariables	"Returns a dictionary with common environment variables for Win32 systems"	|map|	map := Dictionary new.	#('ALLUSERSPROFILE' 'APPDATA' 'COMPUTERNAME' 'COMSPEC' 'HOMEDRIVE' 'HOMEPATH' 'LOGONSERVER'       'SYSTEMDRIVE' 'OS' 'PATH' 'SYSTEMROOT' 'TEMP' 'TMP' 'USERDOMAIN' 'USERNAME' 'USERPROFILE' 'WINDIR') 		do: [:each | map at: each put: (self getEnvironmentVariable: each)].	^map		! !
