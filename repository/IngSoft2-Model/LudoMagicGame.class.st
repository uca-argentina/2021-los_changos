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

{ #category : #'instance creation' }
LudoMagicGame class >> messageOfNoMoreRollsAllowed [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing:dices andWithBoardOfSquares:squares [ .


	dices isEmpty ifTrue: [ self error: 'There must be dices' ].
	
	^self new initializePlayedBy: players withNumberOfLaps:laps throwing:dices andWithBoardOfSquares:squares .
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing: dices withSize: size [

		| squares |
	squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: size.
		
	^self playedBy: players withNumberOfLaps: laps throwing:  dices andWithBoardOfSquares: squares.
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

{ #category : #initialization }
LudoMagicGame >> initializePlayedBy:players withNumberOfLaps:laps throwing:aGroupOfDices andWithBoardOfSquares:squares [ 
	nextPlayerIndex:=2.
	finished:=false.
	dices:= aGroupOfDices.
	turnPlayer:= players at:1.
	board:= Board playedBy: players withNumberOfLaps:laps  andWith:squares. 
	
]

{ #category : #accessing }
LudoMagicGame >> lapOf: player [ 
	^ board lapOf: player
]

{ #category : #accesing }
LudoMagicGame >> numberOfSquareOf: aPlayer [ 
	^ (board positionOf: aPlayer) numberOfSquare 
]

{ #category : #accesing }
LudoMagicGame >> squares [
	^board squares.
]

{ #category : #accessing }
LudoMagicGame >> throwDices: player [
	^ player throws: dices
]

{ #category : #accessing }
LudoMagicGame >> turn [
    self checkIfRollsAreAllowed.
		board move:turnPlayer forward:(self throwDices:turnPlayer).
		finished:= board finished:turnPlayer.
		turnPlayer:=(board players) at: nextPlayerIndex.
		nextPlayerIndex:=(nextPlayerIndex rem: board players size) +1.
]

{ #category : #accessing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: 'There is no winner because game has not finished yet' ].
	^ board sortedPositions first player
]
