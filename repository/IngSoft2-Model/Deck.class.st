Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'nextCardIndex'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation - old' }
Deck class >> ofSize: aSize [ 
		| cardsOfVeryKind cards |
	cardsOfVeryKind := Card subclasses collect: [ :class | class new ].
		cards := (ProbabilisticDistributor withEqualProbability: cardsOfVeryKind) generate: aSize.
		
	^self new initializeWith: cards.
]

{ #category : #'instance creation' }
Deck class >> with: cards [
	^ self new initializeWith: cards.
]

{ #category : #initialization }
Deck >> initializeWith: aGroupOfCards [
	cards := aGroupOfCards.
	nextCardIndex := 1.
]

{ #category : #actions }
Deck >> pick [
	| cardToPick |
	cardToPick := cards at: nextCardIndex.
	nextCardIndex:= (nextCardIndex rem: cards size) + 1.
	nextCardIndex = 0 ifTrue: [ nextCardIndex := 1 ].
	^ cardToPick 
]

{ #category : #actions }
Deck >> size [
	^ cards size
]
