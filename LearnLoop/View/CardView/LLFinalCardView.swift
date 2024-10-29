//
//  LLFinalCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 10/10/2024.
//

import SwiftUI

struct LLFinalCardView: View {
    
    var deck: Deck
    @State private var isFlipped: Bool = false
    @State private var frontText: String
    @State private var backText: String
    
    init(deck: Deck) {
        self.deck = deck
        
        _frontText = State(initialValue: deck.cards.first?.front ?? "No card available")
        _backText = State(initialValue: deck.cards.first?.back ?? "No card available")
    }

    var body: some View {
        ZStack {
            CardViewCell(tapText: "Back - Tap to flip!", contentCardText: backText)
                .rotation3DEffect(
                    .degrees(isFlipped ? 0 : -90),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            
            CardViewCell(tapText: "Front - Tap to flip!", contentCardText: frontText)
                .rotation3DEffect(
                    .degrees(isFlipped ? 90 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
        }
        .onTapGesture {
            withAnimation(.easeInOut) {
                isFlipped.toggle()
            }
        }
        .navigationTitle(deck.title)
    }
}

#Preview {
    LLFinalCardView(deck: Deck(image: Image("lamp"), title: "Simple Deck", cards: [Card(front: "Front", back: "Back")]))
}





