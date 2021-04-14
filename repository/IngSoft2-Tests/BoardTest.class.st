Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
BoardTest >> testABoardGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
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
BoardTest >> testABoardGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	
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
BoardTest >> testABoardThrowsAndExceptionWhenIsFinishedAndPlayerTriesToRollTheDiceAgain [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	aBoard rolls.
	aBoard rolls.
	
	self should:  [aBoard rolls ]
	raise: Error 
	description: 'Game is finished, no more rolls are allowed'.
	
]

{ #category : #'as yet unclassified' }
BoardTest >> testANewBoardGameHasAWinner [
	
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
BoardTest >> testANewBoardGameIsNotFinished [
	
	|aBoard aGroupOfPlayers aGroupOfDices |
		
	aGroupOfPlayers:= OrderedCollection with:(Player new)  with: (Player new).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10.
	
	self deny:  (aBoard isFinished ) .
]

{ #category : #'as yet unclassified' }
BoardTest >> testANewBoardGameRollsTheDiceForThePlayers [
	
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
BoardTest >> testANewBoardThrowsAnExceptionWhenSizeIsZero [
	
	| aGroupOfPlayers aGroupOfDices playerOne playerTwo |
		
	playerOne:= Player new.	
	playerTwo:= Player new.	
	aGroupOfPlayers:= OrderedCollection with:(playerOne)  with: (playerTwo).
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	
	self should: [Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 0]
	raise: Error
	description: 'The size of the board must be greater than zero'.

]

{ #category : #'as yet unclassified' }
BoardTest >> testNewBoardThrowsExceptionWhenZeroOrOnePlayerAreCreated [
	
	|aBoard aGroupOfPlayers aGroupOfDices playerOne  |
		
	playerOne:= Player new.	
	aGroupOfPlayers:= OrderedCollection with: playerOne.
	aGroupOfDices:= (OrderedCollection with: (LoadedDice withNumbers: #(1 2 3 4 5 )) with: (LoadedDice withNumbers: #(4 5 6 7))).	
	
	self should:[aBoard:= Board withPlayers:(aGroupOfPlayers) withDices:(aGroupOfDices) andSize: 10]
	raise: Error
	description: 'Cannot start a game with one player'.

]

{ #category : #'as yet unclassified' }
BoardTest >> testWhenPlayerOneWinsTheOtherPlayerDoesNotRollTheDice [
	
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
