Class {
	#name : #GroupOfPlayersValidator,
	#superclass : #BoardValidator,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GroupOfPlayersValidator >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [

^ aGroupOfPlayers size <=1
	

]

{ #category : #testing }
GroupOfPlayersValidator >> throwError [
 ^self error:'Cannot start a game with one player'
]
