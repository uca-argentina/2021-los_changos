Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> setUp [

	players := OrderedCollection with: Player new with: Player new.
]

{ #category : #tests }
BoardTest >> should: errorBlock raise: expectedErrorClass withErrorMessage: expectedMessage [
	self
		should: errorBlock
		raise: expectedErrorClass
		withExceptionDo: [ :error | self assert: error messageText equals: expectedMessage ]
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithFourSquaresize [
	self
		should: [  Board playedBy: { Player new . Player new } withNumberOfLaps: 1 andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.}  ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Size must be greater than 4'  ].
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithNumberOfLapsNegative [
	self
		should: [  Board playedBy: { Player new . Player new } withNumberOfLaps: -3 andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.}  ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Number of laps must be greater than 0' ].
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithNumberOfLapsZero [
	self
		should: [  Board playedBy: { Player new . Player new } withNumberOfLaps: 0 andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.} ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Number of laps must be greater than 0' ].
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithOnePlayers [	
	self
		should: [  Board playedBy: { Player new } withNumberOfLaps: 0 andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.} ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be 2 or more players' ].
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithZeroPlayers [
	self
		should: [  Board playedBy: {} withNumberOfLaps: 0 andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. EffectlessSquare new.} ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be 2 or more players' ].
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithoutSquares [
	self
		should: [  Board playedBy: { Player new . Player new } withNumberOfLaps: 1 andWith: { } ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Size must be greater than 4'  ].
]
