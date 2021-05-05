Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'size',
		'laps',
		'players',
		'positions'
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

{ #category : #accessing }
Board >> finished: aPlayer [ 
	^ (self positionOf: aPlayer) location  = (size * laps)
]

{ #category : #initialization }
Board >> initializeBoardPlayedBy: aGroupOfPlayers withNumberOfLaps:  numberOfLaps with: aSize [
	positions := aGroupOfPlayers collect: [ :player |   Position assignedTo: player ].
	size := aSize.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^ ( (self positionOf: aPlayer) location  ) // size
]

{ #category : #action }
Board >> move: aPlayer to: squaresToMove [
	(self positionOf: aPlayer) move: squaresToMove upTo: size * laps.
]

{ #category : #accesing }
Board >> positionOf: aPlayer [ 
	^ positions detect: [ :aPosition | aPosition player = aPlayer  ]
]

{ #category : #accesing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]
