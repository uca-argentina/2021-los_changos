Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'arrayOfNumbers',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DeterministicDice class >> withNumbers: anArrayOfNumbers [
	^self new initializeWithNumbers: anArrayOfNumbers.
]

{ #category : #initialization }
DeterministicDice >> initializeWithNumbers: anArrayOfNumbers [
	index:=1.
	arrayOfNumbers:= anArrayOfNumbers.
]

{ #category : #'as yet unclassified' }
DeterministicDice >> throw [
	| number |
	number:=arrayOfNumbers at: index.
	index:=(index rem: arrayOfNumbers size) +1.
	^number.
	
]
