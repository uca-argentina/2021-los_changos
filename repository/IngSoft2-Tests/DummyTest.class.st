Class {
	#name : #DummyTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DummyTest >> testDummy [
 "comentario del poron"
	self assert: Chona new isDummy
]
