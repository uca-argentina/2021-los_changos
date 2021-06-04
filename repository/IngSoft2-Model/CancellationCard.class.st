Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
CancellationCard >> applyTo: aPlayer in: aLudoMagicGame [ 
	self shouldBeImplemented.
]

{ #category : #accesing }
CancellationCard >> permanent [
	^false.
]
