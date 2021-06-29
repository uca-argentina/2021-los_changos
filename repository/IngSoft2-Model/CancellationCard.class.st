Class {
	#name : #CancellationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
CancellationCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAnInstantaneous: self from: aPlayer.
	aGame removeToAllPlayersPermanent: aTarget .
]
