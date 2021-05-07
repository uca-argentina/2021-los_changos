Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'positions',
		'squares',
		'numberOfSquareToMove'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Board class >> playedBy: players withNumberOfLaps: laps with: size [
	^ self new
		initializeBoardPlayedBy: players
		withNumberOfLaps: laps
		with: size
]

{ #category : #'instance creation' }
Board class >> withSize: aSize and: laps and: aGroupOfPlayers [
	
	^ self new initializeWithSize: aSize and: laps and: aGroupOfPlayers 
]

{ #category : #accessing }
Board >> finished: aPlayer [ 
	^ (self positionOf: aPlayer) location  = (((squares size) * laps) +1)
]

{ #category : #initialization }
Board >> initializeBoardPlayedBy: aGroupOfPlayers withNumberOfLaps:  numberOfLaps with: aGroupOfSquare [
	positions := aGroupOfPlayers collect: [ :player |   Position assignedTo: player ].
	squares := aGroupOfSquare.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^(((self positionOf: aPlayer) location)-1) // (squares size).
]

{ #category : #action }
Board >> move: aPlayer to: squaresToMove [
	| currentSquare |
	(self positionOf: aPlayer) move: squaresToMove upTo: ((squares size) * laps)+1.
	
	numberOfSquareToMove := ((self positionOf:aPlayer)location % (squares size)).
	numberOfSquareToMove = 0 ifTrue: [ numberOfSquareToMove := 1 ].

	currentSquare:=squares at: numberOfSquareToMove.
	currentSquare makeEffectOn: aPlayer thatHasItsPositionIn: self.
]

{ #category : #accessing }
Board >> players [
	^ players copy.
]

{ #category : #accesing }
Board >> positionOf: aPlayer [ 
	^ positions detect: [ :aPosition | aPosition player = aPlayer  ]
]

{ #category : #accesing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]
