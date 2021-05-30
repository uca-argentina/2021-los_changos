Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
WormHoleSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	board move: aPlayer backwards: 4.
]
