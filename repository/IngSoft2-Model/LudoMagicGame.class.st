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
LudoMagicGame class >> playedBy: players throwing: dices onBoardOf: size [
	self
		validateGamePlayedBy: players
		throwing: dices
		onBoardOf: size.
	^ self new
		initializeGamePlayedBy: players
		throwing: dices
		onBoardOf: size
]

{ #category : #'instance creation' }
LudoMagicGame class >> validateGamePlayedBy: players throwing: dices onBoardOf: size [
	LudoMagicValidator new validateAGamePlayedBy: players  throwing: dices  onBoardOf: size. 
]

{ #category : #validation }
LudoMagicGame >> checkIfRollsAreAllowed [
	finished
		ifTrue: [ self error: 'Game is finished, no more rolls are allowed' ]
]

{ #category : #accesing }
LudoMagicGame >> finished [
	^ finished.
]

{ #category : #initialization }
LudoMagicGame >> initializeGamePlayedBy: aGroupOfPlayers  throwing: aGroupOfDices onBoardOf: aSize [ 
	players:= OrderedDictionary newFromKeys: aGroupOfPlayers andValues: (OrderedCollection new: aGroupOfPlayers size withAll: 0).
	dices:= aGroupOfDices .
	size:= aSize.
	finished:=false.
	
]

{ #category : #'as yet unclassified' }
LudoMagicGame >> positionOf: player [ 
	^ players at: player.
]

{ #category : #accesing }
LudoMagicGame >> turn [

	self checkIfRollsAreAllowed.

	players keysAndValuesDo: [:player :position | 
		finished ifFalse:[
			| newPosition |
			newPosition:= (position + (player throws: dices)) min: size.
			finished:=(newPosition = size).
			players at: player put: newPosition.
		].
		].
]

{ #category : #accesing }
LudoMagicGame >> winner [
	^ players keys detect:[:player| (players at: player) = size].
]
