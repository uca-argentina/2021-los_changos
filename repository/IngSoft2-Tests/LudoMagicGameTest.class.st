Class {
	#name : #LudoMagicGameTest,
	#superclass : #TestCase,
	#instVars : [
		'jorge',
		'julian',
		'players',
		'dices',
		'aGame'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
LudoMagicGameTest >> setUp [
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices := OrderedCollection with: (LoadedDice with: #(1 2 3 4 5)) with: (LoadedDice with: #(4 5 6 7)).
	aGame := LudoMagicGame with: players with: dices and: 10.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: aGame winner equals: jorge
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	aGame makePlayersThrowDices.
	self assert: jorge position equals: 5.
	self assert: julian position equals: 7
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
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
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: aGame isFinished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenHasNoDices [
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

	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self
		should: [ aGame makePlayersThrowDices ]
		raise: Error
		description: 'Game is finished, no more rolls are allowed'
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenSizeIsZero [
	
	self should: [LudoMagicGame with:(players) with:(dices) and: 0]
	raise: Error
	description: SizeBoardRule new errorMessage .

]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: aGame isFinished
]

{ #category : #tests }
LudoMagicGameTest >> testNewGameThrowsExceptionWhenZeroOrOnePlayerAreCreated [
	players remove: jorge.
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
	aGame makePlayersThrowDices.
	aGame makePlayersThrowDices.
	self assert: jorge position equals: 10.
	self assert: julian position equals: 7
]
