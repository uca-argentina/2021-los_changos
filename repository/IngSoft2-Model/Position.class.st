Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'quantityOfSquaresAdvanced',
		'lap',
		'numberOfSquare'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Position class >> assignedTo: aPlayer [ 
	^ self new initializeAssignedTo: aPlayer.
]

{ #category : #'instance creation api' }
Position class >> lap: lap numberOfSquare: numberOfSquare for: aPlayer [

	lap < 0 ifTrue: [ self error: 'Lap should be zero or greater'].
	numberOfSquare <= 0 ifTrue: [ self error: 'Number of square should be greater than zero' ].

	^self new initializeWithLap: lap numberOfSquare:  numberOfSquare  for: aPlayer 
]

{ #category : #comparing }
Position >> >= aPosition [ 

	self lap = aPosition lap ifTrue: [ ^ self numberOfSquare >= aPosition numberOfSquare ].
	^ self lap >= aPosition lap.
]

{ #category : #initialization }
Position >> initializeAssignedTo: aPlayer [ 
	player := aPlayer.
	quantityOfSquaresAdvanced := 1.
]

{ #category : #'initialization-release' }
Position >> initializeWithLap: aLap numberOfSquare: aNumberOfSquare for: aPlayer [ 
	lap := aLap.
	numberOfSquare := aNumberOfSquare.
	player := aPlayer.
]

{ #category : #accesing }
Position >> lap [
	^ lap
]

{ #category : #actions }
Position >> moveBackwards: numberOfSquares [ 
	numberOfSquare := (numberOfSquare - numberOfSquares) max: 1.
]

{ #category : #actions }
Position >> movePlayerForward: advancedSquares upTo: size [
	
	| squares newNumberOfSquare |
	
	newNumberOfSquare := quantityOfSquaresAdvanced % size.
	newNumberOfSquare = 0 ifTrue: [ newNumberOfSquare := 1 ].
	numberOfSquare  := newNumberOfSquare
]

{ #category : #accesing }
Position >> numberOfSquare [
	^ numberOfSquare
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
	numberOfSquare :=1.
]
