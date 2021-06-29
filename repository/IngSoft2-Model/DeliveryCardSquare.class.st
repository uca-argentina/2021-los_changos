Class {
	#name : #DeliveryCardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
DeliveryCardSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard giveCardFromDeckTo: aPlayer.
]
