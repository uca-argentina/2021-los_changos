Class {
	#name : #GroupOfPlayersRule,
	#superclass : #LudoMagicGameRule,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GroupOfPlayersRule >> isNotValidBoardWithSize:aSize withPlayers:aGroupOfPlayers andDices: aGroupOfDices [

^ aGroupOfPlayers size <=1
	

]

{ #category : #testing }
GroupOfPlayersRule >> throwError [
 ^self error:'Cannot start a game with one player'
]
