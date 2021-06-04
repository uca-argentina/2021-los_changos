Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'player',
		'cards',
		'effectCards'
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

{ #category : #action }
CardHandler >> addEffectOf: aCard [ 
	effectCards add: aCard.
]

{ #category : #action }
CardHandler >> effects [
	effectCards isEmpty 
	ifTrue:[^0].
	^effectCards sum:[:card| card effect ].
]

{ #category : #boolean }
CardHandler >> has: aCard [ 
	^ cards includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aPlayer [ 
	player := aPlayer.
	cards := OrderedCollection new.
	effectCards := OrderedCollection new.
]

{ #category : #accesing }
CardHandler >> player [
	^ player
]

{ #category : #'as yet unclassified' }
CardHandler >> remove: aCard from: aPlayer [ 
	cards remove:aCard.
]
