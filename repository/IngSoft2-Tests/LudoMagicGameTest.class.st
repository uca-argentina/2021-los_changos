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
		'sixSquares'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #running }
LudoMagicGameTest >> setUp [
	jorge := Player new.
	julian := Player new.
	players := OrderedCollection with: jorge with: julian.
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	
	sixSquares := OrderedCollection  new: 6 withAll: EffectlessSquare new. 
	twentySquares := OrderedCollection new:20 withAll: EffectlessSquare new. 
	anOneLapGame := LudoMagicGame playedBy: players withNumberOfLaps: 1 throwing:dices andWithBoardOfSquares:twentySquares.
	aThreeLapGame:= LudoMagicGame  playedBy: players withNumberOfLaps: 3 throwing:dices andWithBoardOfSquares:sixSquares .
	

]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	anOneLapGame round.
	anOneLapGame round.
	anOneLapGame round.
	self assert: anOneLapGame winner equals: jorge.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasNoWinner [
	anOneLapGame round.
	anOneLapGame round.
	self 	should: [anOneLapGame winner]  
			raise: Error 
			description:  'There is no winner because game has not finished yet'.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	anOneLapGame round.
	self assert: (anOneLapGame squaresAdvancedBy:jorge) equals: 6.
	self assert: (anOneLapGame squaresAdvancedBy:julian) equals: 8.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	| someDices |
	
	someDices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	

	anOneLapGame := LudoMagicGame playedBy:players  withNumberOfLaps:1  throwing:someDices   andWithBoardOfSquares:(OrderedCollection new:10 withAll: EffectlessSquare new). 
	
	anOneLapGame round.
	anOneLapGame round.
	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	anOneLapGame round.
	anOneLapGame round.
	anOneLapGame round.
	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenHasNoDices [
	self
		should: [ LudoMagicGame playedBy: players withNumberOfLaps:3  throwing:{}  andWithBoardOfSquares:6]
		raise: Error
		description: 'There must be dices'
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThrowsAnErrorWhenIsFinishedAndPlayerTriesToRollTheDiceAgain [

	anOneLapGame round.
	anOneLapGame round.
	anOneLapGame round.
	self
		should: [ anOneLapGame round ]
		raise: Error
		description: LudoMagicGame messageOfNoMoreRollsAllowed 
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

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares. 
	
	aGame round.
	
	self assert: (aGame squaresAdvancedBy: jorge) equals: 1.
	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToMoonWalkSquare [

	| squares  aGame |
	squares := { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices andWithBoardOfSquares:squares. 
	
	aGame round.
	aGame round.
	
	self assert: (aGame squaresAdvancedBy: jorge) equals: 10.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeIsAtTheLapOneAndJulianIsAtTheLapZero [

	aThreeLapGame round.

	self assert: (aThreeLapGame lapOf: jorge) equals: 0.
	self assert: (aThreeLapGame lapOf: julian) equals: 1.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeWinsAThreeLapGame [

	aThreeLapGame round.
	aThreeLapGame round.
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToSpeedUpSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares:squares. 
	
	aGame round.
	aGame round.
	
	self assert: (aGame squaresAdvancedBy: julian) equals: 16.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToWormHoleSquare [

	| squares aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares.
	
	aGame round.
	

	self assert: (aGame squaresAdvancedBy: julian) equals: 4.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianWinsAThreeLapGame [

	aThreeLapGame round.
	aThreeLapGame round.
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testNoMoreTurnAreAllowedWhenThreeLapGameIsFinished [

	aThreeLapGame round.
	aThreeLapGame round.
	
	self 	should: [ aThreeLapGame round ] 
			raise: Error
			description: [ LudoMagicGame messageOfNoMoreRollsAllowed  ]
]

{ #category : #tests }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	anOneLapGame round.
	anOneLapGame round.
	anOneLapGame round.
	self assert: (anOneLapGame squaresAdvancedBy: jorge) equals: 21.
	self assert: (anOneLapGame squaresAdvancedBy: julian) equals: 19.

]
