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

{ #category : #tests }
DiceTest >> test02ADeterministicDiceIsThrownOnceAndReturnsTheFirstValueOfAnArray [
	
	| aDeterministicDice |
	
	aDeterministicDice:= DeterministicDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aDeterministicDice throw = 1 ).
]

{ #category : #tests }
DiceTest >> test03ADeterministicDiceIsThrownTwiceAndReturnsTheFirstTwoValues [
	
	| aDeterministicDice |
	
	aDeterministicDice:= DeterministicDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aDeterministicDice throw = 1 ).
	self assert: (aDeterministicDice throw = 2 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test04ADeterministicDiceIsThrownMoreTimesThanArraySize [
	
	| aDeterministicDice |
	
	aDeterministicDice:= DeterministicDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aDeterministicDice throw = 1 ).
	self assert: (aDeterministicDice throw = 2 ).
	self assert: (aDeterministicDice throw = 3 ).
	self assert: (aDeterministicDice throw = 4 ).
	self assert: (aDeterministicDice throw = 5 ).
	self assert: (aDeterministicDice throw = 6 ).
	self assert: (aDeterministicDice throw = 1 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test05APlayerThrowsADeterministicDice [
	
	| aDeterministicDice aPlayer |
	
	aDeterministicDice := DeterministicDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	self assert: ((aPlayer throws:aDeterministicDice )= 1 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test06APlayerHasAName [ 
	
	| aDeterministicDice aPlayer |
	
	aDeterministicDice := DeterministicDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player named: 'Ignacio'.
	
	self assert: (aPlayer name = 'Ignacio').
]

{ #category : #'as yet unclassified' }
DiceTest >> test07APlayerStartsInPositionZero [
	
	| aDeterministicDice aPlayer |
	
	aDeterministicDice := DeterministicDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player named: 'Ignacio'.
	
	self assert: (aPlayer position = 0).
	
]

{ #category : #'as yet unclassified' }
DiceTest >> test08ABoardGameHasADeterminedSizeAndAGroupOfPlayers [
    | aNumber aBoardGame aGroupOfPlayers playerOne playerTwo|
    
		aNumber:= 10.

		playerOne:= Player named: 'Ignacio'.
		playerTwo:= Player named: 'Gonzalo'.
		aGroupOfPlayers:= OrderedCollection with: playerOne with: playerTwo.
		
    aBoardGame := BoardGame withSize: aNumber andPlayers: aGroupOfPlayers.

    self assert: (aBoardGame boardSize = aNumber).
		self assert: ((aBoardGame players at: 1) name = playerOne name).
		self assert: ((aBoardGame players at: 2) name = playerTwo name).
	
]

{ #category : #'as yet unclassified' }
DiceTest >> test09ABoardGameRetrievesThePositionOfAPlayer [
    | aNumber aBoardGame aGroupOfPlayers playerOne playerTwo|
    
		aNumber:= 10.

		playerOne:= Player named: 'Ignacio'.
		playerTwo:= Player named: 'Gonzalo'.
		aGroupOfPlayers:= OrderedCollection with: playerOne with: playerTwo.
		
    aBoardGame := BoardGame withSize: aNumber andPlayers: aGroupOfPlayers.

    self assert: ((aBoardGame positionOf: playerOne) = 0 ).
	
]
