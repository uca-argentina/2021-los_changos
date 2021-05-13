Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testANewPositionAdvanceASquare [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition movePlayerForward: 1 upTo: 10.
	self assert: aPosition quantityOfSquaresAdvanced equals: 2.
]

{ #category : #tests }
PositionTest >> testANewPositionAdvanceFourValuesAndThenThreeValues [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition movePlayerForward: 4 upTo: 10.
	aPosition movePlayerForward: 3 upTo: 10.
	self assert: aPosition quantityOfSquaresAdvanced equals: 8.
]

{ #category : #tests }
PositionTest >> testANewPositionRealizedNoMoves [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	self assert: aPosition quantityOfSquaresAdvanced equals: 1.
]

{ #category : #tests }
PositionTest >> testANewPositionStopsAtLimit [
	| aPosition |
	aPosition := Position assignedTo: Player new.
	aPosition movePlayerForward: 23 upTo: 10.
	self assert: aPosition quantityOfSquaresAdvanced equals: 10.
]
