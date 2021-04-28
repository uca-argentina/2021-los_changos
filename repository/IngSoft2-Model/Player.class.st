Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Player >> finished: aFinishLine [
	^ position = aFinishLine.
]

{ #category : #initialization }
Player >> initialize [
	position:= 0.
]

{ #category : #accessing }
Player >> position [
	^ position.
]

{ #category : #actions }
Player >> throws: aCollectionOfDices with: aFinishLine [
	| roll |
	roll := (aCollectionOfDices collect:[ :dice | dice roll ]) sum .
	position := aFinishLine min: position + roll.
]
