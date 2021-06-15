Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard move: aPlayer withoutEffectTo: 4
]
