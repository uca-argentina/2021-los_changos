Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
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
]

{ #category : #accesing }
Player >> name [
	^ name
]

{ #category : #'as yet unclassified' }
Player >> throws: aDeterministicDice [ 
	^ aDeterministicDice throw .
]
