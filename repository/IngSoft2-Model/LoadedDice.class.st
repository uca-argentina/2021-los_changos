Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'index',
		'numbers'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LoadedDice class >> with: aCollectionOfNumbers [
	^self new initializeWith: aCollectionOfNumbers.
]

{ #category : #initialization }
LoadedDice >> initializeWith: aCollectionOfNumbers [
	index:=1.
	numbers:= aCollectionOfNumbers.
]

{ #category : #accessing }
LoadedDice >> roll [
	| number |
	number:=numbers at: index.
	index:=(index rem: numbers size) +1.
	^number.
	
]
