Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'players',
		'size',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> validateBoardWithPlayers: aCollectionOfPlayers Dices: aCollectionOfDices AndSize: aSize [
	| boardValidators |
	boardValidators := OrderedCollection new.
	BoardValidator
		subclassesDo: [ :aValidatorSubclass | boardValidators add: aValidatorSubclass new ].
	boardValidators
		select: [ :aValidator | 
			aValidator
				isNotValidBoardWithSize: aSize
				withPlayers: aCollectionOfPlayers
				andDices: aCollectionOfDices ]
		thenDo: [ :aValidator | aValidator throwError ]
		ifNone: [  ]
]

{ #category : #'instance creation' }
Board class >> withPlayers: aCollectionOfPlayers withDices: aCollectionOfDices andSize: aSize [
	self
		validateBoardWithPlayers: aCollectionOfPlayers
		Dices: aCollectionOfDices
		AndSize: aSize.
	^ self new
		initializeWithPlayers: aCollectionOfPlayers
		withDices: aCollectionOfDices
		andSize: aSize
]

{ #category : #initialization }
Board >> initializeWithPlayers: aCollectionOfPlayers  withDices: aCollectionOfDices andSize: aSize [ 
	players:= aCollectionOfPlayers .
	dices:= aCollectionOfDices .
	size:= aSize.
]

{ #category : #'as yet unclassified' }
Board >> isFinished [
	^ players anySatisfy: [:player | player position >= size].
]

{ #category : #'as yet unclassified' }
Board >> rolls [
	self isFinished
	ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ].
	players do:[:player| self isFinished
		ifFalse:[player throws: dices ].	
		].
]

{ #category : #'as yet unclassified' }
Board >> winner [
	^ players detect:[:player | player position >= size].
]
