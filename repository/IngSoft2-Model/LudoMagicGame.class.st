Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'size',
		'dices',
		'finished'
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
		initializeWithPlayers: aCollectionOfPlayers
		dices: aCollectionOfDices
		andSize: aSize
]

{ #category : #accesing }
LudoMagicGame >> finished [
	^ finished.
]

{ #category : #initialization }
LudoMagicGame >> initializeWithPlayers: aCollectionOfPlayers  dices: aCollectionOfDices andSize: aSize [ 
	players:= OrderedDictionary newFromKeys: aCollectionOfPlayers andValues: (OrderedCollection new: aCollectionOfPlayers size withAll: 0).
	dices:= aCollectionOfDices .
	size:= aSize.
	finished:=false.
	
]

{ #category : #accesing }
LudoMagicGame >> makePlayersThrowDices [

	self validateIfMoreRollsAreAllowed.

	players keysAndValuesDo: [:player :position | 
		finished ifFalse:[
			| newPosition |
			newPosition:= (position + (player throws: dices)) min: size.
			finished:=(newPosition = size).
			players at: player put: newPosition.
		].
		].
]

{ #category : #'as yet unclassified' }
LudoMagicGame >> positionOf: aPlayer [ 
	^ players at: aPlayer.
]

{ #category : #validation }
LudoMagicGame >> validateIfMoreRollsAreAllowed [
	finished
		ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ]
]

{ #category : #accesing }
LudoMagicGame >> winner [
	^ players keys detect:[:player| (players at: player) = size].
]
