Class {
	#name : #AccelerationCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AccelerationCard >> applyTo: players in: aGame [ 
	aGame addCardToAll:self.
]

{ #category : #accesing }
AccelerationCard >> effect [
	^ 1.
]

{ #category : #accesing }
AccelerationCard >> permanent [
	^true.
]
