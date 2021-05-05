Class {
	#name : #SizeBoardRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model-Validators'
}

{ #category : #accessing }
SizeBoardRule >> errorMessage [
	^  'The size of the board must be greater than zero'
]

{ #category : #testing }
SizeBoardRule >> isNotAValidGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [
	^ size <= 0
]
