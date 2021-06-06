Class {
	#name : #ReDoCard,
	#superclass : #Card,
	#instVars : [
		'permanent',
		'card'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReDoCard class >> asInstantaneous [
	^self new initializeAsInstantaneous.
]

{ #category : #'instance creation' }
ReDoCard class >> asPermanent [
	^self new initializeAsPermanent.
]

{ #category : #action }
ReDoCard >> acquireBehaviourOf: aCard [
	card:= aCard.
	^aCard
]

{ #category : #action }
ReDoCard >> applyTo: aPlayer in: aGame [ 
	card applyTo: aPlayer in: aGame.
]

{ #category : #initialize }
ReDoCard >> initializeAsInstantaneous [
	permanent:= false.
]

{ #category : #initialization }
ReDoCard >> initializeAsPermanent [
	permanent:=true.
]

{ #category : #accesing }
ReDoCard >> permanent [
	^card permanent.
]
