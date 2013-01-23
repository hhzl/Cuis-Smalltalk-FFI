Porting notes

1) Filed in FFI.pck.st
2) Over this filed in from folder original (files January 2013)
* FFI-Pools-eem.3.mcz
* FFI-Kernel-tbn.25.mcz
* FFI-Tests-tbn.6.mcz   (new)

The tests had not been included before. There are a number of failures.


The number of tests failures can be brought down to three by the following fixes


    self assert: result isCharacter.

was replaced with

    self assert: result class = Character


    
    SmalltalkImage current isBigEndian

was replaced with

    Smalltalk  isBigEndian



The three remaining failures all are caused by the same reason	

    testPoint2
	    "Test passing and returning up of structures >32bit and <= 64 bit"
	    | pt1 pt2 pt3 |
	    pt1 := FFITestPoint2 new.
	    pt1 x: 1.    "<<<<<<<<< FAILS HERE <<<<<<<<<<<<<<" 
	    pt1 y: 2.
	    pt2 := FFITestPoint2 new.
	    pt2 x: 3. pt2 y: 4.
	    pt3 := FFITestLibrary ffiTestPoint2: pt1 with: pt2.
	    self assert: pt3 x = 4.
	    self assert: pt3 y = 6.
	
The number 1 is assigned to pt1 by this method

    x: anObject
	    "This method was automatically generated"
	    handle signedLongAt: 1 put: anObject


which calls		
		
    signedLongAt: byteOffset put: value
	    "Store a 32bit signed integer starting at the given byte offset"
	    ^self integerAt: byteOffset put: value size: 4 signed: true
	

and then we have the method which fails
	
    integerAt: byteOffset put: value size: nBytes signed: aBoolean
	    "Primitive. Store the given value as integer of nBytes size
	    in the receiver. Fail if the value is out of range.
	    Note: This primitive will access memory in the outer space if
	    invoked from ExternalAddress."
	    <primitive: 'primitiveFFIIntegerAtPut' module:'SqueakFFIPrims'>
	    ^self primitiveFailed   "<<<<<<<<< FAILS HERE <<<<<<<<<<<<<<" 