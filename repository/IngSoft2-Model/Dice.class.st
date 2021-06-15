Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #validation }
Dice class >> notValidNumberOfFacesErrorMessage [
	^ 'The number of faces must be greater than 1'
]

{ #category : #validation }
Dice class >> validateNumberOfFaces: aNumberOfFaces [
	aNumberOfFaces <= 2
		ifTrue: [ self error: self notValidNumberOfFacesErrorMessage ]
]

{ #category : #'instance creation' }
Dice class >> withFaces: numberOfFaces [. 

	self validateNumberOfFaces: numberOfFaces.
	
	^self new initializeWithFaces: numberOfFaces .
]

{ #category : #initialize }
Dice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces:= aNumberOfFaces .
]

{ #category : #action }
Dice >> roll [
	^ Random new nextInt: (numberOfFaces).
]
