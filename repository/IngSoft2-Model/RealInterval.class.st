Class {
	#name : #RealInterval,
	#superclass : #Object,
	#instVars : [
		'firstNumber',
		'secondNumber'
	],
	#category : #'IngSoft2-Model-Utilities'
}

{ #category : #'intance creation' }
RealInterval class >> from: firstNumber to: secondNumber [ 
	^ self new initializeFrom: firstNumber to: secondNumber 
]

{ #category : #boolean }
RealInterval >> includes: aNumber [ 
	^ aNumber between: firstNumber and: secondNumber  
]

{ #category : #initialization }
RealInterval >> initializeFrom: aFirstNumber to: aSecondNumber [
	firstNumber := aFirstNumber.
	secondNumber := aSecondNumber.
]
