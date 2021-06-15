Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
WormHoleSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: board [
	board move: aPlayer backwards: 4.
]
