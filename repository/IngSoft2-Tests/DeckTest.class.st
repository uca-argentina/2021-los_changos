Class {
	#name : #DeckTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DeckTest >> testADeckCannotBeCreatedWithoutCards [
	self
		should: [Deck with: {} ] 
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'It needs one or more cards' ].
]

{ #category : #tests }
DeckTest >> testADeckDontRepeatCard [
	| aDeck |
	aDeck := Deck
		with: (Card subclasses collect: [ :aKindOfCard | aKindOfCard new ]).
	self assert: aDeck pick ~= aDeck pick
]
