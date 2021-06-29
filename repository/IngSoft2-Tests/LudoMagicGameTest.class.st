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

{ #category : #support }
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

{ #category : #'exception tests' }
LudoMagicGameTest >> testAGameCannotHaveAWinnerIfItIsNotFinished [

	self do: 2 theGame: anOneLapGame.
	self should: [anOneLapGame winner] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame noWinnerErrorMessage ].

]

{ #category : #'exception tests' }
LudoMagicGameTest >> testAGameCannotHaveAWinnerWhenItIsNew [

	self
		should: [anOneLapGame winner] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame noWinnerErrorMessage  ].
			
		
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testAGameCannotHaveNoDices [
	self
		should: [ LudoMagicGame playedBy: players withNumberOfLaps:3  throwing: {}  withSize: 6 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame noDicesErrorMessage ].
		
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testAGameCannotMakeARoundWhenItIsFinished [
	

	self do: 5 theGame: anOneLapGame .
	
	self
		should: [ anOneLapGame turn]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame noMoreRollsAllowedErrorMessage. ].
]

{ #category : #'main tests' }
LudoMagicGameTest >> testAGameHasAWinner [
	self do: 5 theGame: anOneLapGame .
	
	self assert: anOneLapGame winner equals: jorge.
]

{ #category : #'main tests' }
LudoMagicGameTest >> testAGameHasTheRightSize [
	| aGame |
	aGame := LudoMagicGame playedBy: players withNumberOfLaps: 3 throwing: dices withSize: 100.
	self assert: aGame size equals: 100.
]

{ #category : #'main tests' }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayers [
	self do: 2 theGame: anOneLapGame .
	
	self assert: (anOneLapGame numberOfSquareOf:jorge) equals: 6.
	self assert: (anOneLapGame numberOfSquareOf:julian) equals: 8.
]

{ #category : #'main tests' }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithEnoughPoints [
	
	| someDices |
	
	someDices := OrderedCollection
		with: (LoadedDice withValues: #(1 2 4 1 5))
		with: (LoadedDice withValues: #(4 5 1 1)).
	

	anOneLapGame := LudoMagicGame playedBy:players  withNumberOfLaps:1  throwing:someDices   andWithBoardOfSquares:(OrderedCollection new:10 withAll: EffectlessSquare new) withDeckOf: aDeck. 
	
	self do: 3 theGame: anOneLapGame .
	

	self assert: anOneLapGame finished
]

{ #category : #'main tests' }
LudoMagicGameTest >> testAGameRollsTheDiceForThePlayersTwiceAndIsFinishedWithMoreThanEnoughPoints [
	self do: 5 theGame: anOneLapGame .
	
	self assert: anOneLapGame finished
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testAGameThatGiveToPlayersTwoCards [
	| aGame |
	aGame := LudoMagicGame playedBy: players withNumberOfLaps: 3 throwing: dices withSize: 100.
	self assert: (aGame quantityOfCardInHandOf: julian) equals: 2.
	self assert: (aGame quantityOfCardInHandOf: jorge) equals: 2.
]

{ #category : #'main tests' }
LudoMagicGameTest >> testANewGameIsNotFinished [
	self deny: anOneLapGame finished
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testAThreeLapGameCannotMakeAnotherRoundWhenItIsFinished [
	self do: 4 theGame: aThreeLapGame .
	self
		should: [aThreeLapGame turn] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: LudoMagicGame noMoreRollsAllowedErrorMessage ].
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeAndJulianGotDifferentsCards [
	| aGame squares aCard anotherCard |
	
	aCard := Card new.
	anotherCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. DeliveryCardSquare new. }.
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: { aCard . anotherCard }).
	
	self do: 2 theGame: aGame.
	
	self assert: (aGame has: jorge the: aCard).
	self assert: (aGame has: julian the: anotherCard)
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testJorgeCannotThrowAnOverloadCardThatHeDoesNotHave [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	self do: 2 theGame: aGame.
	self
		should: [ aGame affect: julian using: SpeedCard new by: jorge ]
		raise: Error
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: LudoMagicGame cardNotInHandErrorMessage ]
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testJorgeCannotThrowAnOverloadCardWhenItIsNotHisTurn [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	aGame turn.
	self
		should: [ aGame affect: julian using: anOverloadCard by: jorge ]
		raise: Error
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: LudoMagicGame notCurrentTurnErrorMessage ]
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsARepeatCardAndPlaysItWithAtomicBombSquare [
	| aGame squares aRepeatCard |
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	AtomicBombSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aRepeatCard}).
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	self assert: (aGame numberOfSquareOf: julian) equals: 1.
	self assert: (aGame numberOfSquareOf: jorge) equals: 1
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsARepeatCardAndPlaysItWithDeliveryCardSquare [
	| aGame squares aRepeatCard |
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aRepeatCard}).
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	self assert: (aGame has: jorge the: aRepeatCard )
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsARepeatCardAndPlaysItWithMoonWalkSquare [
	| aGame squares aRepeatCard |
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	MoonWalkSquare with: 1.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aRepeatCard}).
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	self assert: (aGame numberOfSquareOf: julian) equals: 4.
	self assert: (aGame numberOfSquareOf: jorge) equals: 2
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsARepeatCardAndPlaysItWithSpeedUpSquare [
	| aGame squares aRepeatCard |
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	SpeedUpSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aRepeatCard}).
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	self assert: (aGame numberOfSquareOf: jorge) equals: 7
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsARepeatCardAndPlaysItWithWormHoleSquare [
	| aGame squares aRepeatCard |
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	WormHoleSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aRepeatCard}).
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	self assert: (aGame numberOfSquareOf: jorge) equals: 1
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsASpeedCardAndThrowItToJulian [
	| aGame squares aSpeedCard |
	aSpeedCard := SpeedCard new.
	squares := {EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aSpeedCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: aSpeedCard by: jorge.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: julian) equals: 5
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsAnAccelerationAndAffectsAllPlayers [
	| aGame squares anAccelerationCard |
	anAccelerationCard := AccelerationCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anAccelerationCard}).
	self do: 2 theGame: aGame.
	aGame affect: players using: anAccelerationCard by: jorge.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: julian) equals: 5.
	self assert: (aGame numberOfSquareOf: jorge) equals: 1
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeGetsAnOverloadCardAndThrowItToJulian [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: julian) equals: 2
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJorgeGetsToAMoonWalkAndGoesToTheFirstSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. MoonWalkSquare with: 5. EffectlessSquare new. EffectlessSquare new.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(9 2 4 5))}  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
	aGame turn.
	aGame turn.
	self assert: (aGame lapOf:jorge) equals: 0.
	self assert: (aGame numberOfSquareOf: jorge) equals: 5.
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJorgeGetsToAtomicBombSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	dices:= OrderedCollection with: (LoadedDice withValues: #(1 2 3 4 5)) with: (LoadedDice withValues: #(4 5 6 7)).
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares withDeckOf: aDeck.
	
	aGame turn.
	
	self assert: (aGame numberOfSquareOf:jorge) equals: 1.
	
	
	
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJorgeGetsToLoadedSquareAndGetACard [
	| aGame squares aCard |
	
	aCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new.}.
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards: {aCard}).
	
	self do: 2 theGame: aGame .
	
	self assert: (aGame has: jorge the: aCard).
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJorgeGetsToMoonWalkSquare [

	| squares  aGame |
	squares := { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices andWithBoardOfSquares:squares withDeckOf: aDeck.
	
	self do: 3 theGame: aGame .
		
	self assert: (aGame numberOfSquareOf:jorge) equals: 10.

	
	
	
]

{ #category : #'main tests' }
LudoMagicGameTest >> testJorgeIsAtTheLapOneAndJulianIsAtTheLapZero [

	self do: 2 theGame: aThreeLapGame  .

	self assert: (aThreeLapGame lapOf: jorge) equals: 0.
	self assert: (aThreeLapGame lapOf: julian) equals: 1.
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJorgeThrowsAnOverloadCardAndDoesntHaveItAnymore [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	self assert: (aGame quantityOfCardInHandOf: jorge) equals: 2
]

{ #category : #'main tests' }
LudoMagicGameTest >> testJorgeWinsAThreeLapGame [

	self do: 4 theGame: aThreeLapGame .
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianCancelsAnOverloadCardWhenIsNotHisTurn [
	| aGame squares aCancellationCard anOverloadCard |
	aCancellationCard := CancellationCard new.
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anOverloadCard.
					aCancellationCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	aGame affect: anOverloadCard using: aCancellationCard by: julian.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: julian) equals: 4
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testJulianCannotCancelACardThatIsNotInTheGame [
	| aGame squares aCancellationCard anOverloadCard |
	aCancellationCard := CancellationCard new.
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aCancellationCard}).
	self do: 3 theGame: aGame.
	self
		should:
			[ aGame affect: anOverloadCard using: aCancellationCard by: julian ]
		raise: Error
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: CardHandler noCardMatchErrorMessage ]
]

{ #category : #'exception tests' }
LudoMagicGameTest >> testJulianCannotThrowAReDoCardBecauseThereWasNoCardPlayedBefore [
	| aGame squares aReDoCard |
	aReDoCard := ReDoCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	SpeedUpSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {aReDoCard}).
	self
		should: [ aGame affect: jorge using: aReDoCard by: jorge ]
		raise: Error
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: LudoMagicGame noActiveCardsErrorMessage ]
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsACancellationCardAndGetsRidOfAccelerationCard [
	| aGame squares aCancellationCard anAccelerationCard |
	aCancellationCard := CancellationCard new.
	anAccelerationCard := AccelerationCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anAccelerationCard.
					aCancellationCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anAccelerationCard by: jorge.
	aGame turn.
	aGame affect: anAccelerationCard using: aCancellationCard by: julian.
	aGame turn.
	self assert: (aGame numberOfSquareOf: jorge) equals: 1.
	self assert: (aGame numberOfSquareOf: julian) equals: 4
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsACancellationCardAndGetsRidOfOverloadCard [
	| aGame squares aCancellationCard anOverloadCard |
	aCancellationCard := CancellationCard new.
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anOverloadCard.
					aCancellationCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	aGame turn.
	aGame affect: anOverloadCard using: aCancellationCard by: julian.
	aGame turn.
	self assert: (aGame numberOfSquareOf: julian) equals: 4
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsACancellationCardAndGetsRidOfSpeedCard [
	| aGame squares aCancellationCard aSpeedCard |
	aCancellationCard := CancellationCard new.
	aSpeedCard := SpeedCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{aSpeedCard.
					aCancellationCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: aSpeedCard by: jorge.
	aGame turn.
	aGame affect: aSpeedCard using: aCancellationCard by: julian.
	aGame turn.
	self assert: (aGame numberOfSquareOf: julian) equals: 4.
	self assert: (aGame numberOfSquareOf: jorge) equals: 5
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnAccelerationCardAndPlaysIt [
	| aGame squares aReDoCard anAccelerationCard |
	aReDoCard := ReDoCard new.
	anAccelerationCard := AccelerationCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anAccelerationCard.
					aReDoCard}).
	aGame affect: jorge using: anAccelerationCard by: jorge.
	self do: 1 theGame: aGame.
	aGame affect: julian using: aReDoCard by: julian.
	self do: 1 theGame: aGame.

	self assert: (aGame numberOfSquareOf: julian) equals: 2.
	self assert: (aGame numberOfSquareOf: jorge) equals: 4
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnCancellationCardAndPlaysIt_TO_FIX [
	| aGame squares aReDoCard aCancellationCard anOverloadCard |
	aReDoCard := ReDoCard new.
	aCancellationCard := CancellationCard new.
	anOverloadCard := OverloadCard new.
	squares := {
		EffectlessSquare new.
		EffectlessSquare new.
		DeliveryCardSquare new.
		DeliveryCardSquare new.
		DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anOverloadCard . aCancellationCard.
					aReDoCard}).
	self do: 4 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	self do: 1 theGame: aGame.
	aGame affect: anOverloadCard using: aCancellationCard by: julian.
	aGame affect: jorge using: anOverloadCard by: julian.
	self do: 2 theGame: aGame.
	aGame affect: jorge using: aReDoCard by: julian.
	self do: 1 theGame: aGame.
	
	self assert: (aGame numberOfSquareOf: julian) equals: 2.
	self assert: (aGame numberOfSquareOf: jorge) equals: 2
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnOverloadCardAndPlaysIt [
	| aGame squares aReDoCard anOverloadCard |
	aReDoCard := ReDoCard new.
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{anOverloadCard.
					aReDoCard}).
	self do: 2 theGame: aGame.
	aGame affect: julian using: anOverloadCard by: jorge.
	self do: 1 theGame: aGame.
	aGame affect: jorge using: aReDoCard by: julian.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: julian) equals: 2.
	self assert: (aGame numberOfSquareOf: jorge) equals: 5
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnRepeatCardAndPlaysIt [
	| aGame squares aReDoCard aRepeatCard |
	aReDoCard := ReDoCard new.
	aRepeatCard := RepeatCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	DeliveryCardSquare new.
	SpeedUpSquare new.
	DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{aRepeatCard.
					aReDoCard}).
	self do: 4 theGame: aGame.
	aGame affect: jorge using: aRepeatCard by: jorge.
	aGame affect: julian using: aReDoCard by: julian.
	self assert: (aGame numberOfSquareOf: julian) equals: 2
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAReDoCardAfterJorgeThrewAnSpeedCardAndPlaysIt [
	| aGame squares aReDoCard aSpeedCard |
	aReDoCard := ReDoCard new.
	aSpeedCard := SpeedCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{aSpeedCard.
					aReDoCard}).
	aGame affect: jorge using: aSpeedCard by: jorge.
	self do: 1 theGame: aGame.
	aGame affect: julian using: aReDoCard by: julian.
	self do: 1 theGame: aGame.

	self assert: (aGame numberOfSquareOf: julian) equals: 1.
	self assert: (aGame numberOfSquareOf: jorge) equals: 4.
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsAnOverloadCardAndThrowItToJorge [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 2
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	self do: 3 theGame: aGame.
	aGame affect: jorge using: anOverloadCard by: julian.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: jorge) equals: 5
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJulianGetsToAtomicBombSquareWhenAPlayerIsAtSecondLap [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. AtomicBombSquare new. EffectlessSquare new.  EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(10 1 3 4 5)). (LoadedDice withValues: #(5 4 6 7))}  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
	self do: 2 theGame: aGame.
	
	self assert: (aGame lapOf:jorge) equals: 1.
	self assert: (aGame lapOf:julian) equals: 0.
	
	
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJulianGetsToEffectlessSquareAndDoesntGetTheCard [
	| aGame squares aCard |
	
	aCard := Card new.
	
	squares:= { EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. EffectlessSquare new. EffectlessSquare new. }.
	
		aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing: {(LoadedDice withValues: #(1 2)). (LoadedDice withValues: #(1 2))} andWithBoardOfSquares: squares withDeckOf: (LoadedDeck withCards:{ aCard }).
	self do: 2 theGame: aGame.
	
	self assert: (aGame quantityOfCardInHandOf: julian) equals: 2.
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJulianGetsToSpeedUpSquare [

	| squares  aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. AtomicBombSquare new. MoonWalkSquare with: 5. EffectlessSquare new. SpeedUpSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares:squares withDeckOf: aDeck. 
	
	self do: 4 theGame: aGame.
	
	
	self assert: (aGame numberOfSquareOf: julian) equals: 3.

	
	
	
]

{ #category : #'squares usage tests' }
LudoMagicGameTest >> testJulianGetsToWormHoleSquare [

	| squares aGame |
	squares:= { EffectlessSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. AtomicBombSquare new. AtomicBombSquare new. EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. EffectlessSquare new. AtomicBombSquare new. MoonWalkSquare with:3.}.
	
	aGame:= LudoMagicGame playedBy: players withNumberOfLaps:2  throwing:dices  andWithBoardOfSquares: squares withDeckOf: aDeck. 
	
	self do: 2 theGame: aGame.
	

	self assert: (aGame numberOfSquareOf: julian) equals: 4.
	
	
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianGetsTwoOverloadsCardAndThrowsThemToJorge [
	| aGame squares anOverloadCard |
	anOverloadCard := OverloadCard new.
	squares := {EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. DeliveryCardSquare new. DeliveryCardSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 3
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf: (LoadedDeck withCards: {anOverloadCard}).
	self do: 3 theGame: aGame.
	aGame affect: jorge using: anOverloadCard by: julian.
	self do: 2 theGame: aGame.
	aGame affect: jorge using: anOverloadCard by: julian.
	self do: 2 theGame: aGame.
	self assert: (aGame numberOfSquareOf: jorge) equals: 3
]

{ #category : #'card usage tests' }
LudoMagicGameTest >> testJulianThrowsAReDoCardAndNoLongerHasItInHisHand [
	| aGame squares aReDoCard aSpeedCard |
	aReDoCard := ReDoCard new.
	aSpeedCard := SpeedCard new.
	squares := {EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new.
	EffectlessSquare new}.
	aGame := LudoMagicGame
		playedBy: players
		withNumberOfLaps: 4
		throwing:
			{(LoadedDice withValues: #(1 2)).
			(LoadedDice withValues: #(1 2))}
		andWithBoardOfSquares: squares
		withDeckOf:
			(LoadedDeck
				withCards:
					{aSpeedCard.
					aReDoCard}).
	aGame affect: jorge using: aSpeedCard by: jorge.
	aGame affect: jorge using: aReDoCard by: jorge.
	self deny: (aGame has: jorge the: aSpeedCard).
	self deny: (aGame has: jorge the: aReDoCard)
]

{ #category : #'main tests' }
LudoMagicGameTest >> testJulianWinsAThreeLapGame [

	self do: 4 theGame: aThreeLapGame .
	
	self assert: aThreeLapGame winner equals: julian.
	self assert: (aThreeLapGame lapOf: julian) equals: 3.
]

{ #category : #'main tests' }
LudoMagicGameTest >> testWhenAPlayerWinsTheOtherPlayersDoesNotRollTheDice [
	self do: 5 theGame: anOneLapGame.
	
	self assert: (anOneLapGame numberOfSquareOf: jorge) equals: 1.
	self assert: (anOneLapGame numberOfSquareOf: julian) equals: 19.

]
