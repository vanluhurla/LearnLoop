//
//  HomeViewModelTests.swift
//  LearnLoopTests
//
//  Created by Vanessa Lucena on 12/01/2025.
//

import Testing
import SwiftData
@testable import LearnLoop

@MainActor
struct HomeViewModelTests {
    private let testDependencies = TestingDependencies()
    private var contextMock: ModelContext {
        testDependencies.container.mainContext
    }
    private var deckMock: Deck!
    
    var sut: HomeViewModel!
    
    init() {
        deckMock = Deck()
        sut = HomeViewModel(context: contextMock)
    }
    
    @Test func fetchDecksWithEmptyContext() {
        // Given
        // No decks are included on the context
        // When
        sut.fetchDecks()
        // Then
        #expect(sut.decks.count == 0)
    }
    
    @Test func fetchDecksWithContextPopulated() throws {
        // Given
        try addDeck()
        // When
        sut.fetchDecks()
        // Then
        #expect(sut.decks.count == 1)
    }
    
    @Test func createDeck() {
        // Given
        #expect(sut.decks.count == 0)
        // When
        sut.createDeck()
        // Then
        #expect(sut.decks.count == 1)
        
    }
    
    @Test func deleteDeck() throws {
        // Given
        try addDeck()
        // When
        sut.deleteDeck(deckMock)
        // Then
        #expect(sut.decks.count == 0)
    }
    
    @Test func errorAlertText() {
        #expect(sut.errorTitle == "Error")
        #expect(sut.errorMessage == "Ooops... an error has occured.")
    }
}

private extension HomeViewModelTests {
    func addDeck() throws {
        contextMock.insert(deckMock)
        try contextMock.save()
    }
}
