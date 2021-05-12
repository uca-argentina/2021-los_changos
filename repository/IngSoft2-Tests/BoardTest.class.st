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
BoardTest >> testABoardCannotBeCreatedWithInvalidNumberOfLaps [
	self should: [  Board playedBy: { Player new } withNumberOfLaps: 0 andSize: 20 ] raise: Error description:  'Number of laps must be greater than 0'.
	self should: [  Board playedBy: { Player new  . Player new} withNumberOfLaps: -5 andSize: 10 ] raise: Error description:   'Number of laps must be greater than 0'.
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithZInvalidSize [
	self should: [  Board playedBy: { Player new . Player new } withNumberOfLaps: 3 andSize: 4 ] raise: Error description:  'Size must be greater than 4'.
	self should: [  Board playedBy: { Player new . Player new} withNumberOfLaps: 3 andSize: -5 ] raise: Error description:  'Size must be greater than 4'.
]

{ #category : #tests }
BoardTest >> testABoardCannotBeCreatedWithZeroOrOnePlayers [
	self should: [  Board playedBy: { Player new } withNumberOfLaps: 3 andSize: 20 ] raise: Error description:  'There must be 2 or more players'.
	self should: [  Board playedBy: {} withNumberOfLaps: 3 andSize: 20 ] raise: Error description:  'There must be 2 or more players'.
]

{ #category : #tests }
BoardTest >> testABoardWithFiftySquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares aBoard squaresOfBoard |

	aBoard:= Board playedBy: players withNumberOfLaps: 3 andSize: 50.
	squaresOfBoard := aBoard squares.
	
	quantityOfEffectlessSquares := squaresOfBoard count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squaresOfBoard count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squaresOfBoard count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squaresOfBoard count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squaresOfBoard count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 24.
	self assert: quantityOfWormHoleSquares equals: 10.
	self assert: quantityOfSpeedUpSquares equals: 10.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 5.
]

{ #category : #tests }
BoardTest >> testABoardWithOneHundredSquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares aBoard squaresOfBoard |

	aBoard:= Board playedBy: players withNumberOfLaps: 3 andSize: 100.
	squaresOfBoard := aBoard squares.
	
	quantityOfEffectlessSquares := squaresOfBoard count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squaresOfBoard count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squaresOfBoard count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squaresOfBoard count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squaresOfBoard count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 48.
	self assert: quantityOfWormHoleSquares equals: 20.
	self assert: quantityOfSpeedUpSquares equals: 20.
	self assert: quantityOfAtomicBombSquares equals: 2.
	self assert: quantityOfMoonWalkSquares equals: 10.
]

{ #category : #tests }
BoardTest >> testABoardWithTwentyFiveSquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares aBoard squaresOfBoard |

	aBoard:= Board playedBy: players withNumberOfLaps: 3 andSize: 25.
	squaresOfBoard := aBoard squares.
	
	quantityOfEffectlessSquares := squaresOfBoard count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squaresOfBoard count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squaresOfBoard count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squaresOfBoard count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squaresOfBoard count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 11.
	self assert: quantityOfWormHoleSquares equals: 5.
	self assert: quantityOfSpeedUpSquares equals: 5.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 3.
]

{ #category : #tests }
BoardTest >> testABoardWithTwentyFiveSquaresTheFirstSquareIsEffectless [
	|  aBoard firstSquare |

	aBoard:= Board playedBy: players withNumberOfLaps: 3 andSize: 25.
	firstSquare := aBoard squares first.
	
	self assert: firstSquare class equals: EffectlessSquare .
]

{ #category : #tests }
BoardTest >> testABoardWithTwentySquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares aBoard squaresOfBoard |

	aBoard:= Board playedBy: players withNumberOfLaps: 3 andSize: 20.
	squaresOfBoard := aBoard squares.
	
	quantityOfEffectlessSquares := squaresOfBoard count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squaresOfBoard count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squaresOfBoard count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squaresOfBoard count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squaresOfBoard count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 9.
	self assert: quantityOfWormHoleSquares equals: 4.
	self assert: quantityOfSpeedUpSquares equals: 4.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 2.
]
