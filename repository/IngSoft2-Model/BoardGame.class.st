Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'size',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoardGame class >> withPlayers: aCollectionOfPlayers andSize: aSize [ 
	^ self new initializeWithPlayers: aCollectionOfPlayers andSize: aSize.
]

{ #category : #'instance creation' }
BoardGame class >> withPlayers: aCollectionOfPlayers withDices: aCollectionOfDices andSize: aSize [ 
	^ self new initializeWithPlayers: aCollectionOfPlayers withDices:aCollectionOfDices andSize: aSize .
]

{ #category : #initialization }
BoardGame >> initializeWithPlayers: aCollectionOfPlayers andSize: aSize [ 
	players:= aCollectionOfPlayers .
	size:= aSize.
]

{ #category : #initialization }
BoardGame >> initializeWithPlayers: aCollectionOfPlayers  withDices: aCollectionOfDices andSize: aSize [ 
	players:= aCollectionOfPlayers .
	dices:= aCollectionOfDices .
	size:= aSize.
]

{ #category : #'as yet unclassified' }
BoardGame >> isFinished [
	^ players anySatisfy: [:player | player position >= size].
]

{ #category : #'as yet unclassified' }
BoardGame >> rolls [
	players do:[:player| self isFinished
		ifFalse:[player throws: dices ].	
		].
]

{ #category : #'as yet unclassified' }
BoardGame >> winner [
	^ players detect:[:player | player position >= size].
]
