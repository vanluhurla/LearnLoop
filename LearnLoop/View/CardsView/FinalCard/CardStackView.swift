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
                ForEach(cards, id: \.id) { card in
                    if card.id != cards[currentIndex].id {
                        let index = cards.firstIndex(where: { $0.id == card.id })!
                        let offset = CGFloat(index - currentIndex)
                        CardViewCell(
                            tapText: "",
                            color: .flashcardColor,
                            contentCardText: card.front
                        )
                        .offset(y: offset)
                    }
                }
                
                if currentIndex >= 0 && currentIndex < cards.count {
                    CurrentCardView(
                        deck: deck,
                        card: cards[currentIndex],
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
