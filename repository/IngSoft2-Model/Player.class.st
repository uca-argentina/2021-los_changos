Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model-Core'
}

{ #category : #accesing }
Player >> cards [
	^ cards copy.
]

{ #category : #actions }
Player >> initialize [ 

	cards:= OrderedCollection new .
]

{ #category : #action }
Player >> take: aCard [ 
	cards add: aCard.
]

{ #category : #actions }
Player >> throws: dices [
	
	dices isEmpty ifTrue: [ self error: 'Player cannot throw zero dices' ].
	
	^(dices collect:[ :dice | dice roll ]) sum .
]
