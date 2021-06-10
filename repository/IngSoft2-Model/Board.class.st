Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'laps',
		'players',
		'positions',
		'squares',
		'cardHandlers',
		'deck',
		'lastCardPlayed',
		'lastSquarePlayed'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
Board class >> playedBy: players withNumberOfLaps: laps with: squares and: deck [

	self validatePlayers: players withNumberOfLaps: laps  andWith: squares. 

	^self new initializePlayedBy: players withNumberOfLaps: laps with: squares and: deck.
]

{ #category : #'instance creation' }
Board class >> validateLaps: laps [
	laps < 1
		ifTrue: [ self error: 'Number of laps must be greater than 0' ]
]

{ #category : #'instance creation' }
Board class >> validatePlayers: players [
	players size <= 1
		ifTrue: [ self error: 'There must be 2 or more players' ]
]

{ #category : #'instance creation' }
Board class >> validatePlayers: players withNumberOfLaps: laps andWith: squares [
	self validatePlayers: players.
	self validateLaps: laps.
	self validateSquares: squares
]

{ #category : #'instance creation' }
Board class >> validateSquares: squares [
	squares size <= 4
		ifTrue: [ self error: 'Size must be greater than 4' ]
]

{ #category : #actions }
Board >> addCardInHandOfAPlayer: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addToHand: aCard.
]

{ #category : #action }
Board >> addEffectOf: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addCardThatAffectsPlayer: aCard.
	lastCardPlayed:= aCard.
]

{ #category : #action }
Board >> addEffectToAllOf: aCard [ 
	cardHandlers do:[:cardHandler|cardHandler addCardThatAffectsPlayer: aCard].
]

{ #category : #action }
Board >> applyEffectOfTheLastPlayedSquareTo: aPlayer [
	lastSquarePlayed makeEffectOn: aPlayer thatHasItsPositionIn: self.
]

{ #category : #boolean }
Board >> cardHandlerOf: aPlayer [
	| playerCardHandler |
	playerCardHandler := cardHandlers
		detect: [ :handler | handler player = aPlayer ].
	^ playerCardHandler
]

{ #category : #accessing }
Board >> finished: aPlayer [

	
	| playerPosition squaresAdvanced |
	playerPosition := self positionOf: aPlayer.
	squaresAdvanced := (playerPosition lap * squares size) + playerPosition numberOfSquare.

	^ squaresAdvanced = self limit
]

{ #category : #accesing }
Board >> getNewPositionForward: numberOfSquaresToAdvance from: aPosition [ 

	| newLap newNumberOfSquare quantityOfSquaresAdvanced |
	
	quantityOfSquaresAdvanced := (( (aPosition lap * squares size) + aPosition numberOfSquare ) + numberOfSquaresToAdvance) min: self limit.
	newLap := (quantityOfSquaresAdvanced - 1) // (squares size).
	newNumberOfSquare := quantityOfSquaresAdvanced % squares size.
	newNumberOfSquare = 0 ifTrue: [ newNumberOfSquare := squares size ].
	
	^ Position lap: newLap numberOfSquare: newNumberOfSquare for: (aPosition player)
]

{ #category : #action }
Board >> giveCardFromDeckTo: aPlayer [ 
	(self cardHandlerOf: aPlayer) addToHand: (deck pick).
	
]

{ #category : #boolean }
Board >> has: aPlayer theCard: aCard [
	| playerCardHandler |
	playerCardHandler := self cardHandlerOf: aPlayer.
	^ playerCardHandler hasInHand: aCard
]

{ #category : #initialization }
Board >> initializePlayedBy: aGroupOfPlayers withNumberOfLaps:  numberOfLaps with: aGroupOfSquares and: aDeck [
	positions := aGroupOfPlayers collect: [ :player |   Position lap: 0 numberOfSquare: 1 for: player  ].
	cardHandlers := aGroupOfPlayers collect: [ :player |   CardHandler with: player ].
	
	cardHandlers do: [ :cardHandler | 
		cardHandler addToHand: (aDeck pick). 
		cardHandler addToHand: (aDeck pick).  ].
	
	squares := aGroupOfSquares.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
	deck:=aDeck.
	lastSquarePlayed:= EffectlessSquare new.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 

	^ (self positionOf: aPlayer) lap.
]

{ #category : #accesing }
Board >> lastCardPlayed [
	^lastCardPlayed.
]

{ #category : #accessing }
Board >> limit [
	^(laps * (squares size)) + 1
]

{ #category : #actions }
Board >> move: aPlayer backwards: numberOfSquares [

	| newLap newNumberOfSquare quantityOfSquaresAdvanced aPosition |
	aPosition := self positionOf: aPlayer.
	quantityOfSquaresAdvanced := (( (aPosition lap * squares size) + aPosition numberOfSquare ) - numberOfSquares) max: 1.
	newLap := (quantityOfSquaresAdvanced - 1) // (squares size).
	newNumberOfSquare := quantityOfSquaresAdvanced % squares size.
	newNumberOfSquare = 0 ifTrue: [ newNumberOfSquare := squares size ].
	positions remove: aPosition.
	positions add: (Position lap: newLap numberOfSquare: newNumberOfSquare for: (aPosition player)).
]

{ #category : #actions }
Board >> move: aPlayer forward: squaresToMove [
	| currentSquare newPosition |
	newPosition := self move: aPlayer withoutEffectTo: squaresToMove.
	currentSquare := squares at: newPosition numberOfSquare.
	lastSquarePlayed := currentSquare.
	currentSquare makeEffectOn: aPlayer thatHasItsPositionIn: self
]

{ #category : #actions }
Board >> move: aPlayer withoutEffectTo: squaresToMove [
	| oldPosition newPosition |
	oldPosition := self positionOf: aPlayer.
	positions remove: oldPosition.
	newPosition := self
		getNewPositionForward: squaresToMove
		from: oldPosition.
	positions add: newPosition.
	^ newPosition
]

{ #category : #accesing }
Board >> moveAllPlayersBackards: numberOfSquaresToMoveBackwards except: aPlayer [ 
	| playersToMove |
	playersToMove:= players copy.
	playersToMove remove: aPlayer.
	playersToMove do:[:player| self move: player backwards: numberOfSquaresToMoveBackwards ].
]

{ #category : #accessing }
Board >> players [
	^ players copy.
]

{ #category : #accessing }
Board >> positionOf: aPlayer [ 
	^ positions detect: [ :aPosition | aPosition player = aPlayer  ]
]

{ #category : #action }
Board >> removePermanentCard: aCard [
	| handlersWithCardToBeRemoved |
	handlersWithCardToBeRemoved:=cardHandlers select:[:cardHandler | cardHandler includesCardThatAffectPlayer: aCard ].
	
	handlersWithCardToBeRemoved isEmpty 
	ifTrue: [self error: 'This card cannot be played because there are not active cards that match' ].
	
	handlersWithCardToBeRemoved do: [:cardHandler | cardHandler removeCardThatAffectPlayer: aCard ].
]

{ #category : #action }
Board >> removePermanentCard: aCard from: aPlayer [ 
	(self cardHandlerOf: aPlayer) removeCardThatAffectPlayer: aCard.
]

{ #category : #actions }
Board >> restartAllPlayers [
	positions:= players collect: [ :player |   Position lap: (self lapOf:player) numberOfSquare: 1 for: player  ].
]

{ #category : #initialization }
Board >> size [
	^ squares size
]

{ #category : #accessing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]
