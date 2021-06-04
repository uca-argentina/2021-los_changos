Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'player',
		'lap',
		'numberOfSquare'
	],
	#category : #'IngSoft2-Model-Core'
}

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

{ #category : #accesing }
Position >> numberOfSquare [
	^ numberOfSquare
]

{ #category : #accessing }
Position >> player [
	^ player
]
