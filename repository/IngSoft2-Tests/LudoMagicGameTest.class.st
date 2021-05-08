Class {
	#name : #LudoMagicGameTest,
	#superclass : #TestCase,
	#instVars : [
		'jorge',
		'julian',
		'players',
		'dices',
		'anOneLapGame',
		'aThreeLapGame',
		'twentySquares',
		'sixSquares',
		'twentySquaresBoard',
		'sixSquaresBoard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
LudoMagicGameTest >> setUp [
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	
	twentySquares:= OrderedCollection new: 20 withAll: EffectlessSquare new.
	sixSquares:= OrderedCollection new: 6 withAll: EffectlessSquare new.
	
	twentySquaresBoard:= FixedBoard playedBy: players withNumberOfLaps: 1 with: twentySquares.
	sixSquaresBoard:= FixedBoard playedBy: players withNumberOfLaps: 3 with: sixSquares.
	
	anOneLapGame := LudoMagicGame throwing: dices withBoard: twentySquaresBoard.
	aThreeLapGame := LudoMagicGame throwing: dices withBoard: sixSquaresBoard.

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
	self assert: (anOneLapGame locationOf:jorge) equals: 6.
	self assert: (anOneLapGame locationOf:julian) equals: 8.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	| someDices tenSquares tenSquaresBoard |
	
	someDices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	
	tenSquares:= OrderedCollection new: 10 withAll: EffectlessSquare new.
	
	tenSquaresBoard:= FixedBoard playedBy: players withNumberOfLaps: 1 with: tenSquares.
	
	anOneLapGame := LudoMagicGame throwing: someDices withBoard: tenSquaresBoard.
	
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
LudoMagicGameTest >> testJorgeGetsToAtomicBombSquare [

	| squares aBoard aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	aBoard:= FixedBoard playedBy: players withNumberOfLaps: 2 with: squares.
	aGame:= LudoMagicGame throwing: dices withBoard: aBoard.
	
	aGame turn.
	
	self assert: (aGame locationOf: jorge) equals: 1.
	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToMoonWalkSquare [

	| squares aBoard aGame |
	squares := { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3. }.
	aBoard:= FixedBoard playedBy: players withNumberOfLaps: 2 with: squares.
	aGame:= LudoMagicGame throwing: dices withBoard: aBoard.
	
	aGame turn.
	aGame turn.
	
	self assert: (aGame locationOf: jorge) equals: 10.

	
	
	
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
LudoMagicGameTest >> testJulianGetsToSpeedUpSquare [

	| squares aBoard aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3.}.
	aBoard:= FixedBoard playedBy: players withNumberOfLaps: 2 with: squares.
	aGame:= LudoMagicGame throwing: dices withBoard: aBoard.
	
	aGame turn.
	aGame turn.
	
	self assert: (aGame locationOf: julian) equals: 16.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToWormHoleSquare [

	| squares aBoard aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	aBoard:= FixedBoard playedBy: players withNumberOfLaps: 2 with: squares.
	aGame:= LudoMagicGame throwing: dices withBoard: aBoard.
	
	aGame turn.
	

	self assert: (aGame locationOf: julian) equals: 4.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianWinsAThreeLapGame [

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
	self assert: (anOneLapGame locationOf: jorge) equals: 21.
	self assert: (anOneLapGame locationOf: julian) equals: 19.

]
