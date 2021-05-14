Class {
	#name : #DistributorTest,
	#superclass : #TestCase,
	#instVars : [
		'players'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DistributorTest >> testADistributorCannotBeCreatedWithNegativeSize [
	self
		should: [  Distributor of: {EffectlessSquare new . Object new . Dice withFaces:  12}  withProportions:#(45 5 50) andSize: -5 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Size must be greater than 1' ].

]

{ #category : #tests }
DistributorTest >> testADistributorCannotBeCreatedWithObjectsAndProportionsDifferentsSize [
	self
		should: [  Distributor of: {Object new }  withProportions:#(10 50) andSize: 10 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'The proportions do not sum 100' ].

]

{ #category : #tests }
DistributorTest >> testADistributorCannotBeCreatedWithSizeZero [
	self
		should: [  Distributor of: {EffectlessSquare new . Object new . Dice withFaces:  12}  withProportions:#(45 5 50) andSize: 0 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Size must be greater than 1' ].

]

{ #category : #tests }
DistributorTest >> testADistributorCannotBeCreatedWithoutObjects [
	self
		should: [  Distributor of: {}  withProportions:#(10 20 20 50) andSize: 10 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be objects' ].

]

{ #category : #tests }
DistributorTest >> testADistributorCannotBeCreatedWithoutProportions [
	self
		should: [  Distributor of: {EffectlessSquare new . Object new . Dice withFaces:  12}  withProportions:#() andSize: 10 ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'There must be proportions' ].

]

{ #category : #tests }
DistributorTest >> testADistributorRespectProportionsWithFiftyObjects [
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
DistributorTest >> testADistributorRespectProportionsWithFiveObjects [
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
DistributorTest >> testADistributorRespectProportionsWithOneHundredObjectThatAreEqual [
	|  quantityOfEffectlessSquares squares |
	
	squares:= Distributor of: {EffectlessSquare new}  withProportions:#(100) andSize: 100.
	
	quantityOfEffectlessSquares := squares count: [ :square | EffectlessSquare = square class ].

	
	self assert: quantityOfEffectlessSquares equals: 100.

]

{ #category : #tests }
DistributorTest >> testADistributorRespectProportionsWithTwentyFiveObjects [
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
DistributorTest >> testADistributorRespectProportionsWithTwentyObjects [
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
