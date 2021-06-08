Class {
	#name : #AccelerationCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AccelerationCard >> applyTo: players in: aGame [ 
	aGame addEffectToAllOf:self.
]

{ #category : #accesing }
AccelerationCard >> effect [
	^ 1.
]

{ #category : #accesing }
AccelerationCard >> permanent [
	^true.
]
