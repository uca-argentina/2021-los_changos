Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testACancellationCardIsNotPermanent [

	| aCard |
	aCard:= CancellationCard new.
	
	self assert: aCard permanent equals: false.
]

{ #category : #tests }
CardTest >> testAPermanentReDoCardIsPermanent [

	| aCard |
	aCard:= ReDoCard asPermanent.
	
	self assert: aCard permanent equals: true.
]

{ #category : #tests }
CardTest >> testARepeatCardIsNotPermanent [

	| aCard |
	aCard:= RepeatCard new.
	
	self assert: aCard permanent equals: false.
]

{ #category : #tests }
CardTest >> testASpeedCardIsPermanent [

	| aCard |
	aCard:= SpeedCard new.
	
	self assert: aCard permanent equals: true.
]

{ #category : #tests }
CardTest >> testAnAccelerationCardIsPermanent [

	| aCard |
	aCard:= AccelerationCard new.
	
	self assert: aCard permanent equals: true.
]

{ #category : #tests }
CardTest >> testAnInstantaneousReDoCardIsNotPermanent [

	| aCard |
	aCard:= ReDoCard asInstantaneous.
	
	self assert: aCard permanent equals: false.
]

{ #category : #tests }
CardTest >> testAnOverloadCardIsPermament [

	| aCard |
	aCard:= OverloadCard new.
	
	self assert: aCard permanent equals: true.
]
