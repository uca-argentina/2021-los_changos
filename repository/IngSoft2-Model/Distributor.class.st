Class {
	#name : #Distributor,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Distributor class >> of: aGroupOfObjects withProportions: proportions andSize: aSize [
	| orderedKeys squares aDictionary |
	self validateProportions: proportions.
	self validateQuantityOf: aGroupOfObjects  and: proportions.
	
	aDictionary := OrderedDictionary
		newFromKeys: aGroupOfObjects
		andValues: proportions.
	orderedKeys := (aDictionary associations
		asSortedCollection: [ :x :y | x value < y value ])
		collect: [ :assoc | assoc key ].
	squares := OrderedCollection new.
	orderedKeys
		do: [ :instance | 
			squares
				add: instance
				withOccurrences: (aSize * (aDictionary at: instance) / 100) ceiling ].
	squares removeLast: squares size - aSize.
	^ squares shuffle
]

{ #category : #'instance creation' }
Distributor class >> validateProportions: proportions [
	proportions sum = 100
		ifFalse: [ self error: 'The proportions do not sum 100' ]
]

{ #category : #'instance creation' }
Distributor class >> validateQuantityOf: aGroupOfObjects and: proportions [
	aGroupOfObjects size = proportions size
		ifFalse: [ self
				error: 'The number of objects do not match with the number of proportions' ]
]
