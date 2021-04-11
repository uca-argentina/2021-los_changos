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
Board class >> withPlayers: aCollectionOfPlayers withDices: aCollectionOfDices andSize: aSize [ 
	^ self new initializeWithPlayers: aCollectionOfPlayers withDices:aCollectionOfDices andSize: aSize .
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
	players do:[:player| self isFinished
		ifFalse:[player throws: dices ].	
		].
]

{ #category : #'as yet unclassified' }
Board >> winner [
	^ players detect:[:player | player position >= size].
]
