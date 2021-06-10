Class {
	#name : #Square,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
Square >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	self subclassResponsibility.
]
