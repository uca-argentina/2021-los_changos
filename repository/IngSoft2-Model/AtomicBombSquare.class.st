Class {
	#name : #AtomicBombSquare,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AtomicBombSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	aBoard moveAllPlayersToStart.
]
