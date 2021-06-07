Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'dices',
		'finished',
		'board',
		'turnPlayer',
		'nextPlayerIndex',
		'lastSquarePlayed'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
LudoMagicGame class >> messageOfNoMoreRollsAllowed [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing: dices andWithBoardOfSquares: squares withDeckOf: aDeck [
	
	dices size = 0 ifTrue: [ self error: 'There must be dices'].

	^self new initializePlayedBy: players withNumberOfLaps: laps throwing: dices andWithBoardOfSquares: squares withDeckOf: aDeck.
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing: dices withSize: size [

		| squares  cardsOfVeryKind cards |
		
	squares := (ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 0.45 for: EffectlessSquare new .
		ProbabilisticEvent with: 0.15 for: WormHoleSquare new .
		ProbabilisticEvent with: 0.15 for: SpeedUpSquare new .
		ProbabilisticEvent with: 0.10 for: MoonWalkSquare new .
		ProbabilisticEvent with: 0.5 for: AtomicBombSquare new .
		ProbabilisticEvent with: 0.10 for: DeliveryCardSquare new .
	}) generate: size.
	

	"Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: size."

	^self playedBy: players withNumberOfLaps: laps throwing: dices andWithBoardOfSquares: squares withDeckOf: (Deck ofSize: 100).
]

{ #category : #action }
LudoMagicGame >> add: aCard to: aPlayer [ 
	
	board addEffectOf: aCard to: aPlayer.
	
]

{ #category : #actions }
LudoMagicGame >> addCardToAll: aCard [
	board addCardToAll:aCard.
	
]

{ #category : #action }
LudoMagicGame >> applyEffectOfTheLastPlayedSquaresTo: aPlayer [
	board applyEffectOfTheLastPlayedSquareTo: aPlayer.
]

{ #category : #action }
LudoMagicGame >> cardPlayedBy: aPlayer to: otherPlayer with: aCard [
	aCard acquireBehaviourOf: board lastCardPlayed.
	self validateThrowOf: aCard  from: aPlayer.
	aCard applyTo:otherPlayer in:self.
	self remove: aCard from: aPlayer.
	
	
]

{ #category : #validation }
LudoMagicGame >> checkIfRollsAreAllowed [
	finished
		ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ]
]

{ #category : #action }
LudoMagicGame >> do: numberOfTurnsToDo [
	1 to: (numberOfTurnsToDo) do: [ :number | self turn ]
]

{ #category : #accessing }
LudoMagicGame >> finished [
	^ finished.
]

{ #category : #boolean }
LudoMagicGame >> has: aPlayer theCard: aCard [ 
	^ board has: aPlayer theCard: aCard

]

{ #category : #initialization }
LudoMagicGame >> initializePlayedBy: players withNumberOfLaps: laps throwing: aGroupOfDices andWithBoardOfSquares: squares withDeckOf: aDeck [
	nextPlayerIndex:=2.
	finished:=false.
	dices:= aGroupOfDices.
	turnPlayer:= players at:1.
	board:= Board playedBy: players withNumberOfLaps:laps  with:squares and: aDeck.
]

{ #category : #accesing }
LudoMagicGame >> isTurnOf: aPlayer [ 
	^turnPlayer = aPlayer
]

{ #category : #accessing }
LudoMagicGame >> lapOf: player [ 
	^ board lapOf: player
]

{ #category : #accesing }
LudoMagicGame >> numberOfSquareOf: aPlayer [ 
	^ (board positionOf: aPlayer) numberOfSquare 
]

{ #category : #accessing }
LudoMagicGame >> numberOfSquaresToMove [
	| finalResult |
	finalResult := self throwDices: turnPlayer.
	finalResult := finalResult + (board cardHandlerOf: turnPlayer) effects.
	^ finalResult
]

{ #category : #accessing }
LudoMagicGame >> quantityOfCardInHandOf: aPlayer [
	^ (board cardHandlerOf: aPlayer) quantityOfCardInHand
]

{ #category : #action }
LudoMagicGame >> remove: aCard from: aPlayer [ 
	
	(board cardHandlerOf: aPlayer) remove: aCard.
]

{ #category : #action }
LudoMagicGame >> removePermanentCard: aCard from: aPlayer [ 
	board removePermanentCard: aCard from: aPlayer.
]

{ #category : #initialization }
LudoMagicGame >> size [
	^ board size
	
]

{ #category : #accesing }
LudoMagicGame >> squares [
	^board squares.
]

{ #category : #accessing }
LudoMagicGame >> throwDices: player [
	^(dices collect:[ :dice | dice roll ]) sum .
]

{ #category : #accessing }
LudoMagicGame >> turn [
	self checkIfRollsAreAllowed.
	board move: turnPlayer forward: self numberOfSquaresToMove.
	finished := board finished: turnPlayer.
	turnPlayer := board players at: nextPlayerIndex.
	nextPlayerIndex := (nextPlayerIndex rem: board players size) + 1
]

{ #category : #action }
LudoMagicGame >> validateThrowOf: aCard from: aPlayer [
	((self isTurnOf: aPlayer) or: aCard permanent not )
		ifFalse: [ self
				error: 'The player cannot throw this card because it is not his turn' ].
	((self has: aPlayer theCard: aCard))
		ifFalse: [ self
				error: 'The player cannot throw this card because he does not have it' ].
]

{ #category : #accessing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: 'There is no winner because game has not finished yet' ].
	^ board sortedPositions first player
]
