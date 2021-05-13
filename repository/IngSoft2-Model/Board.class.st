Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'positions',
		'squares'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation - old' }
Board class >> playedBy: players withNumberOfLaps: laps andWith: squares [
	
	self validatePlayers: players withNumberOfLaps: laps andWith: squares.

	^ self new
		initializeBoardPlayedBy: players
		withNumberOfLaps: laps
		andWith: squares
]

{ #category : #'instance creation - old' }
Board class >> validateLaps: laps [
	laps < 1
		ifTrue: [ self error: 'Number of laps must be greater than 0' ]
]

{ #category : #'instance creation - old' }
Board class >> validatePlayers: players [
	players size <= 1
		ifTrue: [ self error: 'There must be 2 or more players' ]
]

{ #category : #'instance creation - old' }
Board class >> validatePlayers: players withNumberOfLaps: laps andWith: squares [
	self validatePlayers: players.
	self validateLaps: laps.
	self validateSquares: squares
]

{ #category : #'instance creation - old' }
Board class >> validateSquares: squares [
	squares size < 4
		ifTrue: [ self error: 'Size must be greater than 4' ]
]

{ #category : #accessing }
Board >> currentSquare: playerPosition [
     | numberOfSquareToAdvance |
	numberOfSquareToAdvance := playerPosition quantityOfSquaresAdvanced % squares size.
	numberOfSquareToAdvance = 0 ifTrue: [ numberOfSquareToAdvance := 1 ].
	^ numberOfSquareToAdvance
]

{ #category : #accessing }
Board >> finished: aPlayer [
	^ (self quantityOfSquaresAdvancedBy: aPlayer) = self limit
]

{ #category : #initialization }
Board >> initializeBoardPlayedBy: aGroupOfPlayers withNumberOfLaps:  numberOfLaps andWith: aGroupOfSquares [
	positions := aGroupOfPlayers collect: [ :player |   Position assignedTo: player ].
	squares := aGroupOfSquares.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^ ( (self quantityOfSquaresAdvancedBy: aPlayer) - 1) // (squares size).
]

{ #category : #accessing }
Board >> limit [
	^ self quantityOfSquaresToAdvance + 1
]

{ #category : #actions }
Board >> move: aPlayer backwards: numberOfSquares [
	(self positionOf: aPlayer) moveBackwards: numberOfSquares.
]

{ #category : #actions }
Board >> move: aPlayer forward: squaresToMove [
	| currentSquare playerPosition |
	playerPosition := self positionOf: aPlayer.
	playerPosition movePlayerForward: squaresToMove upTo: self limit.
	currentSquare := squares at: (self currentSquare: playerPosition ).
	currentSquare makeEffectOn: aPlayer thatHasItsPositionIn: self
]

{ #category : #accessing }
Board >> players [
	^ players copy.
]

{ #category : #accessing }
Board >> positionOf: aPlayer [ 
	^ positions detect: [ :aPosition | aPosition player = aPlayer  ]
]

{ #category : #accessing }
Board >> quantityOfSquaresAdvancedBy: aPlayer [
	^ (self positionOf: aPlayer) quantityOfSquaresAdvanced
]

{ #category : #accessing }
Board >> quantityOfSquaresToAdvance [
	^ (laps * (squares size))
]

{ #category : #actions }
Board >> restartAllPlayers [
	positions do:[:position | position restart].
]

{ #category : #accessing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]

{ #category : #accessing }
Board >> squares [
	^ squares
]
