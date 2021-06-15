Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'player',
		'cardsInHand',
		'cardsThatAffect'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
CardHandler class >> noCardMatchErrorMessage [
	^ 'This card cannot be played because there are not active cards that match'
]

{ #category : #'instance creation' }
CardHandler class >> with: aPlayer [ 
	^ self new initializeWith: aPlayer
]

{ #category : #action }
CardHandler >> addEffectOf: aCard [ 
	cardsThatAffect add: aCard.
]

{ #category : #action }
CardHandler >> addToHand: aCard [ 
	cardsInHand add: aCard.
]

{ #category : #boolean }
CardHandler >> affectsPlayer: aCard [
	^ cardsThatAffect includes: aCard.
]

{ #category : #boolean }
CardHandler >> hasInHand: aCard [ 
	^ cardsInHand includes: aCard
]

{ #category : #initialization }
CardHandler >> initializeWith: aPlayer [ 
	player := aPlayer.
	cardsInHand := OrderedCollection new.
	cardsThatAffect := OrderedCollection new.
]

{ #category : #accessing }
CardHandler >> player [
	^ player copy
]

{ #category : #accessing }
CardHandler >> quantityOfCardsInHand [
	^ cardsInHand size
]

{ #category : #action }
CardHandler >> removeEffectOf: aCard [
	cardsThatAffect remove: aCard ifAbsent: [ ^self error: self class noCardMatchErrorMessage ].
]

{ #category : #action }
CardHandler >> removeFromHand: aCard [
	cardsInHand remove:aCard.
]

{ #category : #action }
CardHandler >> totalEffectsOnPlayer [
	cardsThatAffect isEmpty ifTrue:[^0].
	^cardsThatAffect sum:[:card| card effect ].
]
