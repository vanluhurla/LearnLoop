//
//  DeckDetailsViewModelTests.swift
//  LearnLoopTests
//
//  Created by Vanessa Lucena on 13/01/2025.
//

import Testing
import SwiftData
@testable import LearnLoop

@MainActor
struct DeckDetailsViewModelTests {
    private let testDependencies = TestingDependencies()
    private var contextMock: ModelContext {
        testDependencies.container.mainContext
    }
    
    private let deckMock: Deck
    
    var sut: DeckDetailsViewModel!
    
    init() {
        deckMock = Deck()
        sut = DeckDetailsViewModel(context: contextMock, deck: deckMock)
    }
    
    @Test func refreshActiveCards() {
        // Given
        let card1 = Card()
        deckMock.cards.append(card1)
        // When
        sut.refresh()
        // Then
        #expect(sut.activeCards.isEmpty == false)
    }
    
    @Test func refreshRetrieveLearnedCards() {
        // Given
        let card1 = Card(isLearned: true)
        sut.saveCard(card: card1)
        // When
        sut.refresh()
        // Then
        #expect(sut.retrieveLearnedCards == true)
    }
    
    @Test func refreshRetrieveLearnedCardsWithActive() {
        // Given
        let card1 = Card(isLearned: false)
        let card2 = Card(isLearned: true)
        sut.saveCard(card: card1)
        sut.saveCard(card: card2)
        // When
        sut.refresh()
        // Then
        #expect(sut.retrieveLearnedCards == false)
    }
    
    @Test func refreshRetrieveReviewCards() {
        // Given
        let card1 = Card(forReview: true)
        sut.saveCard(card: card1)
        // When
        sut.refresh()
        // Then
        #expect(sut.retrieveReviewCards == true)
    }
    
    @Test func refreshRetrieveReviewCardsWithActive() {
        // Given
        _ = Card(forReview: false)
        _ = Card(forReview: true)
        // When
        sut.refresh()
        // Then
        #expect(sut.retrieveReviewCards == false)
    }
    
    
    @Test func getCurrentCard() {
        // Given
        let card1 = Card()
        sut.saveCard(card: card1)
        // When
        let currentCard = sut.getCurrentCard()
        // Then
        #expect(currentCard != nil)
    }
    
    
    @Test func saveWhenExistedTitle() {
        // Given
        #expect(sut.deck.title == "New Deck")
        // When
        sut.deckTitle = "My expected title"
        sut.saveTitle()
        // Then
        #expect(sut.deck.title == "My expected title")
    }
    
    @Test func saveWhenEmptyTitle() {
        // Given
        #expect(sut.deck.title == "New Deck")
        // When
        sut.saveTitle()
        // Then
        #expect(sut.deck.title == "")
    }
    
    @Test func saveFirstCard() {
        // Given
        let card1 = Card()
        // When
        sut.saveCard(card: card1)
        // Then
        #expect(sut.deck.cards.first!.sequence == 0)
    }
    
    @Test func saveNextCard() {
        // Given
        let card1 = Card()
        let card2 = Card()
        // When
        sut.saveCard(card: card1)
        sut.saveCard(card: card2)
        #expect(sut.deck.cards.last!.sequence == 1)
    }
    
    @Test func markCardAsLearned() {
        // Given
        let card1 = Card(isLearned: false)
        sut.saveCard(card: card1)
        // When
        sut.markCardAsLearned()
        // Then
        #expect(sut.deck.learnedCards.count == 1)
        #expect(sut.deck.learnedCards.first!.isLearned == true)
    }
    
    @Test func markCardToReview() {
        // Given
        let card1 = Card(forReview: false)
        sut.saveCard(card: card1)
        // When
        sut.markCardToReview()
        // Then
        #expect(sut.deck.reviewedCards.count == 1)
        #expect(sut.deck.reviewedCards.first!.forReview == true)
    }
    
    @Test func retrieveLearnedCard() {
        // Given
        let card1 = Card(isLearned: true)
        sut.saveCard(card: card1)
        // When
        sut.retrieveLearnedCard()
        // Then
        #expect(sut.deck.learnedCards.count == 0)
        #expect(sut.deck.availableCards.count == 1)
    }
    
    @Test func retrieveReviewCard() {
        // Given
        let card1 = Card(forReview: true)
        sut.saveCard(card: card1)
        // When
        sut.retrieveReviewCard()
        // Then
        #expect(sut.deck.reviewedCards.count == 0)
    }
    
    @Test func showRetrievedLeanedConfirmation() {
        // When
        sut.showRetrievedLearnedConfirmation()
        // Then
        #expect(sut.showRetrieveLearnedDialog == true)
    }
    
    @Test func showRetrievedReviewConfirmation() {
        // When
        sut.showRetrievedReviewConfirmation()
        // Then
        #expect(sut.showRetrieveReviewDialog == true)
    }
    
    @Test func errorAlertText() {
        #expect(sut.errorTitle ==  "Error")
        #expect(sut.errorMessage == "Ooops... an error has occured.")
    }
}
