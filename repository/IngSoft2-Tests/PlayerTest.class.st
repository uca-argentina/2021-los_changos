Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testAPlayerStartsInPositionZero [
	| aPlayer |
	aPlayer := Player new.
	self assert: aPlayer position equals: 0
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDiceOnceAndMoveForward [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice with: #(1 2 3 4 5).
	aPlayer:=  Player new.
	
	aPlayer throws: {aLoadedDice} with:8.
	
	self assert: aPlayer position equals:  1.
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDices [
	
	|  aPlayer dices |
	dices := {  LoadedDice with: #(1 2 3 4 5) . LoadedDice with: #(3 4 5)  }.
	aPlayer:=  Player new.
	self assert: (aPlayer throws: dices with:8) position equals: 4 .
]

{ #category : #tests }
PlayerTest >> testAPlayerThrowsLoadedDicesTwiceAndMoveForward [
	
	| aLoadedDice aPlayer |
	
	aLoadedDice := LoadedDice with: #(4 5 6 7 8).
	aPlayer:=  Player new.
	
	aPlayer throws:{aLoadedDice} with:8.
	aPlayer throws:{aLoadedDice} with:8.
	
	self assert: aPlayer position  equals: 8.
]
