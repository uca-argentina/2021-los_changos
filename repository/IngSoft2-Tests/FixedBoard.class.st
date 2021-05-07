Class {
	#name : #FixedBoard,
	#superclass : #Board,
	#category : #'IngSoft2-Tests'
}

{ #category : #actions }
FixedBoard >> move: aPlayer back: anInteger [ 
	(self positionOf: aPlayer) moveBack:4.
]

{ #category : #actions }
FixedBoard >> moveAllPlayersToStart [
	positions do:[:position | position restart].
]
