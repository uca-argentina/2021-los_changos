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

{ #category : #'error messages' }
Position class >> notValidLapErrorMessage [
	^ 'Lap should be zero or greater'
]

{ #category : #'error messages' }
Position class >> notValidNumberOfSquare [
	^ 'Number of square should be greater than zero'
]

{ #category : #'instance creation api' }
Position class >> of: aPlayer at: numberOfSquare after: laps [
	self validateNumberOf: laps and: numberOfSquare.
	^ self new
		initializeWithLap: laps
		numberOfSquare: numberOfSquare
		for: aPlayer
]

{ #category : #'instance creation api' }
Position class >> validateNumberOf: lap and: numberOfSquare [
	lap < 0
		ifTrue: [ self error: 'Lap should be zero or greater' ].
	numberOfSquare <= 0
		ifTrue: [ self error: 'Number of square should be greater than zero' ].
]

{ #category : #comparing }
Position >> >= aPosition [ 

	self lap = aPosition lap ifTrue: [ ^ self numberOfSquare >= aPosition numberOfSquare ].
	^ self lap >= aPosition lap.
]

{ #category : #initialization }
Position >> initializeWithLap: aLap numberOfSquare: aNumberOfSquare for: aPlayer [ 
	lap := aLap.
	numberOfSquare := aNumberOfSquare.
	player := aPlayer.
]

{ #category : #accessing }
Position >> lap [
	^ lap
]

{ #category : #accessing }
Position >> numberOfSquare [
	^ numberOfSquare
]

{ #category : #accessing }
Position >> player [
	^ player
]
