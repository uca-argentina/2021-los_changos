Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SpeedCard >> applyTo: aPlayer in: aGame [ 
	aGame addEffectOf: self to: aPlayer.
]

{ #category : #action }
SpeedCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAPermanent: self  from: aPlayer.
	aGame addEffectOf: self to: aTarget.
]

{ #category : #accesing }
SpeedCard >> effect [
	^1.
]

{ #category : #accesing }
SpeedCard >> permanent [
	^true
]
