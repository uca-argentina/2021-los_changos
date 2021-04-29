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
DicesRule >> isNotAValidGamePlayedBy: players throwing: dices onBoardOf: size [
	
	^ dices isEmpty 
]
