Class {
	#name : #DeliveryCardSquare,
	#superclass : #Object,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeliveryCardSquare class >> with: aCard [ 
	^ self new initializeWith: aCard
]

{ #category : #initialization }
DeliveryCardSquare >> initializeWith: aCard [ 
	card := aCard
]

{ #category : #actions }
DeliveryCardSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard giveCardFromDeckTo: aPlayer.
]
