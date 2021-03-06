Cuis-FFI for version 4.1
========

FFI port from http://source.squeak.org/FFI for Cuis Smalltalk https://github.com/jvuletich/Cuis


The port contains

* FFI-Kernel
* FFI-Pools
* FFI-Tests

### Status
Do not use this repository for version 4.2 and later as it has been integrated into Cuis-Smalltalk-Dev.
In Cuis 4.2 just do

      Feature require: 'FFITests'



### What is FFI and what is it used for?

FFI, the Squeak Foreign Function Interface, is used to call functions located in shared libraries that are not part of the Squeak VM nor its plugins. It also provides means to read and write memory structures that are associated with the use of those shared libraries. A typical use is to directly invoke operating system APIs. As such, applications that use FFI can only be used on the platform(s) that support the particular API being used. C conventions are used throughout, though the external function could have been written by any language capable of generating object code that follows C conventions. 


Source: http://wiki.squeak.org/squeak/1414


### Discussion on Cuis mailing list

http://jvuletich.org/pipermail/cuis_jvuletich.org/2013-January/000556.html


### Installation

       "Load Foreign Function Interface (FFI)"

        | slash |

        slash _ FileDirectory slash.
        {
             '..', slash, 'Cuis-FFI', slash, 'FFI.pck.st' .
			 '..', slash, 'Cuis-FFI', slash, 'FFI-Tests.pck.st' .
        }

        do:

        [ :fileName | CodePackageFile installPackageStream:
	
                     (FileStream concreteStream readOnlyFileNamed: fileName)
        ].

       "Initialisation for tests"
       (Smalltalk at: #FFITestPoint2) perform: #defineFields.
       (Smalltalk at: #FFITestPoint4) perform: #defineFields.   

		
### Test in MSWindows 7

File in Win32Shell.st and evaluate the examples in the class comment. OK

Win32Shell.st is a class which is part of FFI-Win32-tbn.11.mcz		
		

### Status

This port started as with a 1:1 copy of FFI.pck.st from https://github.com/bpieber/Cuis-StyledTextEditor/blob/master/FFI.pck 

That represents the status of http://source.squeak.org/FFI of March/April 2012

Here in the folder 'original' there are the Monticello files from http://source.squeak.org/FFI as of January 2013. 

They have been included, see PortingNotes.md in the notes subdirectory. This newly includes the FFI-Tests package.

All 23 tests are green.
