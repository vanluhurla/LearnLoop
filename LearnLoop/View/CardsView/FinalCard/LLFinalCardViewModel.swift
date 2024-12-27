//
//  LLFinalCardViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 26/12/2024.
//

import SwiftUI
import SwiftData

@MainActor
class LLFinalCardViewModel: ObservableObject {
    
    @Published var currentIndex: Int = 0
    @Published var inactiveCards: [Card] = []
    @Published var learnedCount: Int = 0
    @Published var isFlipped: Bool = false
    @Published var cardOffset: CGFloat = 0
    @Published var reviewingCount: Int = 0
    @Published var isAddingCard: Bool = false
    
    let deck: Deck
    private var modelContext: ModelContext
    
    init(deck: Deck, modelContext: ModelContext) {
        self.deck = deck
        self.modelContext = modelContext
    }
    
    func markAsLearned() {
        guard !deck.cards.isEmpty else { return }
        
        let learnedCard = deck.cards.remove(at: currentIndex)
        inactiveCards.append(learnedCard)
        learnedCount += 1
        
        try? modelContext.save()
        
        if deck.cards.isEmpty {
            currentIndex = 0
        } else {
            nextCard()
        }
    }
    
    func nextCard() {
        guard !deck.cards.isEmpty else { return }
        currentIndex = (currentIndex + 1) % deck.cards.count
        isFlipped = false
    }
    
    func swipeLeftAndNextCard() {
        withAnimation(.easeIn(duration: 0.5)) {
            cardOffset = -400
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.cardOffset = 0
            self.nextCard()
        }
    }
}
