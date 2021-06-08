Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'player',
		'cardsInHand',
		'cardsThatAffectPlayer'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
CardHandler class >> with: aPlayer [ 
	^ self new initializeWith: aPlayer
]

{ #category : #actions }
CardHandler >> addCardThatAffectsPlayer: aCard [ 
	cardsThatAffectPlayer add: aCard.
]

{ #category : #actions }
CardHandler >> addToHand: aCard [ 
	cardsInHand add: aCard.
]

{ #category : #boolean }
CardHandler >> hasInHand: aCard [ 
	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aPlayer [ 
	player := aPlayer.
	cardsInHand := OrderedCollection new.
	cardsThatAffectPlayer := OrderedCollection new.
]

{ #category : #accesing }
CardHandler >> player [
	^ player
]

{ #category : #accessing }
CardHandler >> quantityOfCardInHand [
	^ cardsInHand size
]

{ #category : #actions }
CardHandler >> removeCardThatAffectPlayer: aCard [
	cardsThatAffectPlayer remove: aCard ifAbsent: [ ^self error: 'This card cannot be played because there are not active cards that match' ].
]

{ #category : #actions }
CardHandler >> removeFromHand: aCard [
	cardsInHand remove:aCard.
]

{ #category : #actions }
CardHandler >> totalEffectsOnPlayer [
	cardsThatAffectPlayer isEmpty ifTrue:[^0].
	^cardsThatAffectPlayer sum:[:card| card effect ].
]
