Class {
	#name : #ProbabilisticEvent,
	#superclass : #Object,
	#instVars : [
		'probability',
		'object'
	],
	#category : #'IngSoft2-Model-Utilities'
}

{ #category : #'as yet unclassified' }
ProbabilisticEvent class >> notValidProbabilityMessage [
	^ 'Probability should be between 0 and 1'
]

{ #category : #'instance creation' }
ProbabilisticEvent class >> validateIsInRange: aProbability [
	(aProbability between: 0 and: 1)
		ifFalse: [ self error: self notValidProbabilityMessage ]
]

{ #category : #'instance creation' }
ProbabilisticEvent class >> with: aProbability for: anObject [

	self validateIsInRange: aProbability.
	^ self new initializeWith: aProbability for: anObject.
]

{ #category : #initialization }
ProbabilisticEvent >> initializeWith: aProbability for: anObject [
	
	probability := aProbability.
	object := anObject
]

{ #category : #accessing }
ProbabilisticEvent >> object [
	^ object
]

{ #category : #accesing }
ProbabilisticEvent >> probability [
	^ probability
]
