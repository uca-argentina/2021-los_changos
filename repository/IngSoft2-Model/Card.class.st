Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
Card >> applyTo: aTarget in: aGame from: aPlayer [
	self subclassResponsibility.
]
