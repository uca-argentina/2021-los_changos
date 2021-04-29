Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
Dice class >> validate: numberOfFaces [
	
	numberOfFaces <= 2
		ifTrue: [self error: 'The number of faces must be greater than 1']
]

{ #category : #'instance creation' }
Dice class >> with: numberOfFaces [. 

	self validate: numberOfFaces.
	
	^self new initializeWithFaces: numberOfFaces .
]

{ #category : #initialize }
Dice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces:= aNumberOfFaces .
]

{ #category : #accesing }
Dice >> roll [
	^ Random new nextInt: (numberOfFaces).
]
