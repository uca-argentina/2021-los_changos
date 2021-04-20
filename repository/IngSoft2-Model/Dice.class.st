Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Dice class >> with: numberOfFaces [. 
	^ self new initializeWith: numberOfFaces .
]

{ #category : #initialize }
Dice >> initializeWith: aNumberOfFaces [
	numberOfFaces:= aNumberOfFaces .
]

{ #category : #accesing }
Dice >> roll [
	^ Random new nextInt: (numberOfFaces).
]
