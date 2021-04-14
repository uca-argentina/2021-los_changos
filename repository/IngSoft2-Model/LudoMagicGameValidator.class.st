Class {
	#name : #LudoMagicGameValidator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
LudoMagicGameValidator >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [
self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameValidator >> throwError [
 self subclassResponsibility 
]
