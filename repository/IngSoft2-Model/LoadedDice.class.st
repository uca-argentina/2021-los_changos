Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'arrayOfNumbers',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDice class >> withNumbers: anArrayOfNumbers [
	^self new initializeWithNumbers: anArrayOfNumbers.
]

{ #category : #initialization }
LoadedDice >> initializeWithNumbers: anArrayOfNumbers [
	index:=1.
	arrayOfNumbers:= anArrayOfNumbers.
]

{ #category : #'as yet unclassified' }
LoadedDice >> roll [
	| number |
	number:=arrayOfNumbers at: index.
	index:=(index rem: arrayOfNumbers size) +1.
	^number.
	
]
