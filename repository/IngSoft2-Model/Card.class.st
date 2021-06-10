Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
Card >> acquireBehaviourOf: aCard [
]

{ #category : #accesing }
Card >> applyTo: aPlayer in: aGame [ 
	self subclassResponsibility 
]

{ #category : #action }
Card >> applyTo: aTarget in: aGame from: aPlayer [
	self subclassResponsibility.
]

{ #category : #accesing }
Card >> permanent [
	self subclassResponsibility 
]
