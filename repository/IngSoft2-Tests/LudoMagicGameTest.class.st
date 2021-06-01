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
	
	sixSquares :=  Distributor of: {EffectlessSquare new}  withProportions:#(100) andSize: 6. 
	twentySquares := Distributor of: {EffectlessSquare new}  withProportions:#(100) andSize: 20. 
	anOneLapGame := LudoMagicGame playedBy: players withNumberOfLaps: 1 throwing:dices andWithBoardOfSquares:twentySquares.
	aThreeLapGame:= LudoMagicGame  playedBy: players withNumberOfLaps: 3 throwing:dices andWithBoardOfSquares:sixSquares .
	
	

]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotHaveAWinnerIfItIsNotFinished [

	anOneLapGame do: 2.
	self should: [anOneLapGame winner] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There is no winner because game has not finished yet' ].

]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotHaveAWinnerWhenItIsNew [

	self
		should: [anOneLapGame winner] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There is no winner because game has not finished yet' ].
			
		
]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotHaveNoDices [
	self
		should: [ LudoMagicGame playedBy: players withNumberOfLaps:3  throwing:{}  andWithBoardOfSquares:6]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be dices' ].
		
]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotMakeARoundWhenItIsFinished [

	anOneLapGame do: 5.
	
	self
		should: [ anOneLapGame turn]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame messageOfNoMoreRollsAllowed. ].
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	anOneLapGame do: 5.
	
	
	self assert: anOneLapGame winner equals: jorge.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRespectsDefaultProportionsWithASizeOneHundred [
	
	| aGame squares quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares |
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  withSize: 100.
	
	squares:= aGame squares.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 48.
	self assert: quantityOfWormHoleSquares equals: 20.
	self assert: quantityOfSpeedUpSquares equals: 20.
	self assert: quantityOfAtomicBombSquares equals: 2.
	self assert: quantityOfMoonWalkSquares equals: 10.

]

{ #category : #tests }
LudoMagicGameTest >> testAGameRespectsDefaultProportionsWithASizeTwentyFive [
	
	| aGame squares quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares |
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  withSize: 25.
	
	squares:= aGame squares.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 11.
	self assert: quantityOfWormHoleSquares equals: 5.
	self assert: quantityOfSpeedUpSquares equals: 5.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 3.

]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	anOneLapGame do: 2.
	
	self assert: (anOneLapGame numberOfSquareOf:jorge) equals: 6.
	self assert: (anOneLapGame numberOfSquareOf:julian) equals: 8.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	| someDices |
	
	someDices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	

	anOneLapGame := LudoMagicGame playedBy:players  withNumberOfLaps:1  throwing:someDices   andWithBoardOfSquares:(OrderedCollection new:10 withAll: EffectlessSquare new). 
	
	anOneLapGame do: 3.
	

	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	anOneLapGame do: 5.
	
	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAThreeLapGameCannotMakeAnotherRoundWhenItIsFinished [
	aThreeLapGame do: 4.		
	self
		should: [aThreeLapGame turn] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame messageOfNoMoreRollsAllowed ].
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToAMoonWalkAndGoesToTheFirstSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. MoonWalkSquare with: 5. EffectlessSquare new. EffectlessSquare new.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(9 2 4 5))}  andWithBoardOfSquares: squares. 
	
	aGame turn.
	aGame turn.
	self assert: (aGame lapOf:jorge) equals: 0.
	self assert: (aGame numberOfSquareOf: jorge) equals: 5.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToAtomicBombSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares. 
	
	aGame turn.
	
	self assert: (aGame numberOfSquareOf:jorge) equals: 1.
	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToMoonWalkSquare [

	| squares  aGame |
	squares := { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices andWithBoardOfSquares:squares. 
	
	aGame do: 3.
		
	self assert: (aGame numberOfSquareOf:jorge) equals: 10.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeIsAtTheLapOneAndJulianIsAtTheLapZero [

	aThreeLapGame do:2.

	self assert: (aThreeLapGame lapOf: jorge) equals: 0.
	self assert: (aThreeLapGame lapOf: julian) equals: 1.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeWinsAThreeLapGame [

	aThreeLapGame do: 4.	
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToAtomicBombSquareWhenAPlayerIsAtSecondLap [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. AtomicBombSquare new. EffectlessSquare new.  EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(10 1 3 4 5)). (LoadedDice withValues: #(5 4 6 7))}  andWithBoardOfSquares: squares. 
	
	aGame do:2.
	
	self assert: (aGame lapOf:jorge) equals: 1.
	self assert: (aGame lapOf:julian) equals: 0.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToSpeedUpSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares:squares. 
	
	aGame do: 4.
	
	
	self assert: (aGame numberOfSquareOf: julian) equals: 3.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToWormHoleSquare [

	| squares aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares.
	
	aGame do: 2.
	

	self assert: (aGame numberOfSquareOf: julian) equals: 4.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianWinsAThreeLapGame [

	aThreeLapGame do: 4.
	
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	anOneLapGame do: 5.
	
	self assert: (anOneLapGame numberOfSquareOf: jorge) equals: 1.
	self assert: (anOneLapGame numberOfSquareOf: julian) equals: 19.

]
