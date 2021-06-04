Class {
	#name : #LoadedSquare,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedSquare class >> with: aCard [ 
	^ self new initializeWith: aCard
]

{ #category : #initialization }
LoadedSquare >> initializeWith: aCard [ 
	card := aCard
]

{ #category : #actions }
LoadedSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard add: card toHandlerOf: aPlayer.
]
