Class {
	#name : #SizeBoardValidator,
	#superclass : #LudoMagicGameValidator,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
SizeBoardValidator >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [
	^ aSize <= 0
]

{ #category : #testing }
SizeBoardValidator >> throwError [
 ^ self error: 'The size of the board must be greater than zero'
]
