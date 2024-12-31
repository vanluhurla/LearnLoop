//
//  CardStackView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 22/11/2024.
//

import SwiftUI

struct CardStackView: View {
    
    let cards: [Card]
    let deck: Deck
    
    @Binding var currentIndex: Int
    @Binding var isFlipped: Bool
    @Binding var cardOffset: CGFloat
    
    var body: some View {
        
        ZStack {
            if deck.sortedCards.isEmpty {
                VStack {
                    Text(
                    """
                          No card available.
                    Press + to add new card.
                    """
                    )
                    .frame(alignment: .center)
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding()
                }
            } else if deck.sortedCards.count == 1 {
                SingleCardView(
                    card: deck.sortedCards.first,
                    currentIndex: currentIndex,
                    isFlipped: $isFlipped
                )
            } else {
                ForEach(deck.sortedCards, id: \.id) { card in
                    if currentIndex >= 0 && currentIndex < deck.sortedCards.count {
                        if card.id != deck.sortedCards[currentIndex].id {
                            let index = deck.sortedCards.firstIndex(where: { $0.id == card.id }) ?? 0
                            let offset = CGFloat(index - currentIndex)
                            CardViewCell(
                                tapText: "",
                                color: .flashcardColor,
                                counterCard: "\(currentIndex + 1)/\(deck.sortedCards.count)",
                                contentCardText: card.front
                            )
                            .offset(y: offset)
                        }
                    }
                }
                
                if currentIndex >= 0 && currentIndex < deck.sortedCards.count {
                    CurrentCardView(
                        deck: deck,
                        card: deck.sortedCards[currentIndex],
                        currentIndex: currentIndex,
                        isFlipped: $isFlipped,
                        cardOffset: $cardOffset
                    )
                } else {
                    Text("Invalid current card index.")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .padding()
                }
            }
        }
    }
}
