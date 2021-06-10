Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AccelerationCard >> applyTo: players in: aGame [ 
	aGame addEffectToAllOf:self.
]

{ #category : #action }
AccelerationCard >> applyTo: aTarget in: aGame from: aPlayer [
	aGame validateThrowOfAPermanent: self  from: aPlayer.
	aGame addEffectToAllOf:self.
]

{ #category : #accesing }
AccelerationCard >> effect [
	^ 1.
]
