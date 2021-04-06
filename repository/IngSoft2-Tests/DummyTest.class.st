Class {
	#name : #DummyTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DummyTest >> testDummy [
	"Esto es una prueba"
	self assert: Dummy new isDummy
]
