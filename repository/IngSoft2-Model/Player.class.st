Class {
	#name : #Player,
	#superclass : #Object,
	#category : #'IngSoft2-Model-Core'
}

{ #category : #actions }
Player >> initialize [ 

]

{ #category : #actions }
Player >> throws: dices [
	
	dices isEmpty ifTrue: [ self error: 'Player cannot throw zero dices' ].
	
	^(dices collect:[ :dice | dice roll ]) sum .
]

{ #category : #action }
Player >> throws: aCard to: aPlayer in: aGame [
	(aGame isTurnOf: self) ifFalse:[self error: 'The player cannot throw this card because it is not his turn'].
	(aGame has: self theCard: aCard) ifFalse:[self error: 'The player cannot throw this card because he does not have it'].
	aGame add: aCard to: aPlayer.
	aGame remove: aCard from: self.
]
