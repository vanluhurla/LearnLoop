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
    
//    var onAddCard: (() -> Void)?
    
    var body: some View {
        ZStack {
            if cards.isEmpty {
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
            } else if cards.count == 1 {
                SingleCardView(
                    card: cards.first,
                    currentIndex: currentIndex,
                    isFlipped: $isFlipped
                )
            } else {
                // Safely iterate over the cards with valid indices
                ForEach(cards, id: \.id) { card in
                    if card.id != cards[currentIndex].id {
                        let index = cards.firstIndex(where: { $0.id == card.id })!
                        let offset = CGFloat(index - currentIndex)
                        CardViewCell(
                            tapText: "",
                            color: .gray,
                            contentCardText: card.front
                        )
                        .offset(y: offset)
//                        .scaleEffect(1 - (CGFloat(index - currentIndex) * 0.05))
//                        .zIndex(Double(index))
                    }
                }
                
                // Safeguard: Ensure currentIndex is within bounds
                if currentIndex >= 0 && currentIndex < cards.count {
                    // Show the current card if the index is valid
                    CurrentCardView(
                        deck: deck,
                        card: cards[currentIndex],
                        currentIndex: currentIndex,
                        isFlipped: $isFlipped,
                        cardOffset: $cardOffset
                    )
                } else {
                    // Fallback: Show a message if the currentIndex is invalid
                    Text("Invalid current card index.")
                        .font(.headline)
                        .foregroundStyle(.red)
                        .padding()
                }
            }
        }
    }
}
