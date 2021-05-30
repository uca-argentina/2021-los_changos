Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayerCannotThrowZeroDices [

	|  aPlayer |

	aPlayer:=  Player new.
	self
		should: [  aPlayer throws:{} ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: 'Player cannot throw zero dices' ].
]

{ #category : #tests }
PlayerTest >> testAPlayerReceivesANewCard [
	
	|aPlayer |
	
	aPlayer:=  Player new.
	aPlayer take: Card new.
		
	self assert: aPlayer cards size equals: 1.
]

{ #category : #tests }
PlayerTest >> testAPlayerThatHasNoCards [
	
	|aPlayer |
	
	aPlayer:=  Player new.

	
	self assert: aPlayer cards size equals: 0.
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDiceOnce [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withValues: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	
	
	self assert: (aPlayer throws: {aLoadedDice}) equals:  1.
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDices [
	
	|  aPlayer dices |
	dices := {  LoadedDice withValues: #(1 2 3 4 5) . LoadedDice withValues: #(3 4 5)  }.
	aPlayer:=  Player new.
	self assert: (aPlayer throws: dices) equals: 4 .
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDicesTwiceAndMoveForward [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withValues: #(4 5 6 7 8).
	aPlayer:=  Player new.
	
	aPlayer throws:{aLoadedDice}.
	aPlayer throws:{aLoadedDice}.
	
	self assert: (aPlayer throws:{aLoadedDice}) equals: 6.
]
