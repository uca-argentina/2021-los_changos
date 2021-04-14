Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'size',
		'dices'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LudoMagicGame class >> validateWithPlayers: aCollectionOfPlayers Dices: aCollectionOfDices AndSize: aSize [
	| aValidator |
	aValidator:= LudoMagicValidator new.
	
	aValidator valid: aCollectionOfPlayers  with: aCollectionOfDices  with: aSize. 
]

{ #category : #'instance creation' }
LudoMagicGame class >> withPlayers: aCollectionOfPlayers withDices: aCollectionOfDices andSize: aSize [
	self
		validateWithPlayers: aCollectionOfPlayers
		Dices: aCollectionOfDices
		AndSize: aSize.
	^ self new
		initializeWithPlayers: aCollectionOfPlayers
		withDices: aCollectionOfDices
		andSize: aSize
]

{ #category : #initialization }
LudoMagicGame >> initializeWithPlayers: aCollectionOfPlayers  withDices: aCollectionOfDices andSize: aSize [ 
	players:= aCollectionOfPlayers .
	dices:= aCollectionOfDices .
	size:= aSize.
]

{ #category : #'as yet unclassified' }
LudoMagicGame >> isFinished [
	^ players anySatisfy: [:player | player finished: size].
]

{ #category : #'as yet unclassified' }
LudoMagicGame >> rolls [
	self isFinished
	ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ].
	players do:[:player| self isFinished
		ifFalse:[player throws: dices withFinishLine: size].
		].
]

{ #category : #'as yet unclassified' }
LudoMagicGame >> winner [
	^ players detect:[:player | player position >= size].
]
