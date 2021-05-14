Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'exception tests' }
DiceTest >> testADiceCannotBeCreatedWithNumberOfFacesIsNegative [
		self
		should: [Dice withFaces: -6]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The number of faces must be greater than 1' ].
	
]

{ #category : #'exception tests' }
DiceTest >> testADiceCannotBeCreatedWithNumberOfFacesIsOne [
		self
		should: [Dice withFaces: 1]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The number of faces must be greater than 1' ].
	
]

{ #category : #'exception tests' }
DiceTest >> testADiceCannotBeCreatedWithNumberOfFacesIsZero [
		self
		should: [Dice withFaces: 0]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The number of faces must be greater than 1' ].
	
]

{ #category : #tests }
DiceTest >> testADiceWithNumberOfFacesRolls [
	
	| aDice aNumber |
	aNumber:= 10.
	aDice:= Dice withFaces: aNumber .
	self assert: (aDice roll between: 1  and: aNumber ). 
]

{ #category : #tests }
DiceTest >> testALoadedDiceRollsMoreTimesThanQuantityOfValues [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withValues: #(0 9 7 1).
	self assert: aLoadedDice roll equals: 0.
	self assert: aLoadedDice roll equals: 9.
	self assert: aLoadedDice roll equals: 7.
	self assert: aLoadedDice roll equals: 1.
	self assert: aLoadedDice roll equals: 0.
]

{ #category : #tests }
DiceTest >> testALoadedDiceRollsOnceAndReturnsTheFirstValue [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withValues: #(1 2 3 4 5 6).
	self assert: aLoadedDice roll equals: 1.
]

{ #category : #tests }
DiceTest >> testALoadedDiceRollsTwiceAndReturnsTheFirstTwoValues [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withValues: #(5 1 0 5 7 6).
	self assert: aLoadedDice roll equals: 5.
	self assert: aLoadedDice roll equals: 1.
]
