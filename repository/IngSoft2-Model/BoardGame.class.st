Class {
	#name : #BoardGame,
	#superclass : #Object,
	#instVars : [
		'size',
		'players'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #instanceCreation }
BoardGame class >> withSize: aNumber andPlayers: aCollectionOfPlayers [
	
	^self new initializeWithSize: aNumber andPlayers: aCollectionOfPlayers.
]

{ #category : #accesing }
BoardGame >> boardSize [
	^size.
]

{ #category : #initialize }
BoardGame >> initializeWithSize: aNumber andPlayers: aCollectionOfPlayers [
	size:= aNumber.
	players:= aCollectionOfPlayers.
]

{ #category : #accessing }
BoardGame >> players [
	^ players copy.
]

{ #category : #accessing }
BoardGame >> positionOf: aPlayer [ 
	
	| result |
	result:= players detect:[: player| player isEqualTo: aPlayer]
	ifNone:['Cannot bring position of aPlayer'].
	^(result position)
		
]
