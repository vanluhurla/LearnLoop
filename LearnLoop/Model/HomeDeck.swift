//
//  HomeDeck.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI
import SwiftData

@Model
final class Deck: Identifiable, Equatable {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var cards: [Card]
    var date: Date
    
    init(id: UUID = UUID(),
         title: String = "New Deck",
         cards: [Card] = [],
         date: Date = Date.now) {
        self.id = id
        self.title = title
        self.cards = cards
        self.date = date
    }
}

extension Deck {
    var sortedCards: [Card] {
        cards.sorted(by: { $0.sequence < $1.sequence })
    }
    var learnedCards: [Card] {
        sortedCards.filter({ $0.isLearned })
    }
    var reviewedCards: [Card] {
        sortedCards.filter({ $0.forReview })
    }
    var availableCards: [Card] {
        sortedCards.filter({ !$0.isLearned && !$0.forReview })
    }
    var currentAvailableCard: Card? {
        availableCards.last
    }
}
