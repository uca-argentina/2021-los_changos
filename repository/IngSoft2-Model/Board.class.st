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

{ #category : #'instance creation - old' }
Board class >> playedBy: players withNumberOfLaps: laps andSize: size [
	| squares |
	squares := OrderedCollection new.
	squares add: WormHoleSquare new withOccurrences:  (size*0.20) ceiling .
	squares add: SpeedUpSquare new withOccurrences: (size*0.20) ceiling .
	squares add: MoonWalkSquare new withOccurrences:  (size*0.1) ceiling .
	squares add: AtomicBombSquare new withOccurrences: (size*0.02) ceiling .
	squares add: EffectlessSquare new withOccurrences: (size - squares size).
	squares shuffle.
	
	^ self new initializeBoardPlayedBy: players withNumberOfLaps:  laps with: squares
]

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

{ #category : #initialization }
Board >> initializePlayedBy:  groupOfPlayers withNumberOfLaps: numberOfLaps andSize: size [ 
	players := groupOfPlayers.
	laps := numberOfLaps.
	
	
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
Board >> size [ 
	^ (laps * (squares size))
]

{ #category : #accesing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]

{ #category : #accesing }
Board >> squares [
	^ squares
]
