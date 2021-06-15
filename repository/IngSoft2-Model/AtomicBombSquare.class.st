Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
AtomicBombSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [
	aBoard restartPositionOfAllPlayers.
]
