Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'numberOfFaces'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #validation }
Dice class >> validateADiceWithFaces: aNumberOfFaces [
	
	aNumberOfFaces <= 2
		ifTrue: [self error: 'The number of faces must be greater than 1']
]

{ #category : #'instance creation' }
Dice class >> withFaces: numberOfFaces [. 

	self validateADiceWithFaces: numberOfFaces.
	
	^self new initializeWithFaces: numberOfFaces .
]

{ #category : #initialize }
Dice >> initializeWithFaces: aNumberOfFaces [
	numberOfFaces:= aNumberOfFaces .
]

{ #category : #accessing }
Dice >> roll [
	^ Random new nextInt: (numberOfFaces).
]
