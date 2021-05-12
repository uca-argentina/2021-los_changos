Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'quantityOfSquaresAdvanced'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Position class >> assignedTo: aPlayer [ 
	^ self new initializeAssignedTo: aPlayer.
]

{ #category : #comparing }
Position >> >= aPosition [ 
	^ quantityOfSquaresAdvanced >= aPosition quantityOfSquaresAdvanced
]

{ #category : #initialization }
Position >> initializeAssignedTo: aPlayer [ 
	player := aPlayer.
	quantityOfSquaresAdvanced := 1.
]

{ #category : #actions }
Position >> moveBackwards: numberOfSquares [ 
	quantityOfSquaresAdvanced:= (quantityOfSquaresAdvanced - numberOfSquares) max: 1.
]

{ #category : #actions }
Position >> movePlayerForward: advancedSquares upTo: aLimit [
	quantityOfSquaresAdvanced := (quantityOfSquaresAdvanced + advancedSquares ) min: aLimit.
]

{ #category : #accessing }
Position >> player [
	^ player
]

{ #category : #accessing }
Position >> quantityOfSquaresAdvanced [
	^quantityOfSquaresAdvanced
]

{ #category : #actions }
Position >> restart [
	quantityOfSquaresAdvanced:=1.
]
