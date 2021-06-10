Class {
	#name : #DeliveryCardSquare,
	#superclass : #Square,
	#instVars : [
		'card'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
DeliveryCardSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	aBoard giveCardFromDeckTo: aPlayer.
]
