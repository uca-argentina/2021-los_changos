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
Board class >> withSize: aSize and: laps and: aGroupOfPlayers [
	
	^ self new initializeWithSize: aSize and: laps and: aGroupOfPlayers 
]

{ #category : #accessing }
Board >> finished: aPlayer [ 
	^ (self positionOf: aPlayer) value  = (size * laps)
]

{ #category : #initialization }
Board >> initializeWithSize: aSize and:  numberOfLaps and: aGroupOfPlayers [
	positions := aGroupOfPlayers collect: [ :player |   Position assignedTo: player ].
	size := aSize.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^ ( (self positionOf: aPlayer) value ) // size
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
