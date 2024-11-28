//
//  LLFinalCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 10/10/2024.
//

import SwiftUI

struct LLFinalCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var deck: Deck
    
    // MARK: Card Data
    @State private var isFlipped: Bool = false
    @State private var currentIndex: Int = 0
    @State private var isAddingCard: Bool = false
    @State private var inactiveCards: [Card] = []
    
    // MARK: Counters
    @State private var learnedCount: Int = 0
    @State private var reviewingCount: Int = 0
    
    // MARK: Animation Offset
    @State private var cardOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(deck.title)
                        .font(.title)
                }
                .padding()
                
                // MARK: Counters
                HStack(spacing: 30) {
                    CounterViewCell(label: "Learned", color: .green.opacity(0.1), count: $learnedCount)
                    CounterViewCell(label: "Review", color: .blue.opacity(0.1), count: $reviewingCount)
                }
                .padding(.top)
                
                // MARK: Card animation
                CardStackView(
                    cards: deck.cards,
                    deck: deck,
                    currentIndex: $currentIndex,
                    isFlipped: $isFlipped,
                    cardOffset: $cardOffset
                    
                )
                .frame(width: 300, height: 400)
                .padding(30)
                
                // MARK: Action buttons
                HStack(spacing: 20) {
                    Button(action: {
                        markAsLearned()
                        swipeLeftAndNextCard()
                    }) {
                        StatusButton(color: .green, iconName: "hand.thumbsup.fill")
                    }
                    
                    Button(action: {
                        isAddingCard = true
                    }) {
                        StatusButton(color: .blue, iconName: "plus")
                    }
                    .sheet(isPresented: $isAddingCard) {
                        LLFirstCardView(deck: deck) { newCard in
                            deck.cards.append(newCard)
                            currentIndex = deck.cards.count - 1
                            try? modelContext.save()
                        }
                    }
                }
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            currentIndex = min(currentIndex, deck.cards.count - 1)
        }
    }
    
    // MARK: Private Methods
    
    private func markAsLearned() {
        guard !deck.cards.isEmpty else {
            return
        }
        
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
    
    private func nextCard() {
        guard !deck.cards.isEmpty else { return }
        currentIndex = (currentIndex + 1) % deck.cards.count
        isFlipped = false
    }
    
    private func swipeLeftAndNextCard() {
        withAnimation(.easeIn(duration: 0.5)) {
            cardOffset = -400
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cardOffset = 0
            nextCard()
        }
    }
}

#Preview {
    LLFinalCardView(deck: Deck(title: "Simple Deck"))
}
