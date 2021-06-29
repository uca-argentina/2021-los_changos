Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'dices',
		'finished',
		'board',
		'turnPlayer',
		'nextPlayerIndex'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'error message' }
LudoMagicGame class >> cardNotInHandErrorMessage [
	^ 'The player cannot throw this card because he does not have it'
]

{ #category : #'error message' }
LudoMagicGame class >> noActiveCardsErrorMessage [
	^ 'This card cannot be played because there was no card played before'
]

{ #category : #'error message' }
LudoMagicGame class >> noDicesErrorMessage [
	^ 'There must be dices'
]

{ #category : #'error message' }
LudoMagicGame class >> noMoreRollsAllowedErrorMessage [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'error message' }
LudoMagicGame class >> noWinnerErrorMessage [
	^ 'There is no winner because game has not finished yet'
]

{ #category : #'error message' }
LudoMagicGame class >> notCurrentTurnErrorMessage [
	^'The player cannot throw this card because it is not his turn' 
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing: dices andWithBoardOfSquares: squares withDeckOf: aDeck [
	
	dices isEmpty ifTrue: [ self error: self noDicesErrorMessage ].

	^self new initializePlayedBy: players withNumberOf: laps throwing: dices andWithBoardOf: squares with: aDeck.
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing: dices withSize: size [

		| squares aDeck |
		
	squares := (ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 0.38 for: EffectlessSquare new .
		ProbabilisticEvent with: 0.20 for: WormHoleSquare new .
		ProbabilisticEvent with: 0.20 for: SpeedUpSquare new .
		ProbabilisticEvent with: 0.10 for: MoonWalkSquare new .
		ProbabilisticEvent with: 0.02 for: AtomicBombSquare new .
		ProbabilisticEvent with: 0.10 for: DeliveryCardSquare new .
	}) generate: size.
	
	aDeck := Deck with: (Card subclasses collect: [ :aKindOfCard | aKindOfCard new ]).
		
	^self playedBy: players withNumberOfLaps: laps throwing: dices andWithBoardOfSquares: squares withDeckOf: aDeck.
]

{ #category : #action }
LudoMagicGame >> addEffectOf: aCard to: aPlayer [ 
	board addEffectOf: aCard to: aPlayer.
	
]

{ #category : #action }
LudoMagicGame >> addInHand: aCard to: aPlayer [
	board addInHand: aCard to: aPlayer.
]

{ #category : #action }
LudoMagicGame >> addToAllEffectOf: aCard [
	board addToAllEffectOf:aCard.
	
]

{ #category : #action }
LudoMagicGame >> affect: aTarget using: aCard by: aPlayer [
	aCard applyTo:aTarget in:self from:aPlayer.
	self removeFromHand: aCard of: aPlayer.
	
	
]

{ #category : #action }
LudoMagicGame >> applyEffectOfTheLastPlayedSquareTo: aPlayer from:aCard [
	board applyEffectOfTheLastPlayedSquareTo: aPlayer from:aCard.
	
]

{ #category : #accessing }
LudoMagicGame >> finished [
	^ finished.
]

{ #category : #boolean }
LudoMagicGame >> has: aPlayer the: aCard [ 
	^ board has: aPlayer the: aCard

]

{ #category : #initialization }
LudoMagicGame >> initializePlayedBy: players withNumberOf: laps throwing: aGroupOfDices andWithBoardOf: squares with: aDeck [
	nextPlayerIndex := 2.
	finished := false.
	dices := aGroupOfDices.
	turnPlayer := players at: 1.
	board := Board
		playedBy: players
		with: squares
		andCardsFrom: aDeck
		finishingAfter: laps
]

{ #category : #boolean }
LudoMagicGame >> isTurnOf: aPlayer [ 
	^turnPlayer = aPlayer
]

{ #category : #accessing }
LudoMagicGame >> lapOf: player [ 
	^ board lapOf: player
]

{ #category : #action }
LudoMagicGame >> lastCardPlayed [
	^board lastCardPlayed.
]

{ #category : #accessing }
LudoMagicGame >> numberOfSquareOf: aPlayer [ 
	^ (board positionOf: aPlayer) numberOfSquare 
]

{ #category : #accessing }
LudoMagicGame >> numberOfSquaresToMove [
	| finalResult |
	finalResult := self throwDices.
	finalResult := finalResult + (board cardHandlerOf: turnPlayer) totalEffectsOnPlayer.
	^ finalResult
]

{ #category : #accessing }
LudoMagicGame >> quantityOfCardInHandOf: aPlayer [
	^ (board cardHandlerOf: aPlayer) quantityOfCardsInHand
]

{ #category : #action }
LudoMagicGame >> removeFromHand: aCard of: aPlayer [ 
	board removeFromHand: aCard to: aPlayer
]

{ #category : #action }
LudoMagicGame >> removeToAllPlayersPermanent: aCard [
	board removeToAllPlayersPermanent: aCard
]

{ #category : #initialization }
LudoMagicGame >> size [
	^ board size
	
]

{ #category : #accessing }
LudoMagicGame >> throwDices [
	^(dices collect:[ :dice | dice roll ]) sum .
]

{ #category : #accessing }
LudoMagicGame >> turn [
	self validateIfRollsAreAllowed.
	board move: turnPlayer forward: self numberOfSquaresToMove.
	finished := board finished: turnPlayer.
	turnPlayer := board players at: nextPlayerIndex.
	nextPlayerIndex := (nextPlayerIndex rem: board players size) + 1
]

{ #category : #validation }
LudoMagicGame >> validate: aPlayer has: aCard [.
	(self has: aPlayer the: aCard)
        ifFalse: [ self
                error: self class cardNotInHandErrorMessage ].
]

{ #category : #validation }
LudoMagicGame >> validateIfRollsAreAllowed [
	finished
		ifTrue: [ self error: self class noMoreRollsAllowedErrorMessage ]
]

{ #category : #validation }
LudoMagicGame >> validateIsTurnOf: aPlayer [
	(self isTurnOf: aPlayer)
		ifFalse: [ self
				error: self class notCurrentTurnErrorMessage  ].
]

{ #category : #validation }
LudoMagicGame >> validateThrowOfAPermanent: aCard from: aPlayer [
	self validateIsTurnOf: aPlayer.
	self validate: aPlayer has: aCard.
]

{ #category : #validation }
LudoMagicGame >> validateThrowOfAnInstantaneous: aCard from: aPlayer [
		self validate: aPlayer has: aCard.
]

{ #category : #accessing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: self class noWinnerErrorMessage  ].
	^ board sortedPositions first player
]
