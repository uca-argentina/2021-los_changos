Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'location'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Position class >> assignedTo: aPlayer [ 
	^ self new initializeAssignedTo: aPlayer.
]

{ #category : #comparing }
Position >> >= aPosition [ 
	^ location >= aPosition location
]

{ #category : #initialization }
Position >> initializeAssignedTo: aPlayer [ 
	player := aPlayer.
	location := 0.
]

{ #category : #accesing }
Position >> location [
	^location
]

{ #category : #action }
Position >> move: advancedSquares upTo: aLimit [
	location := (location + advancedSquares ) min: aLimit.
]

{ #category : #accesing }
Position >> player [
	^ player
]
