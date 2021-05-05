Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'value'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Position class >> assignedTo: aPlayer [ 
	^ self new initializeAssignedTo: aPlayer.
]

{ #category : #comparing }
Position >> >= aPosition [ 
	^ value >= aPosition value 
]

{ #category : #initialization }
Position >> initializeAssignedTo: aPlayer [ 
	player := aPlayer.
	value := 0.
]

{ #category : #action }
Position >> move: newValue upTo: aLimit [
	value := (value + newValue ) min: aLimit.
]

{ #category : #accesing }
Position >> player [
	^ player
]

{ #category : #accesing }
Position >> value [
	^value
]
