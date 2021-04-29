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
GroupOfPlayersRule >> isNotValidBoardWith: size with: players and: dices [

^ players size <=1
	

]
