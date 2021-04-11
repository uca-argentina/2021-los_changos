Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player >> initialize [
	position:= 0.
]

{ #category : #accessing }
Player >> position [
	^ position.
]

{ #category : #'as yet unclassified' }
Player >> throws: aCollectionOfDices [
	| roll |
	roll := (aCollectionOfDices collect:[ :dice | dice roll ]) sum .
	position := position + roll.
	
	^roll
]
