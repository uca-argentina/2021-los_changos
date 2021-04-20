Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testALudoMagicGameHasAWinner [
	| aLudoMagicGame players dices aPlayer |
	aPlayer := Player new.
	players := OrderedCollection with: aPlayer with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
		
	aLudoMagicGame makePlayersThrowDices.
	aLudoMagicGame makePlayersThrowDices.
	
	self assert: aLudoMagicGame winner equals: aPlayer
]

{ #category : #tests }
BoardTest >> testALudoMagicGameRollsTheDiceForThePlayers [
	| aLudoMagicGame players dices playerOne playerTwo |
	playerOne := Player new.
	playerTwo := Player new.
	players := OrderedCollection with: playerOne with: playerTwo.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aLudoMagicGame makePlayersThrowDices.
	self assert: playerOne position equals: 5.
	self assert: playerTwo position equals: 7
]

{ #category : #tests }
BoardTest >> testALudoMagicGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	| aLudoMagicGame players dices |
	players := OrderedCollection
		with: Player new
		with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 4 1 5))
		with: (LoadedDice with: #(4 5 1 1)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aLudoMagicGame makePlayersThrowDices.
	aLudoMagicGame makePlayersThrowDices.
	self assert: aLudoMagicGame isFinished
]

{ #category : #tests }
BoardTest >> testALudoMagicGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	| aLudoMagicGame players dices |
	players := OrderedCollection
		with: Player new
		with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aLudoMagicGame makePlayersThrowDices.
	aLudoMagicGame makePlayersThrowDices.
	self assert: aLudoMagicGame isFinished
]

{ #category : #tests }
BoardTest >> testALudoMagicGameThrowsAnErrorWhenHasNoDices [
	| players dices |
	players := OrderedCollection
		with: Player new
		with: Player new.
	dices := {}.
	self
		should: [ LudoMagicGame
				with: players
				with: dices
				and: 5 ]
		raise: Error
		description: DicesRule new errorMessage
]

{ #category : #tests }
BoardTest >> testALudoMagicGameThrowsAnErrorWhenIsFinishedAndPlayerTriesToRollTheDiceAgain [
	| aLudoMagicGame players dices |
	players := OrderedCollection
		with: Player new
		with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aLudoMagicGame makePlayersThrowDices.
	aLudoMagicGame makePlayersThrowDices.
	self
		should: [ aLudoMagicGame makePlayersThrowDices ]
		raise: Error
		description: 'Game is finished, no more rolls are allowed'
]

{ #category : #tests }
BoardTest >> testALudoMagicGameThrowsAnErrorWhenSizeIsZero [
	
	| players dices |

	players := OrderedCollection with: Player new  with: Player new.
	dices:= (OrderedCollection with: (LoadedDice with: #(1 2 3 4 5 )) with: (LoadedDice with: #(4 5 6 7))).	
	
	self should: [LudoMagicGame with:(players) with:(dices) and: 0]
	raise: Error
	description: SizeBoardRule new errorMessage .

]

{ #category : #tests }
BoardTest >> testANewLudoMagicGameIsNotFinished [
	| aLudoMagicGame players dices |
	players := OrderedCollection with: Player new with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	self deny: aLudoMagicGame isFinished
]

{ #category : #tests }
BoardTest >> testNewLudoMagicGameThrowsExceptionWhenZeroOrOnePlayerAreCreated [
	| players dices |
	players := OrderedCollection with: Player new.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	self
		should: [ LudoMagicGame
				with: players
				with: dices
				and: 10 ]
		raise: Error
		description: GroupOfPlayersRule new errorMessage
]

{ #category : #tests }
BoardTest >> testWhenPlayerOneWinsTheOtherPlayerDoesNotRollTheDice [
	| aLudoMagicGame players dices playerOne playerTwo |
	playerOne := Player new.
	playerTwo := Player new.
	players := OrderedCollection with: playerOne with: playerTwo.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aLudoMagicGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aLudoMagicGame makePlayersThrowDices.
	aLudoMagicGame makePlayersThrowDices.
	self assert: playerOne position equals: 10.
	self assert: playerTwo position equals: 7
]
