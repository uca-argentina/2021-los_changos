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
Board class >> buildSquares: size [

	| squares |
	squares := OrderedCollection new.
	squares add: WormHoleSquare new withOccurrences: (size * 0.2) ceiling.
	squares add: SpeedUpSquare new withOccurrences: (size * 0.2) ceiling.
	squares add: MoonWalkSquare new withOccurrences: (size * 0.1) ceiling.
	squares
		add: AtomicBombSquare new
		withOccurrences: (size * 0.02) ceiling.
	squares
		add: EffectlessSquare new
		withOccurrences: size - squares size - 1.
	squares shuffle.
	squares addFirst: EffectlessSquare new.
	
	^ squares
]

{ #category : #'instance creation - old' }
Board class >> playedBy: players withNumberOfLaps: laps andSize: size [
	| squares |
	self validatePlayers: players withNumberOfLaps: laps andSize: size.
	squares := self buildSquares: size.
	^ self new
		initializeBoardPlayedBy: players
		withNumberOfLaps: laps
		with: squares
]

{ #category : #'instance creation - old' }
Board class >> validatePlayers: players withNumberOfLaps: laps andSize: size [
	players size <= 1
		ifTrue: [ self error: 'There must be 2 or more players' ].
	laps < 1
		ifTrue: [ self error: 'Number of laps must be greater than 0' ].
	size < 5
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
Board >> initializeBoardPlayedBy: aGroupOfPlayers withNumberOfLaps:  numberOfLaps with: aGroupOfSquare [
	positions := aGroupOfPlayers collect: [ :player |   Position assignedTo: player ].
	squares := aGroupOfSquare.
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
