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
		'aDeck'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
LudoMagicGameTest >> do: numberOfTurnsToDo theGame: aLudoMagicGame [ 
	1 to: (numberOfTurnsToDo) do: [ :number | aLudoMagicGame turn ]
]

{ #category : #running }
LudoMagicGameTest >> setUp [
	super setUp.
	jorge := 'jorge'.
	julian := 'julian'.
	
	players := OrderedCollection with: jorge with: julian.
	
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	aDeck := Deck with: (Card subclasses collect: [:kindOfCard | kindOfCard new ]).
	
	sixSquares :=  (ProbabilisticDistributor with: { ProbabilisticEvent with: 1 for: EffectlessSquare new }) generate: 6.
	twentySquares := (ProbabilisticDistributor with: { ProbabilisticEvent with: 1 for: EffectlessSquare new }) generate: 20. 
	anOneLapGame := LudoMagicGame playedBy: players withNumberOfLaps: 1 throwing:dices andWithBoardOfSquares:twentySquares withDeckOf: aDeck.
	aThreeLapGame:= LudoMagicGame  playedBy: players withNumberOfLaps: 3 throwing:dices andWithBoardOfSquares:sixSquares withDeckOf: aDeck .

]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotHaveAWinnerIfItIsNotFinished [

	self do: 2 theGame: anOneLapGame.
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
		should: [ LudoMagicGame playedBy: players withNumberOfLaps:3  throwing: {}  withSize: 6 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be dices' ].
		
]

{ #category : #tests }
LudoMagicGameTest >> testAGameCannotMakeARoundWhenItIsFinished [
	

	self do: 5 theGame: anOneLapGame .
	
	self
		should: [ anOneLapGame turn]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame messageOfNoMoreRollsAllowed. ].
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasABoardThatRespectSize [
	| aGame |
	aGame := LudoMagicGame playedBy: players withNumberOfLaps: 3 throwing: dices withSize: 100.
	self assert: aGame size equals: 100.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameHasAWinner [
	self do: 5 theGame: anOneLapGame .
	
	self assert: anOneLapGame winner equals: jorge.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	self do: 2 theGame: anOneLapGame .
	
	self assert: (anOneLapGame numberOfSquareOf:jorge) equals: 6.
	self assert: (anOneLapGame numberOfSquareOf:julian) equals: 8.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	| someDices |
	
	someDices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	

	anOneLapGame := LudoMagicGame playedBy:players  withNumberOfLaps:1  throwing:someDices   andWithBoardOfSquares:(OrderedCollection new:10 withAll: EffectlessSquare new) withDeckOf: aDeck. 
	
	self do: 3 theGame: anOneLapGame .
	

	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	self do: 5 theGame: anOneLapGame .
	
	self assert: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThatGiveToPlayersToCards [
	| aGame |
	aGame := LudoMagicGame playedBy: players withNumberOfLaps: 3 throwing: dices withSize: 100.
	self assert: aGame size equals: 100.
]

{ #category : #tests }
LudoMagicGameTest >> testAGameThatGiveToPlayersTwoCards [
	| aGame |
	aGame := LudoMagicGame playedBy: players withNumberOfLaps: 3 throwing: dices withSize: 100.
	self assert: (aGame quantityOfCardInHandOf: julian) equals: 2.
	self assert: (aGame quantityOfCardInHandOf: jorge) equals: 2.
]

{ #category : #tests }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: anOneLapGame finished
]

{ #category : #tests }
LudoMagicGameTest >> testAThreeLapGameCannotMakeAnotherRoundWhenItIsFinished [
	self do: 4 theGame: aThreeLapGame .
	self
		should: [aThreeLapGame turn] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame messageOfNoMoreRollsAllowed ].
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeAndJulianGotDifferentsCards [
	| aGame squares aCard anotherCard |
	
	aCard := Card new.
	anotherCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. DeliveryCardSquare new. }.
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { aCard . anotherCard }).
	
	self do: 2 theGame: aGame.
	
	self assert: (aGame has: jorge theCard: aCard).
	self assert: (aGame has: julian theCard: anotherCard)
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeCannotThrowAnOverloadCardThatHeDoesNotHave [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { anOverloadCard }).
	
	self do: 2 theGame: aGame.
	self
		should: [ 	aGame cardPlayedBy: jorge to: julian with: SpeedCard new.]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The player cannot throw this card because he does not have it' ].
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeCannotThrowAnOverloadCardWhenItIsHisTurn [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { anOverloadCard}).
	
	aGame turn.
	self
		should: [ aGame cardPlayedBy: jorge to: julian with: anOverloadCard.]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The player cannot throw this card because it is not his turn' ].
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeCannotThrowAnOverloadCardWhenItIsNotHisTurn [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { anOverloadCard }).
	
	aGame turn.
	
	self
		should: [ aGame cardPlayedBy: jorge to: julian with: anOverloadCard. ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The player cannot throw this card because it is not his turn' ].
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsASpeedCardAndThrowItToJulian [
	| aGame squares aSpeedCard|
	
	aSpeedCard := SpeedCard new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { aSpeedCard}).
	self do: 2 theGame: aGame .
	
	aGame cardPlayedBy:jorge to:julian with: aSpeedCard .
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame numberOfSquareOf: julian) equals:5.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsASpeedCardAndThrowItToJulian2 [
	| aGame squares aAccelerationCard|
	
	aAccelerationCard := SpeedCard new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { aAccelerationCard }).
	
	self do: 2 theGame: aGame .
	
	aGame cardPlayedBy:jorge to:julian with: aAccelerationCard .
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame numberOfSquareOf: julian) equals:5.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsAnAccelerationAndAffectsAllPlayers [
	| aGame squares anAccelerationCard|
	
	anAccelerationCard := AccelerationCard new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ anAccelerationCard }).
	
	self do: 2 theGame: aGame .
	
	aGame cardPlayedBy:jorge to:players with: anAccelerationCard.
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame numberOfSquareOf: julian) equals:5.
	self assert: (aGame numberOfSquareOf: jorge) equals:1
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsAnOverloadCardAndThrowItToJulian [
	| aGame squares anOverloadCard|
	
	anOverloadCard := OverloadCard new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ anOverloadCard }).
	
	self do: 2 theGame: aGame .
	
	aGame cardPlayedBy:jorge to:julian with: anOverloadCard .
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame numberOfSquareOf: julian) equals:2.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToAMoonWalkAndGoesToTheFirstSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. MoonWalkSquare with: 5. EffectlessSquare new. EffectlessSquare new.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(9 2 4 5))}  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
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
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares withDeckOf: aDeck.
	
	aGame turn.
	
	self assert: (aGame numberOfSquareOf:jorge) equals: 1.
	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToLoadedSquareAndGetACard [
	| aGame squares aCard |
	
	aCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new.}.
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: {aCard}).
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame has: jorge theCard: aCard).
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeGetsToMoonWalkSquare [

	| squares  aGame |
	squares := { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices andWithBoardOfSquares:squares withDeckOf: aDeck.
	
	self do: 3 theGame: aGame .
		
	self assert: (aGame numberOfSquareOf:jorge) equals: 10.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeIsAtTheLapOneAndJulianIsAtTheLapZero [

	self do: 2 theGame: aThreeLapGame  .

	self assert: (aThreeLapGame lapOf: jorge) equals: 0.
	self assert: (aThreeLapGame lapOf: julian) equals: 1.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeThrowsAnOverloadCardAndDoesntHaveItAnymore [
	| aGame squares anOverloadCard|

	anOverloadCard := OverloadCard new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ anOverloadCard }).
	
	self do: 2 theGame: aGame .
	aGame cardPlayedBy: jorge to: julian with: anOverloadCard.

	self assert: ( aGame quantityOfCardInHandOf: jorge ) equals: 2.
]

{ #category : #tests }
LudoMagicGameTest >> testJorgeWinsAThreeLapGame [

	self do: 4 theGame: aThreeLapGame .
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianCancelsAnOverloadCardWhenIsNotHisTurn [
 | aGame squares aCancellationCard anOverloadCard |

    aCancellationCard  := CancellationCard new.
    anOverloadCard  := OverloadCard new.

    squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new.  EffectlessSquare new. DeliveryCardSquare new. }.

    	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ anOverloadCard. aCancellationCard }).
    self do: 2 theGame: aGame.
    aGame cardPlayedBy:jorge to:julian with: anOverloadCard  .
    aGame cardPlayedBy:julian to: anOverloadCard  with: aCancellationCard .
    self do: 2 theGame: aGame.

    self assert: (aGame numberOfSquareOf: julian) equals:4.
		
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianCannotCancelACardThatIsNotInTheGame [
    | aGame squares aCancellationCard anOverloadCard |

    aCancellationCard  := CancellationCard new.
		anOverloadCard := OverloadCard new.

    squares:= { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.  EffectlessSquare new. DeliveryCardSquare new. }.

    	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { aCancellationCard  }).

    self do: 3 theGame: aGame.

	self
		should: [ aGame cardPlayedBy:julian to: anOverloadCard with: aCancellationCard .]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'This card cannot be played because there are not active cards that match' ].
		
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsACancellationCardAndGetsRidOfOverloadCard [
    | aGame squares aCancellationCard anOverloadCard |

    aCancellationCard  := CancellationCard new.
    anOverloadCard  := OverloadCard new.

    squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new .  EffectlessSquare new. DeliveryCardSquare new. }.

    	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ anOverloadCard. aCancellationCard }).

    self do: 2 theGame: aGame.
    aGame cardPlayedBy:jorge to:julian with: anOverloadCard  .
    aGame turn.
    aGame cardPlayedBy:julian to: anOverloadCard with: aCancellationCard .
    aGame turn.

    self assert: (aGame numberOfSquareOf: julian) equals:4.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnOverloadCardAndPlaysIt [
    | aGame squares aReDoCard anOverloadCard |

    aReDoCard  := ReDoCard new.
    anOverloadCard  := OverloadCard new.
    squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new .  EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. }.

    	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { anOverloadCard. aReDoCard }).

    self do: 2 theGame: aGame.
	aGame cardPlayedBy:jorge to:julian with: anOverloadCard .
    self do: 3 theGame: aGame.
	aGame cardPlayedBy:julian to:jorge with: aReDoCard.
	self do: 2 theGame: aGame.

    self assert: (aGame numberOfSquareOf: jorge) equals:7.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsARepeatCardAndPlaysIt [
    | aGame squares aRepeatCard |

    aRepeatCard  := RepeatCard  new.
    squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new .  EffectlessSquare new. SpeedUpSquare new. EffectlessSquare new. EffectlessSquare new. }.

    	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ aRepeatCard}).

    self do: 2 theGame: aGame.
		aGame cardPlayedBy: jorge to: jorge with: aRepeatCard.

    self assert: (aGame numberOfSquareOf: jorge) equals:7.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToAtomicBombSquareWhenAPlayerIsAtSecondLap [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. AtomicBombSquare new. EffectlessSquare new.  EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(10 1 3 4 5)). (LoadedDice withValues: #(5 4 6 7))}  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
	self do: 2 theGame: aGame.
	
	self assert: (aGame lapOf:jorge) equals: 1.
	self assert: (aGame lapOf:julian) equals: 0.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToEffectlessSquareAndDoesntGetTheCard [
	| aGame squares aCard |
	
	aCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ aCard }).
	self do: 2 theGame: aGame.
	
	self assert: (aGame quantityOfCardInHandOf: julian) equals: 2.
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToSpeedUpSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares:squares withDeckOf: aDeck. 
	
	self do: 4 theGame: aGame.
	
	
	self assert: (aGame numberOfSquareOf: julian) equals: 3.

	
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianGetsToWormHoleSquare [

	| squares aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
	self do: 2 theGame: aGame.
	

	self assert: (aGame numberOfSquareOf: julian) equals: 4.
	
	
]

{ #category : #tests }
LudoMagicGameTest >> testJulianWinsAThreeLapGame [

	self do: 4 theGame: aThreeLapGame .
	
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #tests }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	self do: 5 theGame: anOneLapGame.
	
	self assert: (anOneLapGame numberOfSquareOf: jorge) equals: 1.
	self assert: (anOneLapGame numberOfSquareOf: julian) equals: 19.

]
