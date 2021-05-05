Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testANewPositionAdvanceASquare [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition move: 1 upTo: 10.
	self assert: aPosition location equals: 1.
]

{ #category : #tests }
PositionTest >> testANewPositionAdvanceFourValuesAndThenThreeValues [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition move: 4 upTo: 10.
	aPosition move: 3 upTo: 10.
	self assert: aPosition location equals: 7.
]

{ #category : #tests }
PositionTest >> testANewPositionRealizedNoMoves [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	self assert: aPosition location equals: 0.
]

{ #category : #tests }
PositionTest >> testANewPositionStopsAtLimit [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition move: 23 upTo: 10.
	self assert: aPosition location equals: 10.
]
