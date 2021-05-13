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
BoardTest >> testABoardCannotBeCreatedWithInvalidNumberOfLaps [
	self should: [  Board playedBy: { Player new } withNumberOfLaps: 0 andWith: 20 ] raise: Error description:  'Number of laps must be greater than 0'.
	self should: [  Board playedBy: { Player new  . Player new} withNumberOfLaps: -5 andWith: 10 ] raise: Error description:   'Number of laps must be greater than 0'.
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithZInvalidSize [
	self
		should: [ Board playedBy: 	{Player new. 	Player new} withNumberOfLaps: 3 	andWith: { EffectlessSquare new. EffectlessSquare new. EffectlessSquare new. } ]
		raise: Error
		withErrorMessage: 'Size must be greater than 4'.
	self
		should: [ Board
				playedBy:
					{Player new.
					Player new}
				withNumberOfLaps: 3
				andWith: {}]
		raise: Error
		description: 'Size must be greater than 4'
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithZeroOrOnePlayers [
	self should: [  Board playedBy: { Player new } withNumberOfLaps: 3 andWith: 20 ] raise: Error description:  'There must be 2 or more players'.
	self should: [  Board playedBy: {} withNumberOfLaps: 3 andWith: 20 ] raise: Error description:  'There must be 2 or more players'.
]
