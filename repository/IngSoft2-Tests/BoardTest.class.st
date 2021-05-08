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
