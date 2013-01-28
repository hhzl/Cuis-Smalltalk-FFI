'From Cuis 4.1 of 12 December 2012 [latest update: #1576] on 23 January 2013 at 7:44:56 pm'!
!classDefinition: #Win32Shell category: #'FFI-Win32-Examples'!
ExternalObject subclass: #Win32Shell
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Win32-Examples'!
!Win32Shell commentStamp: '<historical>' prior: 0!
This class wrappes the Windows 32 shell.Try 	Win32Shell new shellOpen: 'c:\image.bmp' 		to open a document	Win32Shell new shellOpen: 'c:\myprogram.exe' 	to start an executable	Win32Shell new shellExplore: 'c:\'				to explore a directory	Win32Shell new shellFind: 'c:\' 					to initiate a searchNote that this class is platform specific.  !


!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:58'!
shellExplore: aPathString	"Explores the folder specified by aPathString"	| result |	result := self shellExecute: nil 		lpOperation: 'explore'		lpFile: aPathString		lpParameters: nil		lpDirectory: nil		nShowCmd: 1.	result <= 32 ifTrue: [self error: 'system error, code:', result printString]! !

!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:58'!
shellFind: aPathString	"Initiates a search starting from the specified directory."	| result |	result := self shellExecute: nil 		lpOperation: 'find'		lpFile: nil		lpParameters: nil		lpDirectory: aPathString		nShowCmd: 1.	result <= 32 ifTrue: [self error: 'system error, code:', result printString]! !

!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:57'!
shellOpen: aFileString	"Opens the file specified by aFileString. The file can be an executable file, a document file, 	 or a folder."	| result fileUrlString |	"@@@@ CHECKME - jrd - Hackity, hack, hack, hack.  Apparently the Win32 url parser doesn't handle %-encoded colons in file paths properly. So we do the conversion ourselves. I'm not sure if the real problem is that we shouldnt be encoding the colons in the first place."	fileUrlString := (aFileString asLowercase beginsWith: 'file:')		ifTrue: [(aFileString copyReplaceAll: '%3A' with: ':') copyReplaceAll: '%3a' with: ':' ]		ifFalse: [aFileString].	result := self shellExecute: nil 		lpOperation: 'open'		lpFile: fileUrlString		lpParameters: nil		lpDirectory: nil		nShowCmd: 1. 	result <= 32 ifTrue: [self error: 'system error, code:', result printString]! !


!Win32Shell methodsFor: 'api calls' stamp: 'sma 6/14/2000 20:17'!
shellExecute: hwnd lpOperation: opString lpFile: fileString lpParameters: parmString lpDirectory: dirString nShowCmd: anInteger	"Opens or prints the specified file, which can be an executable or document file.		HINSTANCE ShellExecute(	  		HWND hwnd,			// handle to parent window			LPCTSTR lpOperation,	// pointer to string that specifies operation to perform			LPCTSTR lpFile,		// pointer to filename or folder name string			LPCTSTR lpParameters,	// pointer to string that specifies executable-file parameters 			LPCTSTR lpDirectory,	// pointer to string that specifies default directory			INT nShowCmd 			// whether file is shown when opened		);"	<apicall: long 'ShellExecuteA' (long char* char* char* char* ulong) module:'shell32.dll'>! !
