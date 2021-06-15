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
Board class >> notValidNumberOfLapsErrorMessage [
	^ 'Number of laps must be greater than 0'
]

{ #category : #'instance creation' }
Board class >> notValidNumberOfPlayersErrorMessage [
	^ 'There must be 2 or more players'
]

{ #category : #'instance creation' }
Board class >> notValidNumberOfSquaresErrorMessage [
	^ 'Size must be greater than 4'
]

{ #category : #'instance creation' }
Board class >> playedBy: players withNumberOf: laps with: squares andCardsFrom: deck [
	self validate: players withNumberOf: laps  andWith: squares. 
	^self new initializePlayedBy: players withNumberOf: laps with: squares andCardsFrom: deck.
]

{ #category : #'instance creation' }
Board class >> validate: players withNumberOf: laps andWith: squares [
	self validatePlayers: players.
	self validateLaps: laps.
	self validateSquares: squares
]

{ #category : #'instance creation' }
Board class >> validateLaps: laps [
	laps < 1
		ifTrue: [ self error: self notValidNumberOfLapsErrorMessage ]
]

{ #category : #'instance creation' }
Board class >> validatePlayers: players [
	players size <= 1
		ifTrue: [ self error: self notValidNumberOfPlayersErrorMessage ]
]

{ #category : #'instance creation' }
Board class >> validateSquares: squares [
	squares size <= 4
		ifTrue: [ self error: self notValidNumberOfSquaresErrorMessage ]
]

{ #category : #action }
Board >> addEffectOf: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addEffectOf: aCard.
	lastCardPlayed:= aCard.
]

{ #category : #action }
Board >> addInHand: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) addToHand: aCard.
]

{ #category : #action }
Board >> addToAllEffectOf: aCard [ 
	players do:[:player | self addEffectOf: aCard to:player].
	
]

{ #category : #action }
Board >> applyEffectOfTheLastPlayedSquareTo: aPlayer from: aCard [
	lastSquarePlayed makeEffectOn: aPlayer thatHasItsPositionIn: self.
	lastCardPlayed:= aCard.
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
	squaresAdvanced := self numberOfSquaresAdvancedOf: playerPosition.
	^ squaresAdvanced = self limit
]

{ #category : #action }
Board >> giveCardFromDeckTo: aPlayer [ 
	(self cardHandlerOf: aPlayer) addToHand: (deck pick).
	
]

{ #category : #boolean }
Board >> has: aPlayer the: aCard [
	| playerCardHandler |
	playerCardHandler := self cardHandlerOf: aPlayer.
	^ playerCardHandler hasInHand: aCard
]

{ #category : #initialization }
Board >> initializePlayedBy: aGroupOfPlayers withNumberOf: numberOfLaps with: aGroupOfSquares andCardsFrom: aDeck [
	positions := aGroupOfPlayers collect: [ :player |   Position lap: 0 numberOfSquare: 1 for: player  ].
	cardHandlers := aGroupOfPlayers collect: [ :player |   CardHandler with: player ].
	
	cardHandlers do: [ :cardHandler | 
		cardHandler addToHand: (aDeck pick). 
		cardHandler addToHand: (aDeck pick).  ].
	
	squares := aGroupOfSquares.
	laps := numberOfLaps.
	players := aGroupOfPlayers.
	deck:=aDeck.
	lastCardPlayed := EmptyCard new.
	lastSquarePlayed:= EffectlessSquare new.
]

{ #category : #accessing }
Board >> lapOf: aPlayer [ 
	^ (self positionOf: aPlayer) lap.
]

{ #category : #accessing }
Board >> lastCardPlayed [
	^lastCardPlayed.
]

{ #category : #accessing }
Board >> limit [
	^(laps * (squares size)) + 1
]

{ #category : #action }
Board >> move: aPlayer backwards: numberOfSquares [

	| aPosition newPosition |
	aPosition := self positionOf: aPlayer.
	newPosition := self newPosition: (numberOfSquares negated) from: aPosition. 
	positions remove: aPosition.
	positions add: newPosition.
]

{ #category : #action }
Board >> move: aPlayer forward: squaresToMove [
	| currentSquare newPosition |
	newPosition := self move: aPlayer withoutEffectTo: squaresToMove.
	currentSquare := squares at: newPosition numberOfSquare.
	lastSquarePlayed := currentSquare.
	currentSquare makeEffectOn: aPlayer thatHasItsPositionIn: self
]

{ #category : #action }
Board >> move: aPlayer withoutEffectTo: squaresToMove [
	| oldPosition newPosition |
	oldPosition := self positionOf: aPlayer.
	positions remove: oldPosition.
	newPosition := self newPosition: squaresToMove from: oldPosition.
	positions add: newPosition.
	^ newPosition
]

{ #category : #accessing }
Board >> moveAllPlayersBackards: numberOfSquaresToMoveBackwards except: aPlayer [ 
	| playersToMove |
	playersToMove:= self players.
	playersToMove remove: aPlayer.
	playersToMove do:[:player| self move: player backwards: numberOfSquaresToMoveBackwards ].
]

{ #category : #accessing }
Board >> newPosition: numberOfSquaresToAdvance from: aPosition [ 

	| newLap newNumberOfSquare quantityOfSquaresAdvanced |
	
	quantityOfSquaresAdvanced := ( (self numberOfSquaresAdvancedOf: aPosition) + numberOfSquaresToAdvance) min: self limit max: 1.
	
	newLap := (quantityOfSquaresAdvanced - 1) // (self size).
	newNumberOfSquare := quantityOfSquaresAdvanced % self size.
	newNumberOfSquare = 0 ifTrue: [ newNumberOfSquare := self size ].
	
	^ Position lap: newLap numberOfSquare: newNumberOfSquare for: (aPosition player)
]

{ #category : #accessing }
Board >> numberOfSquaresAdvancedOf: aPosition [
	^ aPosition lap * squares size + aPosition numberOfSquare
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
Board >> removeFromHand: aCard to: aPlayer [
	(self cardHandlerOf: aPlayer) removeFromHand: aCard.
]

{ #category : #action }
Board >> removeToAllPlayersPermanent: card [
	| handlersWithCardToBeRemoved |
	handlersWithCardToBeRemoved:=cardHandlers select:[:cardHandler | cardHandler affectsPlayer: card ].
	
	handlersWithCardToBeRemoved isEmpty 
	ifTrue: [self error: CardHandler noCardMatchErrorMessage  ].
	
	handlersWithCardToBeRemoved do: [:cardHandler | cardHandler removeEffectOf: card ].
]

{ #category : #action }
Board >> restartPositionOfAllPlayers [
	positions:= players collect: [ :player | Position lap: (self lapOf:player) numberOfSquare: 1 for: player  ].
]

{ #category : #accessing }
Board >> size [
	^ squares size
]

{ #category : #accessing }
Board >> sortedPositions [
	^ positions asSortedCollection: [ :playerA :playerB | playerA >= playerB ]
]
