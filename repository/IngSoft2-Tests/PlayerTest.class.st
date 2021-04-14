Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
PlayerTest >> testAPlayerStartsInPositionZero [
	| aPlayer |
	aPlayer:=  Player new.
	self assert: aPlayer position equals: 0.
	
]

{ #category : #'as yet unclassified' }
PlayerTest >> testAPlayerThrowsLoadedDiceOnceAndMoveForward [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withNumbers: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	aPlayer throws:{aLoadedDice} withFinishLine:8.
	
	self assert: aPlayer position  equals:  1.
]

{ #category : #'as yet unclassified' }
PlayerTest >> testAPlayerThrowsLoadedDices [
	
	|  aPlayer dices |
	dices := {  LoadedDice withNumbers: #(1 2 3 4 5) . LoadedDice withNumbers: #(3 4 5)  }.
	aPlayer:=  Player new.
	self assert: (aPlayer throws: dices withFinishLine:8) position equals: 4 .
]

{ #category : #'as yet unclassified' }
PlayerTest >> testAPlayerThrowsLoadedDicesTwiceAndMoveForward [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice withNumbers: #(4 5 6 7 8).
	aPlayer:=  Player new.
	
	aPlayer throws:{aLoadedDice} withFinishLine:8.
	aPlayer throws:{aLoadedDice} withFinishLine:8.
	
	self assert: aPlayer position  equals: 8.
]
