Class {
	#name : #ReDoCard,
	#superclass : #Card,
	#instVars : [
		'permanent',
		'card'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
ReDoCard >> acquireBehaviourOf: aCard [
	card:= aCard.
	^aCard
]

{ #category : #action }
ReDoCard >> applyTo: aPlayer in: aGame [ 
	card applyTo: aPlayer in: aGame.
]

{ #category : #accesing }
ReDoCard >> permanent [
	^card permanent.
]
