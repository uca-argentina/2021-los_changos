Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aFixedBoard [ 
	aFixedBoard move: aPlayer withoutEffectTo: 4
]
