Class {
	#name : #ReDoCard,
	#superclass : #Object,
	#instVars : [
		'permanent'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReDoCard class >> asInstantaneous [
	^self new initializeAsInstantaneous.
]

{ #category : #'instance creation' }
ReDoCard class >> asPermanent [
	^self new initializeAsPermanent.
]

{ #category : #initialize }
ReDoCard >> initializeAsInstantaneous [
	permanent:= false.
]

{ #category : #initialization }
ReDoCard >> initializeAsPermanent [
	permanent:=true.
]

{ #category : #accesing }
ReDoCard >> permanent [
	^permanent.
]
