Class {
	#name : #LudoMagicGameRule,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
LudoMagicGameRule >> errorMessage [
	self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameRule >> isNotValidBoardWith: size with: players and: dices [
self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameRule >> throwError [
	^ self error: self errorMessage
]
