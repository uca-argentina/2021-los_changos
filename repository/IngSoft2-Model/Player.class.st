Class {
	#name : #Player,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Player >> throws: dices [
	
	^(dices collect:[ :dice | dice roll ]) sum .
]
