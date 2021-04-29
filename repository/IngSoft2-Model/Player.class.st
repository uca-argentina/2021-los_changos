Class {
	#name : #Player,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Player >> throws: aCollectionOfDices [
	
	^(aCollectionOfDices collect:[ :dice | dice roll ]) sum .
]
