Class {
	#name : #FactoringTest,
	#superclass : #TestCase,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
FactoringTest >> setUp [

	players := OrderedCollection with: Player new with: Player new.
]

{ #category : #tests }
FactoringTest >> testABoardWithFiftySquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares squares|
	
	squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: 50.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 24.
	self assert: quantityOfWormHoleSquares equals: 10.
	self assert: quantityOfSpeedUpSquares equals: 10.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 5.
]

{ #category : #tests }
FactoringTest >> testABoardWithFiveSquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares squares|
	
	squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: 5.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 1.
	self assert: quantityOfWormHoleSquares equals: 1.
	self assert: quantityOfSpeedUpSquares equals: 1.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 1.
]

{ #category : #tests }
FactoringTest >> testABoardWithOneHundredEffectlessSquares [
	|  quantityOfEffectlessSquares squares |
	
	squares:= Distributor of: {EffectlessSquare new}  withProportions:#(100) andSize: 100.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].

	
	self assert: quantityOfEffectlessSquares equals: 100.

]

{ #category : #tests }
FactoringTest >> testABoardWithOneHundredSquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares squares|

squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: 100.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 48.
	self assert: quantityOfWormHoleSquares equals: 20.
	self assert: quantityOfSpeedUpSquares equals: 20.
	self assert: quantityOfAtomicBombSquares equals: 2.
	self assert: quantityOfMoonWalkSquares equals: 10.
]

{ #category : #tests }
FactoringTest >> testABoardWithTwentyFiveSquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares squares|

squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: 25.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 11.
	self assert: quantityOfWormHoleSquares equals: 5.
	self assert: quantityOfSpeedUpSquares equals: 5.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 3.
]

{ #category : #tests }
FactoringTest >> testABoardWithTwentySquaresIsCreated [
	|  quantityOfEffectlessSquares quantityOfWormHoleSquares quantityOfSpeedUpSquares quantityOfAtomicBombSquares quantityOfMoonWalkSquares squares|

squares:= Distributor of: {EffectlessSquare new. WormHoleSquare new. SpeedUpSquare new. MoonWalkSquare with: 5. AtomicBombSquare new}  withProportions:#(48 20 20 10 2) andSize: 20.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].
	quantityOfWormHoleSquares := squares count: [ :square | WormHoleSquare = square class ].
	quantityOfSpeedUpSquares:= squares count: [ :square | SpeedUpSquare = square class ].
	quantityOfAtomicBombSquares := squares count: [ :square | AtomicBombSquare = square class ].
	quantityOfMoonWalkSquares := squares count: [ :square | MoonWalkSquare = square class ].
	
	self assert: quantityOfEffectlessSquares equals: 9.
	self assert: quantityOfWormHoleSquares equals: 4.
	self assert: quantityOfSpeedUpSquares equals: 4.
	self assert: quantityOfAtomicBombSquares equals: 1.
	self assert: quantityOfMoonWalkSquares equals: 2.
]
