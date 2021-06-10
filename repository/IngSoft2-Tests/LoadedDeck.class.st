Class {
	#name : #LoadedDeck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'nextCard'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
LoadedDeck class >> withCards: cards [
	^self new initializeWithCards: cards.
]

{ #category : #initialization }
LoadedDeck >> initializeWithCards: aGroupOfCards [.
	nextCard:=1.
	cards:= aGroupOfCards.
]

{ #category : #actions }
LoadedDeck >> pick [
	| card |
	card:= cards at: nextCard.
	nextCard:=(nextCard rem: cards size) +1.
	^card.
]
