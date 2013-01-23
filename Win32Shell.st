'From Cuis 4.1 of 12 December 2012 [latest update: #1576] on 23 January 2013 at 7:44:56 pm'!
!classDefinition: #Win32Shell category: #'FFI-Win32-Examples'!
ExternalObject subclass: #Win32Shell
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'FFI-Win32-Examples'!
!Win32Shell commentStamp: '<historical>' prior: 0!
This class wrappes the Windows 32 shell.


!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:58'!
shellExplore: aPathString

!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:58'!
shellFind: aPathString

!Win32Shell methodsFor: 'operations' stamp: 'tbn 8/8/2012 14:57'!
shellOpen: aFileString


!Win32Shell methodsFor: 'api calls' stamp: 'sma 6/14/2000 20:17'!
shellExecute: hwnd lpOperation: opString lpFile: fileString lpParameters: parmString lpDirectory: dirString nShowCmd: anInteger