Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#instVars : [
		'cardToBeRemoved'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aPlayer in: aGame [ 
	aGame removePermanentCard: cardToBeRemoved from:aPlayer .
]

{ #category : #'editing keys' }
CancellationCard >> cancel: aCard [

	cardToBeRemoved := aCard.
]

{ #category : #initialization }
CancellationCard >> initialize [ 

	cardToBeRemoved:= Card new.
]

{ #category : #accesing }
CancellationCard >> permanent [
	^false.
]
