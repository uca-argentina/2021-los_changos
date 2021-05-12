Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'numberOfSquaresToMoveBackwards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #'instance creation' }
MoonWalkSquare class >> with: numberOfSquaresToMoveBackwards [ 
	^ self new initializeWith: numberOfSquaresToMoveBackwards.
]

{ #category : #initalize }
MoonWalkSquare >> initializeWith: aNumberOfSquaresToMoveBackwards [ 
	numberOfSquaresToMoveBackwards:= aNumberOfSquaresToMoveBackwards.
]

{ #category : #actions }
MoonWalkSquare >> makeEffectOn: aPlayer thatHasItsPositionIn: aBoard [ 
	| players |
	players:= aBoard players.
	players remove: aPlayer.
	players do:[:player| (aBoard positionOf:player) moveBackwards: numberOfSquaresToMoveBackwards ]
]
