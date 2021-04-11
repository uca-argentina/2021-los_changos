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
	
	self assert: ((aPlayer throws:{aLoadedDice} )= 1 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test06APlayerStartsInPositionZero [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	self assert: (aPlayer position = 0).
	
]

{ #category : #'as yet unclassified' }
DiceTest >> test07APlayerThrowsTheDiceTwice [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	aPlayer throws:{aLoadedDice} .
	aPlayer throws:{aLoadedDice} .
	
	self assert: ((aPlayer position  )= 3 ).
]

{ #category : #'as yet unclassified' }
DiceTest >> test08aNewBoardGameIsNotFinished [
	
	|aBoard aGroupOfPlayers aGroupOfDices |
		
	aGroupOfPlayers:= OrderedCollection with:(Player new)  with: (Player new).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= BoardGame withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	self deny:  (aBoard isFinished ) .
]

{ #category : #'as yet unclassified' }
DiceTest >> test09aNewBoardGameRollsTheDiceForThePlayers [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= BoardGame withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	
	self assert:  (playerOne position = 5  ) .
	self assert: (playerTwo position = 7)
]

{ #category : #'as yet unclassified' }
DiceTest >> test10ABoardGameRollsTheDiceForThePlayersTwiceAndIsFinished [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= BoardGame withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  (aBoard isFinished  ) .
]

{ #category : #'as yet unclassified' }
DiceTest >> test11aNewBoardGameHasAWinner [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= BoardGame withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  (aBoard winner = playerOne ) .
	
]

{ #category : #'as yet unclassified' }
DiceTest >> test12WhenPlayerOneWinsTheOtherPlayerDoesNotRollTheDice [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= BoardGame withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  (playerOne position = 14) .
	self assert: (playerTwo position = 7).
	
]
