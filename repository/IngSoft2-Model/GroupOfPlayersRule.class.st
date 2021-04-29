Class {
	#name : #GroupOfPlayersRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
GroupOfPlayersRule >> errorMessage [ 
	^ 'Quantity of players shloud be greater than one'
]

{ #category : #testing }
GroupOfPlayersRule >> isNotAValidGamePlayedBy: players throwing: dices onBoardOf: size [

^ players size <= 1.
	

]
