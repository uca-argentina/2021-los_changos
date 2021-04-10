Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: aName [ 
	^ self new initializeWithAName:aName.
]

{ #category : #initialization }
Player >> initializeWithAName: aName [ 
	name:= aName.
	position:= 0.
]

{ #category : #accesing }
Player >> name [
	^ name
]

{ #category : #accessing }
Player >> position [
	^ position.
]

{ #category : #'as yet unclassified' }
Player >> throws: aDeterministicDice [ 
	^ aDeterministicDice throw .
]
