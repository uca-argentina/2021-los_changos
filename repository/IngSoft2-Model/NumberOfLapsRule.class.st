Class {
	#name : #NumberOfLapsRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model-Validators'
}

{ #category : #accessing }
NumberOfLapsRule >> errorMessage [
	^ 'Number of laps must be greater than 0'
]

{ #category : #testing }
NumberOfLapsRule >> isNotAValidGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [
	^ laps <= 0
]
