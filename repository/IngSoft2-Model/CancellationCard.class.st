Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToBeRemoved'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
CancellationCard >> applyTo: aPlayer in: aGame [ 
	aGame removePermanentCard: cardToBeRemoved from:aPlayer .
]

{ #category : #action }
CancellationCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAnInstantaneous: self from: aPlayer.
	aGame removePermanentCard: aTarget .
]

{ #category : #'editing keys' }
CancellationCard >> cancel: aCard [

	cardToBeRemoved := aCard.
]

{ #category : #initialization }
CancellationCard >> initialize [ 

	cardToBeRemoved:= Card new.
]
