Class {
	#name : #LudoMagicGameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	| aGame players dices julian jorge |
	julian := Player new.
	jorge := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame with: players with: dices and: 10.
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: aGame winner equals: jorge
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	| aGame players dices julian jorge |
	julian := Player new.
	jorge := Player new.
	players := OrderedCollection with: julian with: jorge.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aGame makePlayersThrowDices.
	self assert: julian position equals: 5.
	self assert: jorge position equals: 7
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	| aGame players dices julian jorge|
	julian := Player new.
	jorge := Player new.	
	players := OrderedCollection
		with: julian 
		with: jorge.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 4 1 5))
		with: (LoadedDice with: #(4 5 1 1)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: aGame isFinished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	| aGame players dices julian jorge|
	julian := Player new.
	jorge := Player new.	
	players := OrderedCollection
		with: julian
		with: jorge.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: aGame isFinished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenHasNoDices [
	|  players dices julian jorge |
	julian := Player new.
	jorge := Player new.	
	players := OrderedCollection
		with: julian
		with: jorge.
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
LudoMagicGameTest >> testAGameThrowsAnErrorWhenIsFinishedAndPlayerTriesToRollTheDiceAgain [
	| aGame players dices julian jorge |
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection
		with: jorge
		with: julian.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self
		should: [ aGame makePlayersThrowDices ]
		raise: Error
		description: 'Game is finished, no more rolls are allowed'
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenSizeIsZero [
	
	| players dices julian jorge |
	jorge := Player new.
	julian := Player new.

	players := OrderedCollection with: jorge with: julian.
	dices:= (OrderedCollection with: (LoadedDice with: #(1 2 3 4 5 )) with: (LoadedDice with: #(4 5 6 7))).	
	
	self should: [LudoMagicGame with:(players) with:(dices) and: 0]
	raise: Error
	description: SizeBoardRule new errorMessage .

]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	| aGame players dices julian jorge |
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge  with: julian.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	self deny: aGame isFinished
]

{ #category : #tests }
LudoMagicGameTest >> testNewGameThrowsExceptionWhenZeroOrOnePlayerAreCreated [
	| players dices aPlayer|
	aPlayer := Player new.
	players := OrderedCollection with: aPlayer .
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
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	| aGame players dices jorge julian |
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices := OrderedCollection
		with: (LoadedDice with: #(1 2 3 4 5))
		with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame
		with: players
		with: dices
		and: 10.
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: jorge position equals: 10.
	self assert: julian position equals: 7
]
