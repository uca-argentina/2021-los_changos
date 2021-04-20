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
LudoMagicGame class >> validateWith: aCollectionOfPlayers with: aCollectionOfDices and: aSize [
	LudoMagicValidator new valid: aCollectionOfPlayers  with: aCollectionOfDices  with: aSize. 
]

{ #category : #'instance creation' }
LudoMagicGame class >> with: aCollectionOfPlayers with: aCollectionOfDices and: aSize [
	self
		validateWith: aCollectionOfPlayers
		with: aCollectionOfDices
		and: aSize.
	^ self new
		initializeWith: aCollectionOfPlayers
		with: aCollectionOfDices
		and: aSize
]

{ #category : #initialization }
LudoMagicGame >> initializeWith: aCollectionOfPlayers  with: aCollectionOfDices and: aSize [ 
	players:= aCollectionOfPlayers .
	dices:= aCollectionOfDices .
	size:= aSize.
]

{ #category : #accesing }
LudoMagicGame >> isFinished [
	^ players anySatisfy: [:player | player finished: size].
]

{ #category : #accesing }
LudoMagicGame >> makePlayersThrowDices [
	self validateIfMoreRollsAreAllowed.

	players do:[:player| self isFinished
		ifFalse:[player throws: dices withFinishLine: size].
		].
]

{ #category : #validation }
LudoMagicGame >> validateIfMoreRollsAreAllowed [
	self isFinished
		ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ]
]

{ #category : #accesing }
LudoMagicGame >> winner [
	^ players detect:[:player | player position = size].
]
