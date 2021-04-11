Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testADiceWithNumberOfFacesRollsANumberBetweenOneAndAnotherNumber [
	
	| aDice aNumber |
	aNumber:= 10.
	aDice:= Dice withNumberOfFaces: aNumber .
	self assert: (aDice roll between: 1  and: aNumber ). 
]

{ #category : #'as yet unclassified' }
DiceTest >> testALoadedDiceRollsMoreTimesThanArraySize [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(0 9 7 1).
	self assert: aLoadedDice roll equals: 0.
	self assert: aLoadedDice roll equals: 9.
	self assert: aLoadedDice roll equals: 7.
	self assert: aLoadedDice roll equals: 1.
	self assert: aLoadedDice roll equals: 0.
]

{ #category : #tests }
DiceTest >> testALoadedDiceRollsOnceAndReturnsTheFirstValueOfAnArray [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5 6).
	self assert: aLoadedDice roll equals: 1.
]

{ #category : #tests }
DiceTest >> testALoadedDiceRollsTwiceAndReturnsTheFirstTwoValues [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(5 1 0 5 7 6).
	self assert: aLoadedDice roll equals: 5.
	self assert: aLoadedDice roll equals: 1.
]
