Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
SpeedUpSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aFixedBoard [ 
	(aFixedBoard positionOf: aPlayer ) movePlayerForward: 4 upTo: (aFixedBoard quantityOfSquaresToAdvance ). 
]
