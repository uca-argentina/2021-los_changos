Class {
	#name : #BoardValidator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
BoardValidator >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [
self subclassResponsibility 
]

{ #category : #testing }
BoardValidator >> throwError [
 self subclassResponsibility 
]
