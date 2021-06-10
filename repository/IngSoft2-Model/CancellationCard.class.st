Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToBeRemoved'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
CancellationCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAnInstantaneous: self from: aPlayer.
	aGame removePermanentCard: aTarget .
]
