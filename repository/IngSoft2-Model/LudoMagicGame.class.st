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

{ #category : #actions }
LudoMagicGame >> addEffectToAllOf: aCard [
	board addEffectToAllOf:aCard.
	
]

{ #category : #action }
LudoMagicGame >> applyEffectOfTheLastPlayedSquaresTo: aPlayer [
	board applyEffectOfTheLastPlayedSquareTo: aPlayer.
]

{ #category : #action }
LudoMagicGame >> cardPlayedBy: aPlayer to: aTarget with: aCard [
	aCard applyTo:aTarget in:self from:aPlayer.
	self remove: aCard from: aPlayer.
	
	
]

{ #category : #validation }
LudoMagicGame >> checkIfRollsAreAllowed [
	finished
		ifTrue: [ self error: LudoMagicGame messageOfNoMoreRollsAllowed ]
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

{ #category : #actions }
LudoMagicGame >> lastCardPlayed [
	^board lastCardPlayed.
]

{ #category : #accesing }
LudoMagicGame >> numberOfSquareOf: aPlayer [ 
	^ (board positionOf: aPlayer) numberOfSquare 
]

{ #category : #accessing }
LudoMagicGame >> numberOfSquaresToMove [
	| finalResult |
	finalResult := self throwDices: turnPlayer.
	finalResult := finalResult + (board cardHandlerOf: turnPlayer) totalEffectsOnPlayer.
	^ finalResult
]

{ #category : #accessing }
LudoMagicGame >> quantityOfCardInHandOf: aPlayer [
	^ (board cardHandlerOf: aPlayer) quantityOfCardInHand
]

{ #category : #action }
LudoMagicGame >> remove: aCard from: aPlayer [ 
	
	(board cardHandlerOf: aPlayer) removeFromHand: aCard.
]

{ #category : #action }
LudoMagicGame >> removePermanentCard: aTarget [
	board removePermanentCard: aTarget
]

{ #category : #action }
LudoMagicGame >> removePermanentCard: aCard from: aPlayer [ 
	board removePermanentCard: aCard from: aPlayer.
]

{ #category : #initialization }
LudoMagicGame >> size [
	^ board size
	
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
LudoMagicGame >> validate: aPlayer has: aCard [.
	((self has: aPlayer theCard: aCard))
        ifFalse: [ self
                error: 'The player cannot throw this card because he does not have it' ].
]

{ #category : #action }
LudoMagicGame >> validateIsTurnOf: aPlayer [
	((self isTurnOf: aPlayer))
		ifFalse: [ self
				error: 'The player cannot throw this card because it is not his turn' ].
]

{ #category : #action }
LudoMagicGame >> validateThrowOfAPermanent: aCard from: aPlayer [
	self validateIsTurnOf: aPlayer.
	self validate: aPlayer has: aCard.
]

{ #category : #action }
LudoMagicGame >> validateThrowOfAnInstantaneous: aCard from: aPlayer [
		self validate: aPlayer has: aCard.
]

{ #category : #accessing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: 'There is no winner because game has not finished yet' ].
	^ board sortedPositions first player
]
