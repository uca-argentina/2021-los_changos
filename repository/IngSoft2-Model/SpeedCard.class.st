Class {
	#name : #SpeedCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
SpeedCard >> applyTo: aPlayer in: aGame [ 
	aGame add: self to: aPlayer.
]

{ #category : #accesing }
SpeedCard >> effect [
	^1.
]

{ #category : #accesing }
SpeedCard >> permanent [
	^true
]
