Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Player >> finished: aSize [
	^ position = aSize.
]

{ #category : #initialization }
Player >> initialize [
	position:= 0.
]

{ #category : #accessing }
Player >> position [
	^ position.
]

{ #category : #'as yet unclassified' }
Player >> throws: aCollectionOfDices withFinishLine: aSize [
	| roll |
	roll := (aCollectionOfDices collect:[ :dice | dice roll ]) sum .
	position := aSize min: position + roll.
]
