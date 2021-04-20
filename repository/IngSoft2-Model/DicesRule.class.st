Class {
	#name : #DicesRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
DicesRule >> errorMessage [
	^ 'Ludo Magic Game needs dices to start'
]

{ #category : #testing }
DicesRule >> isNotValidBoardWith: size with: players and: dices [
	
	^ dices size = 0
]
