Class {
	#name : #DicesRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model-Validators'
}

{ #category : #accessing }
DicesRule >> errorMessage [
	^ 'Ludo Magic Game needs dices to start'
]

{ #category : #testing }
DicesRule >> isNotAValidGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [
	^ dices isEmpty 
]
