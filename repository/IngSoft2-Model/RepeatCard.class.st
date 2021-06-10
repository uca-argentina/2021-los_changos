Class {
	#name : #RepeatCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
RepeatCard >> applyTo: aPlayer in: aGame [
	aGame applyEffectOfTheLastPlayedSquaresTo: aPlayer.
]

{ #category : #action }
RepeatCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAnInstantaneous: self from: aPlayer.
	aGame applyEffectOfTheLastPlayedSquaresTo: aTarget.
]
