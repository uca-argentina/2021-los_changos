Class {
	#name : #LudoMagicGameTest,
	#superclass : #TestCase,
	#instVars : [
		'jorge',
		'julian',
		'players',
		'dices',
		'anOneLapGame',
		'aThreeLapGame'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
LudoMagicGameTest >> setUp [
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	anOneLapGame := LudoMagicGame playedBy: players throwing: dices withNumberOfLaps: 1 onBoardOf: 20.
	aThreeLapGame := LudoMagicGame playedBy: players throwing: dices withNumberOfLaps: 3 onBoardOf: 6.

]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	anOneLapGame turn.
	anOneLapGame turn.
	anOneLapGame turn.
	self assert: anOneLapGame winner equals: jorge.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasNoWinner [
	anOneLapGame turn.
	anOneLapGame turn.
	self 	should: [anOneLapGame winner]  
			raise: Error 
			description:  'There is no winner because game has not finished yet'.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	anOneLapGame turn.
	self assert: (anOneLapGame locationOf:jorge) equals: 5.
	self assert: (anOneLapGame locationOf:julian) equals: 7
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	dices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	anOneLapGame := LudoMagicGame
		playedBy: players
		throwing: dices
		withNumberOfLaps: 1
		onBoardOf: 10.
	
	anOneLapGame turn.
	anOneLapGame turn.
	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	anOneLapGame turn.
	anOneLapGame turn.
	anOneLapGame turn.
	self assert: anOneLapGame finished
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

	anOneLapGame turn.
	anOneLapGame turn.
	anOneLapGame turn.
	self
		should: [ anOneLapGame turn ]
		raise: Error
		description: LudoMagicGame messageOfNoMoreRollsAllowed 
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenSizeIsZero [
	
	self should: [LudoMagicGame playedBy:(players) throwing:(dices) withNumberOfLaps: 6 onBoardOf: 0]
	raise: Error
	description: SizeBoardRule new errorMessage .

]

{ #category : #tests }
LudoMagicGameTest >> testANewGameHasNoWinner [
	self 	should: [anOneLapGame winner]  
			raise: Error 
			description:  'There is no winner because game has not finished yet'.
]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeIsAtTheLapOneAndJulianIsAtTheLapZero [

	aThreeLapGame turn.

	self assert: (aThreeLapGame lapOf: jorge) equals: 0.
	self assert: (aThreeLapGame lapOf: julian) equals: 1.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeWinsAThreeLapGame [

	aThreeLapGame turn.
	aThreeLapGame turn.
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testNewGameThrowsExceptionWhenTheNumberOfLapsIsNegative [
	players remove: jorge.
	dices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 3 4 5))
		with: (LoadedDice withValues: #(4 5 6 7)).
	self
		should: [ LudoMagicGame
				playedBy: players
				throwing: dices
				withNumberOfLaps: -2
				onBoardOf: 10 ]
		raise: Error
		description: NumberOfLapsRule new errorMessage
]

{ #category : #tests }
LudoMagicGameTest >> testNewGameThrowsExceptionWhenTheNumberOfLapsIsZero [
	players remove: jorge.
	dices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 3 4 5))
		with: (LoadedDice withValues: #(4 5 6 7)).
	self
		should: [ LudoMagicGame
				playedBy: players
				throwing: dices
				withNumberOfLaps: 0
				onBoardOf: 10 ]
		raise: Error
		description: NumberOfLapsRule new errorMessage
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
				withNumberOfLaps: 12
				onBoardOf: 10 ]
		raise: Error
		description: GroupOfPlayersRule new errorMessage
]

{ #category : #tests }
LudoMagicGameTest >> testNoMoreTurnAreAllowedWhenThreeLapGameIsFinished [

	aThreeLapGame turn.
	aThreeLapGame turn.
	
	self 	should: [ aThreeLapGame turn ] 
			raise: Error
			description: [ LudoMagicGame messageOfNoMoreRollsAllowed  ]
]

{ #category : #tests }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	anOneLapGame turn.
	anOneLapGame turn.
	anOneLapGame turn.
	self assert: (anOneLapGame locationOf: jorge) equals: 20.
	self assert: (anOneLapGame locationOf: julian) equals: 18.

]
