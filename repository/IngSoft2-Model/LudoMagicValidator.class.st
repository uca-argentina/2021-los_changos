Class {
	#name : #LudoMagicValidator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
LudoMagicValidator >> valid: aCollectionOfPlayers with: aCollectionOfDices with: aSize [

	| rules |
	rules := OrderedCollection new. 
	LudoMagicGameRule subclassesDo: [ :aRule | rules add: aRule new ].
	
	rules select: [ :aRule | aRule isNotValidBoardWithSize: aSize withPlayers: aCollectionOfPlayers andDices: aCollectionOfDices ] thenDo: [ :aRule | aRule throwError ] ifNone: [].
]
