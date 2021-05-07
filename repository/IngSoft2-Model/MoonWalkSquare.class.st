Class {
	#name : #MoonWalkSquare,
	#superclass : #Object,
	#instVars : [
		'n'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
MoonWalkSquare class >> with:en [ 
	^ self new initializeWith: en.
]

{ #category : #initalize }
MoonWalkSquare >> initializeWith: anInteger [ 
	n:= anInteger.
]

{ #category : #actions }
MoonWalkSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aFixedBoard [ 
	| players |
	players:= aFixedBoard players.
	players remove: aPlayer.
	players do:[:player| (aFixedBoard positionOf:player) moveBack: n ]
]
