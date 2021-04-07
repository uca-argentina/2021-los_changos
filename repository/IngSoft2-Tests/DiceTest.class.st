Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> test01ADiceWithNumberOfFacesIsBeingThrown [
	
	| aDice maxNumber |
	maxNumber:= 10.
	aDice:= Dice withNumberOfFaces: maxNumber .
	self assert: (aDice throw between:1  and: maxNumber ). 
]
