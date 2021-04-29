Class {
	#name : #LudoMagicValidator,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
LudoMagicValidator >> validateAGamePlayedBy: players throwing: dices onBoardOf: size [
	| rules |
	rules := OrderedCollection new.
	LudoMagicGameRule subclassesDo: [ :aRule | rules add: aRule new ].
	rules
		select: [ :aRule | 
			aRule
				isNotAValidGamePlayedBy: players
				throwing: dices
				onBoardOf: size ]
		thenDo: [ :aRule | aRule throwError ]
		ifNone: [  ]
]
