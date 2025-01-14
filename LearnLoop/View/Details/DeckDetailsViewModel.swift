//
//  DeckDetailsViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 13/01/2025.
//

import Foundation
import SwiftData

class DeckDetailsViewModel: ObservableObject {
    
    let context: ModelContext
    let deck: Deck
    
    @Published var deckTitle: String = ""
    @Published var showRetrieveLearnedDialog = false
    @Published var showRetrieveReviewDialog = false
    @Published var retrieveLearnedCards = false
    @Published var retrieveReviewCards = false
    @Published var activeCards: [Card] = []
    @Published var didReceiveError: Bool = false
    @Published var errorTitle = "Error"
    @Published var errorMessage = "Ooops... an error has occured."
    
    init(context: ModelContext,
         deck: Deck) {
        self.context = context
        self.deck = deck
    }
    
    func refresh() {
        activeCards = deck.availableCards
        retrieveLearnedCards = activeCards.isEmpty && !deck.learnedCards.isEmpty
        retrieveReviewCards = activeCards.isEmpty && !deck.reviewedCards.isEmpty
    }
    
    func saveTitle() {
        deck.title = deckTitle
        saveChanges()
    }
    
    func saveCard(card: Card) {
        let sequence: Int = {
            if let latestCard = deck.currentAvailableCard {
                return latestCard.sequence + 1
            } else {
                return 0
            }
        }()
        card.sequence = sequence
        deck.cards.append(card)
        saveChanges()
    }
    
    func markCardAsLearned() {
        guard let currentCard = deck.currentAvailableCard else { return }
        currentCard.isLearned = true
        saveChanges()
    }
    
    func markCardToReview() {
        guard let currentCard = deck.currentAvailableCard else { return }
        currentCard.forReview = true
        saveChanges()
    }
    
    func retrieveLearnedCard() {
        for card in deck.learnedCards {
            card.isLearned = false
        }
        saveChanges()
    }
    
    func retrieveReviewCard() {
        for card in deck.reviewedCards {
            card.forReview = false
        }
        saveChanges()
    }
    
    func showRetrievedLearnedConfirmation() {
        showRetrieveLearnedDialog = true
    }
    
    func showRetrievedReviewConfirmation() {
        showRetrieveReviewDialog = true
    }
    
    func getCurrentCard() -> Card? {
        activeCards.last
    }
}

private extension DeckDetailsViewModel {
    func saveChanges() {
        saveContext()
        refresh()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            didReceiveError = true
        }
    }
}
