Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'dices',
		'finished',
		'board'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
LudoMagicGame class >> messageOfNoMoreRollsAllowed [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'as yet unclassified' }
LudoMagicGame class >> playedBy: players withNumberOfLaps: laps throwing:dices andWithBoardOfSquares:squares [ .


	dices isEmpty ifTrue: [ self error: 'There must be dices' ].
	
	^self new initializePlayedBy: players withNumberOfLaps:laps throwing:dices andWithBoardOfSquares:squares .
]

{ #category : #validation }
LudoMagicGame >> checkIfRollsAreAllowed [
	finished
		ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ]
]

{ #category : #accessing }
LudoMagicGame >> finished [
	^ finished.
]

{ #category : #initialization }
LudoMagicGame >> initializePlayedBy:players withNumberOfLaps:laps throwing:aGroupOfDices andWithBoardOfSquares:squares [ 
	finished:=false.
	dices:= aGroupOfDices.
	board:= Board playedBy: players withNumberOfLaps:laps  andWith:squares. 
	
]

{ #category : #accessing }
LudoMagicGame >> lapOf: player [ 
	^ board lapOf: player
]

{ #category : #accessing }
LudoMagicGame >> round [
	self checkIfRollsAreAllowed.
	self throwDices 
]

{ #category : #accessing }
LudoMagicGame >> squaresAdvancedBy: player [ 
	^ board quantityOfSquaresAdvancedBy: player 
]

{ #category : #accessing }
LudoMagicGame >> throwDices [
	board players
		do: [ :player | 
			finished
				ifFalse: [ board move: player forward: (player throws: dices).
					finished := board finished: player ] ]
]

{ #category : #accessing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: 'There is no winner because game has not finished yet' ].
	^ board sortedPositions first player
]
