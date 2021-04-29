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
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	aGame := LudoMagicGame playedBy: players throwing: dices onBoardOf: 10.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	self setUp.
	aGame turn.
	aGame turn.
	self assert: aGame winner equals: jorge.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	aGame turn.
	self assert: (aGame positionOf:jorge) equals: 5.
	self assert: (aGame positionOf:julian) equals: 7
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	dices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	aGame := LudoMagicGame
		playedBy: players
		throwing: dices
		onBoardOf: 10.
	
	aGame turn.
	aGame turn.
	self assert: aGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	aGame turn.
	aGame turn.
	self assert: aGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenHasNoDices [
	dices := {}.
	self
		should: [ LudoMagicGame
				playedBy: players
				throwing: dices
				onBoardOf: 5 ]
		raise: Error
		description: DicesRule new errorMessage
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenIsFinishedAndPlayerTriesToRollTheDiceAgain [

	aGame turn.
	aGame turn.
	self
		should: [ aGame turn ]
		raise: Error
		description: 'Game is finished, no more rolls are allowed'
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenSizeIsZero [
	
	self should: [LudoMagicGame playedBy:(players) throwing:(dices) onBoardOf: 0]
	raise: Error
	description: SizeBoardRule new errorMessage .

]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: aGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testNewGameThrowsExceptionWhenZeroOrOnePlayerAreCreated [
	players remove: jorge.
	dices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 3 4 5))
		with: (LoadedDice withValues: #(4 5 6 7)).
	self
		should: [ LudoMagicGame
				playedBy: players
				throwing: dices
				onBoardOf: 10 ]
		raise: Error
		description: GroupOfPlayersRule new errorMessage
]

{ #category : #tests }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	aGame turn.
	aGame turn.
	self assert: (aGame positionOf: jorge) equals: 10.
	self assert: (aGame positionOf: julian) equals: 7.

]
