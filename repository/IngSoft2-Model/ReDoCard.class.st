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

{ #category : #action }
ReDoCard >> applyTo: aTarget in: aGame from: aPlayer [
	| newCard |
	aGame validate: aPlayer has: self.
	newCard := ((aGame lastCardPlayed) class) new.
	aGame addCardInHandOfAPlayer: newCard to: aPlayer.
	newCard applyTo: aTarget in:aGame from:aPlayer.
]
