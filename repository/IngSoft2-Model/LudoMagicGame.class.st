Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'dices',
		'finished',
		'players',
		'board'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
LudoMagicGame class >> messageOfNoMoreRollsAllowed [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'as yet unclassified' }
LudoMagicGame class >> throwing: dices withBoard: board [
	
	dices isEmpty ifTrue: [ self error: 'There must be dices' ].
	
	
	^self new initializeGameWith: dices on: board.
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
LudoMagicGame >> initializeGameWith: aGroupOfDices on: aBoard [
	finished:=false.
	dices:= aGroupOfDices.
	board:= aBoard.
	
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
