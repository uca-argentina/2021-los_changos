Class {
	#name : #GroupOfPlayersRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model-Validators'
}

{ #category : #accessing }
GroupOfPlayersRule >> errorMessage [ 
	^ 'Quantity of players shloud be greater than one'
]

{ #category : #testing }
GroupOfPlayersRule >> isNotAValidGamePlayedBy: players throwing: dices withNumberOfLaps: laps onBoardOf: size [

^ players size <= 1.
	

]
