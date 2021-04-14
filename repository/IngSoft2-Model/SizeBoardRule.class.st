Class {
	#name : #SizeBoardRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
SizeBoardRule >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [
	^ aSize <= 0
]

{ #category : #testing }
SizeBoardRule >> throwError [
 ^ self error: 'The size of the board must be greater than zero'
]
