Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accesing }
OverloadCard >> effect [
	^-2.
]

{ #category : #actions }
OverloadCard >> makeEffect: value [
	
	^ value - 2
]

{ #category : #accesing }
OverloadCard >> permanent [
	^true.
]
