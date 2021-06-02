Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'player',
		'cards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
CardHandler class >> with: aPlayer [ 
	^ self new initializeWith: aPlayer
]

{ #category : #actions }
CardHandler >> add: aCard [ 
	cards add: aCard.
]

{ #category : #boolean }
CardHandler >> has: aCard [ 
	^ cards includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aPlayer [ 
	player := aPlayer.
	cards := OrderedCollection new.
]

{ #category : #accesing }
CardHandler >> player [
	^ player
]
