Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> test01ADiceWithNumberOfFacesThrowARandomNumberBetweenOneAndAnotherNumber [
	
	| aDice aNumber |
	aNumber:= 10.
	aDice:= Dice withNumberOfFaces: aNumber .
	self assert: (aDice throw between: 1  and: aNumber ). 
]
