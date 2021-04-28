Class {
	#name : #SizeBoardRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
SizeBoardRule >> errorMessage [
	^  'The size of the board must be greater than zero'
]

{ #category : #testing }
SizeBoardRule >> isNotValidBoardWith: size with: players and: dices [
	^ size <= 0
]
