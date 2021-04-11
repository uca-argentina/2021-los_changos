Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
GameTest >> testABoardGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 4 1 5 )) with: (LoadedDice withNumbers: #(4 5  1 1))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  (aBoard isFinished ) .
]

{ #category : #'as yet unclassified' }
GameTest >> testABoardGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  (aBoard isFinished ) .
]

{ #category : #'as yet unclassified' }
GameTest >> testANewBoardGameHasAWinner [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  aBoard winner equals: playerOne .
	
]

{ #category : #'as yet unclassified' }
GameTest >> testANewBoardGameIsNotFinished [
	
	|aBoard aGroupOfPlayers aGroupOfDices |
		
	aGroupOfPlayers:= OrderedCollection with:(Player new)  with: (Player new).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	self deny:  (aBoard isFinished ) .
]

{ #category : #'as yet unclassified' }
GameTest >> testANewBoardGameRollsTheDiceForThePlayers [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	
	self assert:  playerOne position equals: 5 .
	self assert: playerTwo position equals: 7.
]

{ #category : #'as yet unclassified' }
GameTest >> testWhenPlayerOneWinsTheOtherPlayerDoesNotRollTheDice [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self assert:  playerOne position equals: 14.
	self assert: playerTwo position equals: 7.
	
]
