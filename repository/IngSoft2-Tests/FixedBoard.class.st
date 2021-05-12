Class {
	#name : #FixedBoard,
	#superclass : #Board,
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
FixedBoard class >> playedBy: players withNumberOfLaps: laps with: squares [

	^ self new
		initializeBoardPlayedBy: players
		withNumberOfLaps: laps
		with: squares
]
