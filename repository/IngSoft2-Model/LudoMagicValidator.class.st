Class {
	#name : #LudoMagicValidator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
LudoMagicValidator >> valid: players with: dices with: aSize [

	| rules |
	rules := OrderedCollection new. 
	LudoMagicGameRule subclassesDo: [ :aRule | rules add: aRule new ].
	
	rules select: [ :aRule | aRule isNotValidBoardWith: aSize with: players and: dices ] thenDo: [ :aRule | aRule throwError ] ifNone: [].
]
