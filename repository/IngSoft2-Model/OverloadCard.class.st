Class {
	#name : #OverloadCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #action }
OverloadCard >> applyTo: aPlayer in: aGame [
	aGame add:self to:aPlayer. 
]

{ #category : #accesing }
OverloadCard >> effect [
	^-2.
]

{ #category : #accesing }
OverloadCard >> permanent [
	^true.
]
