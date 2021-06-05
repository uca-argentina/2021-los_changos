Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNegativeLap [

	self
		should: [  Position lap: -1 numberOfSquare: 5 for: Player new. ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Lap should be zero or greater' ].
]

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNegativeNumberOfSquare [

	self
		should: [  Position lap: 2 numberOfSquare: -3 for: Player new. ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Number of square should be greater than zero' ].
]

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNumberOfSquareZero [

	self
		should: [  Position lap: 2 numberOfSquare: 0 for: Player new. ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Number of square should be greater than zero' ].
]

{ #category : #tests }
PositionTest >> testNewPositionHasLapTwo [
	| aPosition |
	
	aPosition := Position lap: 2 numberOfSquare: 3 for: Player new.
	
	self assert: aPosition lap equals: 2.	

]

{ #category : #tests }
PositionTest >> testNewPositionHasLapZero [
	| aPosition |
	
	aPosition := Position lap: 0 numberOfSquare: 3 for: Player new.
	
	self assert: aPosition lap equals: 0.	

]

{ #category : #tests }
PositionTest >> testNewPositionIsOnSquareNumberFive [
	| aPosition |
	
	aPosition := Position lap: 1 numberOfSquare: 5 for: Player new.
	
	self assert: aPosition numberOfSquare equals: 5.	

]
