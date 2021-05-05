Class {
	#name : #LudoMagicGameRule,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Validators'
}

{ #category : #accessing }
LudoMagicGameRule >> errorMessage [
	self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameRule >> isNotAValidGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [
	self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameRule >> throwError [
	^ self error: self errorMessage
]
