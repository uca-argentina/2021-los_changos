Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'square',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> assignedTo: aPlayer [ 
	^ self new initializeAssignedTo: aPlayer.
]

{ #category : #comparing }
Position >> >= aPosition [ 
	^ square >= aPosition squaresMoved 
]

{ #category : #initialization }
Position >> initializeAssignedTo: aPlayer [ 
	player := aPlayer.
	square := 0.
	laps := 0.
]

{ #category : #action }
Position >> move: newSquare upTo: aLimit [
	square := (square + newSquare) min: aLimit.
]

{ #category : #accesing }
Position >> player [
	^ player
]

{ #category : #accesing }
Position >> squaresMoved [
	^square
]
