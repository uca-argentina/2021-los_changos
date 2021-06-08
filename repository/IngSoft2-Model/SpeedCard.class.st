Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SpeedCard >> applyTo: aPlayer in: aGame [ 
	aGame addEffectOf: self to: aPlayer.
]

{ #category : #accesing }
SpeedCard >> effect [
	^1.
]

{ #category : #accesing }
SpeedCard >> permanent [
	^true
]
