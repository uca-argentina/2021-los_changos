Class {
	#name : #Player,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
Player >> throws: dices [
	
	dices isEmpty ifTrue: [ self error: 'Player cannot throw zero dices' ].
	
	^(dices collect:[ :dice | dice roll ]) sum .
]
