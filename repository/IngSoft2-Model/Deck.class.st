Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Deck class >> with: cards [
	
	cards isEmpty ifTrue: [ self error: 'It needs one or more cards'  ].

	^ self new initializeWith: cards.
]

{ #category : #initialization }
Deck >> initializeWith: aGroupOfCards [
	cards := aGroupOfCards.
]

{ #category : #actions }
Deck >> pick [
	| cardToPick |
	cardToPick := cards at: (Random new nextInt: (cards size)).
	^ cardToPick copy
]
