Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AccelerationCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAPermanent: self  from: aPlayer.
	aGame addToAllEffectOf:self.
]

{ #category : #accesing }
AccelerationCard >> effect [
	^ 1.
]
