Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
RepeatCard >> applyTo: aPlayer in: aGame [
	aGame applyEffectOfTheLastPlayedSquaresTo: aPlayer.
]

{ #category : #accesing }
RepeatCard >> permanent [
	^false.
]
