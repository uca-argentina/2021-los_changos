Class {
	#name : #ProbabilisticDistributorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
ProbabilisticDistributorTest >> assert: aProbabilisticDistributor generates: aGroupGeneratedByTheProbabilisticDistributor withTolerance: aTolerance [
			
	| realProportionsByEvent tolerances  |
	realProportionsByEvent := self getProportionsByEventFrom: aGroupGeneratedByTheProbabilisticDistributor with: aProbabilisticDistributor events.
	tolerances := aProbabilisticDistributor events collect: [ 
				:event | ((realProportionsByEvent at: event ) - ((event probability ) )) abs * 100 ].
	self assert: ( tolerances allSatisfy: [:tolerance | (tolerance <= aTolerance) ])
	
	
	
	


]

{ #category : #'as yet unclassified' }
ProbabilisticDistributorTest >> getProportionsByEventFrom: groupGenerated with: events [
	| proportionsByEvent realProportion |
	proportionsByEvent := Dictionary new.
	
	events do: [ :event | 
		realProportion :=  ((groupGenerated count: [ :item | item = event object ])/(groupGenerated size)).
		proportionsByEvent at: event put: realProportion   .      ].
	
	^proportionsByEvent .
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabilisticDistributorCannotBeCreatedWithEmptyEvents [
	self should: [ ProbabilisticDistributor with: {  } ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticDistributor notValidGroupOfEventsMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabilisticDistributorGenerateAGroupOfObjectsThatAreEquallyDistributed [
	| result events distributor |
	result:= {3. 3. 3. 3. 3}.
	events:={ProbabilisticEvent withProbabilityOf: 1 for: 3}.
	distributor:= ProbabilisticDistributor with: events.
	self assert: (distributor generate: 5)  equals: result.

	
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabilisticEventCannotBeCreatedWithProbabilityGreaterThanOne [
	self
		should: [ ProbabilisticEvent with: 1.1 for: Object ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticEvent notValidProbabilityMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabilisticEventCannotBeCreatedWithProbabilityLowerThanZero [
	self
		should: [ ProbabilisticEvent with: -2 for: Object ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticEvent notValidProbabilityMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorCannotHaveEventsWithAllEventsInOne [
	| events |
	events := { ProbabilisticEvent with: 1 for: 6 . ProbabilisticEvent with: 1 for: 10 }.
																		
	self should: [ ProbabilisticDistributor with: events ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticDistributor notValidGroupOfEventsMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorCannotHaveEventsWithAllEventsInZero [
	| events |
	events := { ProbabilisticEvent with: 0 for: 6 . ProbabilisticEvent with: 0 for: 10 }.
																		
	self should: [ ProbabilisticDistributor with: events ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticDistributor notValidGroupOfEventsMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorCannotHaveSumOfEventsProbabilitiesNotEqualToOne [
	| events |
	events := { ProbabilisticEvent with: 0.1 for: 6 . ProbabilisticEvent with: 0.4 for: 10 }.
																		
	self should: [ ProbabilisticDistributor with: events ]
		raise: Error
		withExceptionDo: [ :error | self assert: error messageText equals: ProbabilisticDistributor notValidGroupOfEventsMessage ].
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithEventsGenerateWithCorrectSize [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 1 for: 'anotherItem' .
		ProbabilisticEvent with: 0 for: 'someItem'
	}.
	self assert: (aProbabilisticDistributor generate: 100) size equals: 100.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithFiveEventsGenerateAGroupWithToleranceOfFiveOrBelow [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 0.5 for: 'firstItem' .
		ProbabilisticEvent with: 0.1 for: 'secondItem' .
		ProbabilisticEvent with: 0.1 for: 'thirdItem' . 
		ProbabilisticEvent with: 0 for: 'fourthItem' .
		ProbabilisticEvent with: 0.3 for: 'fifthItem'
	}.
	self assert: aProbabilisticDistributor generates: (aProbabilisticDistributor generate: 10000) withTolerance: 5.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithFiveEventsHasNoItemFromEventWithProbabilityZero [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 0.5 for: 'firstItem' .
		ProbabilisticEvent with: 0.1 for: 'secondItem' .
		ProbabilisticEvent with: 0.1 for: 'thirdItem' . 
		ProbabilisticEvent with: 0 for: 'fourthItem' .
		ProbabilisticEvent with: 0.3 for: 'fifthItem'
	}.
	self assert: ((aProbabilisticDistributor generate: 100000) includes: 'fourthItem') not.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithOneEventGenerateAllEqualItems [
	| aProbabilisticDistributor |

	aProbabilisticDistributor := ProbabilisticDistributor with: { ProbabilisticEvent with: 1 for: 'someItem' }.
	
	
	self assert: ((aProbabilisticDistributor generate: 10) allSatisfy: [ :item | 'someItem' = item ])
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithOneEventGenerateWithToleranceZero [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { ProbabilisticEvent with: 1 for: 'someItem' }.
	self assert: aProbabilisticDistributor generates: (aProbabilisticDistributor generate: 100) withTolerance: 0.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithOneEventPickThatEvent [
	| aProbabilisticDistributor anObject aProbabilisticEvent |
	
	anObject := 10.
	aProbabilisticEvent := ProbabilisticEvent with: 1 for: anObject.
	aProbabilisticDistributor := ProbabilisticDistributor with: { aProbabilisticEvent  }.
	
	self assert: aProbabilisticDistributor pick equals: anObject.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithOneItemWithEqualProbability [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor withEqualProbability: { 1 }.
	self assert: aProbabilisticDistributor generates: (aProbabilisticDistributor generate: 1000000) withTolerance: 0
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithThreeItemsWithEqualProbability [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor withEqualProbability: { 1 . 5 . 9 }.
	self assert: aProbabilisticDistributor generates: (aProbabilisticDistributor generate: 1000000) withTolerance: 5
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithTwoEventsGenerateAllEqualItemsThatAreNotOfTheEventWithProbabilityZero [
	| aProbabilisticDistributor |

	aProbabilisticDistributor := ProbabilisticDistributor with: { 
																																ProbabilisticEvent with: 0 for: 'itemZero' .
																																ProbabilisticEvent with: 1 for: 'anotherItem' }.
	
	
	self assert: ((aProbabilisticDistributor generate: 10) allSatisfy: [ :item | 'anotherItem' = item ])
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithTwoEventsThatOneHasProbabilityZeroPickTheOtherEvent [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { ProbabilisticEvent with: 1 for: 9 . ProbabilisticEvent with: 0 for: 1 }.
	self assert: aProbabilisticDistributor pick equals: 9.
]

{ #category : #tests }
ProbabilisticDistributorTest >> testAProbabiliticDistributorWithTwoEventsWithZeroAndOneOfProbabilityAndGenerateWithToleranceZero [
	| aProbabilisticDistributor |
	aProbabilisticDistributor := ProbabilisticDistributor with: { 
		ProbabilisticEvent with: 1 for: 'anotherItem' .
		ProbabilisticEvent with: 0 for: 'someItem'
	}.
	self assert: aProbabilisticDistributor generates: (aProbabilisticDistributor generate: 100) withTolerance: 0.
]
