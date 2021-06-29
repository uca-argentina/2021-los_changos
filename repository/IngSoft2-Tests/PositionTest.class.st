Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNegativeLap [
	self
		should: [ Position of: 'jorge' at: 5 after: -1 ]
		raise: Error
		withExceptionDo: [ :error | 
			self
				assert: error messageText
				equals: Position notValidLapErrorMessage ]
]

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNegativeNumberOfSquare [
	self
		should: [ Position of: 'hernan' at: -3 after: 2 ]
		raise: Error
		withExceptionDo:
			[ :error | self assert: error messageText equals: Position notValidNumberOfSquare ]
]

{ #category : #tests }
PositionTest >> testNewPositionCannotHaveNumberOfSquareZero [
	self
		should: [ Position of: 'jorge' at: 0 after: 2 ]
		raise: Error
		withExceptionDo:
			[ :error | self assert: error messageText equals: Position notValidNumberOfSquare ]
]

{ #category : #tests }
PositionTest >> testNewPositionHasLapTwo [
	| aPosition |
	aPosition := Position of: 'julian' at: 3 after: 2.
	self assert: aPosition lap equals: 2
]

{ #category : #tests }
PositionTest >> testNewPositionHasLapZero [
	| aPosition |
	aPosition := Position of: 'jorge' at: 3 after: 0.
	self assert: aPosition lap equals: 0
]

{ #category : #tests }
PositionTest >> testNewPositionIsOnSquareNumberFive [
	| aPosition |
	aPosition := Position of: 'julian' at: 5 after: 1.
	self assert: aPosition numberOfSquare equals: 5
]
