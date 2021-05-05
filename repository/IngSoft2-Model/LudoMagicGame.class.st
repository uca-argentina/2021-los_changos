Class {
	#name : #LudoMagicGame,
	#superclass : #Object,
	#instVars : [
		'dices',
		'finished',
		'players',
		'board'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
LudoMagicGame class >> messageOfNoMoreRollsAllowed [
	^ 'Game is finished, no more rolls are allowed'
]

{ #category : #'instance creation' }
LudoMagicGame class >> playedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [

	self
		validateGamePlayedBy: players
		throwing: dices
		withNumberOfLaps: laps
		onBoardOf: size.
	^ self new
		initializeGamePlayedBy: players
		throwing: dices
		withNumberOfLaps: laps
		onBoardOf: size
]

{ #category : #'instance creation' }
LudoMagicGame class >> validateGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [
	LudoMagicValidator new validateAGamePlayedBy: players  throwing: dices withNumberOfLaps: laps onBoardOf: size. 
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
LudoMagicGame >> initializeGamePlayedBy: aGroupOfPlayers throwing: aGroupOfDices withNumberOfLaps: laps onBoardOf: aSize [
	players := aGroupOfPlayers.
	dices := aGroupOfDices.
	finished := false.
	board := Board
		playedBy: aGroupOfPlayers
		withNumberOfLaps: laps
		with: aSize
]

{ #category : #accessing }
LudoMagicGame >> lapOf: player [ 
	^ board lapOf: player
]

{ #category : #accesing }
LudoMagicGame >> locationOf: player [ 
	^ (board positionOf: player) location
]

{ #category : #accesing }
LudoMagicGame >> turn [

	self checkIfRollsAreAllowed.
	
	players do: [:player  | 
		finished ifFalse:[
			board move: player  to: (player  throws: dices).
			finished:=( board finished: player ).
		].
		].
]

{ #category : #accesing }
LudoMagicGame >> winner [
	finished
		ifFalse:
			[ self error: 'There is no winner because game has not finished yet' ].
	^ board sortedPositions first player
]
