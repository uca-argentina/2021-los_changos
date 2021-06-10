Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
OverloadCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAPermanent: self  from: aPlayer.
	aGame addEffectOf:self to:aTarget. 
]

{ #category : #accesing }
OverloadCard >> effect [
	^-2.
]
