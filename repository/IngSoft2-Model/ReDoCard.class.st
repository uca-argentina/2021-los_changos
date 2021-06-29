Class {
	#name : #ReDoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
ReDoCard >> applyTo: aTarget in: aGame from: aPlayer [
	| newCard |
	self validateIfIsPossibleToPlayReDoCardAt: aGame.
	newCard := aGame lastCardPlayed.
	aGame validate: aPlayer has: self.
	aGame addInHand: newCard to: aPlayer.
	aGame affect: aTarget using: newCard by: aPlayer
]

{ #category : #action }
ReDoCard >> validateIfIsPossibleToPlayReDoCardAt: aGame [
	aGame lastCardPlayed isNil
		ifTrue: [ self
				error: 'This card cannot be played because there was no card played before' ]
]
