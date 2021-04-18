Class {
	#name : #LudoMagicGameRule,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
LudoMagicGameRule >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [
self subclassResponsibility 
]

{ #category : #testing }
LudoMagicGameRule >> throwError [
 self subclassResponsibility 
]
