Class {
	#name : #WormHoleSquare,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
WormHoleSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	board move: aPlayer back: 4.
]
