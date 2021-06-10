Class {
	#name : #EmptyCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
EmptyCard >> applyTo: aTarget in: aGame from: aPlayer [
	self error:'This card cannot be played because there was no card played before'.
]
