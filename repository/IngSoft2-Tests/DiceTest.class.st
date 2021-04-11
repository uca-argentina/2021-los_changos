Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> test01ADiceWithNumberOfFacesRollsANumberBetweenOneAndAnotherNumber [
	
	| aDice aNumber |
	aNumber:= 10.
	aDice:= Dice withNumberOfFaces: aNumber .
	self assert: (aDice roll between: 1  and: aNumber ). 
]

{ #category : #tests }
DiceTest >> test02ALoadedDiceRollsOnceAndReturnsTheFirstValueOfAnArray [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aLoadedDice roll = 1 ).
]

{ #category : #tests }
DiceTest >> test03ALoadedDiceRollsTwiceAndReturnsTheFirstTwoValues [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aLoadedDice roll = 1 ).
	self assert: (aLoadedDice roll = 2 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test04ALoadedDiceRollsMoreTimesThanArraySize [
	
	| aLoadedDice |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5 6).
	self assert: (aLoadedDice roll = 1 ).
	self assert: (aLoadedDice roll = 2 ).
	self assert: (aLoadedDice roll = 3 ).
	self assert: (aLoadedDice roll = 4 ).
	self assert: (aLoadedDice roll = 5 ).
	self assert: (aLoadedDice roll = 6 ).
	self assert: (aLoadedDice roll = 1 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test05APlayerThrowsALoadedDice [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	self assert: ((aPlayer throws:aLoadedDice )= 1 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test06APlayerHasAName [ 
	
	| aDeterministicDice aPlayer |
	
	aDeterministicDice := LoadedDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player named: 'Ignacio'.
	
	self assert: (aPlayer name = 'Ignacio').
]

{ #category : #'as yet unclassified' }
DiceTest >> test07APlayerStartsInPositionZero [
	
	| aDeterministicDice aPlayer |
	
	aDeterministicDice := LoadedDice withNumbers: #(1 2 3 4 5).
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

{ #category : #'as yet unclassified' }
DiceTest >> test10ABoardGameRetrievesThePositionOfAPlayerThatRollsTheDice [
    | aNumber aBoardGame aGroupOfPlayers playerOne playerTwo aLoadedDice |
    
		aNumber:= 10.
		aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5 6).
		playerOne:= Player named: 'Ignacio'.
		playerTwo:= Player named: 'Gonzalo'.
		aGroupOfPlayers:= OrderedCollection with: playerOne with: playerTwo.
		
    aBoardGame := BoardGame withSize: aNumber andPlayers: aGroupOfPlayers.
		
		playerOne throws: aLoadedDice .

    self assert: ((aBoardGame positionOf: playerOne) = 1).
	
]
