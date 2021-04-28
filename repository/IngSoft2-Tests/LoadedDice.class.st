Class {
	#name : #LoadedDice,
	#superclass : #Object,
	#instVars : [
		'numbers',
		'nextValue'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDice class >> with: aCollectionOfNumbers [
	^self new initializeWith: aCollectionOfNumbers.
]

{ #category : #initialization }
LoadedDice >> initializeWith: aCollectionOfNumbers [
	nextValue:=1.
	numbers:= aCollectionOfNumbers.
]

{ #category : #accessing }
LoadedDice >> roll [
	| number |
	number:=numbers at: nextValue.
	nextValue:=(nextValue rem: numbers size) +1.
	^number.
	
]
