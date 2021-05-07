Class {
	#name : #SpeedUpSquare,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aFixedBoard [ 
	(aFixedBoard positionOf:aPlayer) move: 4 upTo: (aFixedBoard size). 
]
