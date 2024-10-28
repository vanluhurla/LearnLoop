//
//  LLFinalCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 10/10/2024.
//

import SwiftUI

struct LLFinalCardView: View {
    
    var deck: Deck

    
    var body: some View {
        VStack {
            Text("Front: \(deck.cards.first?.front ?? "No card available")")
                .font(.title)
                .padding()
            
            Text("Back: \(deck.cards.first?.back ?? "No card available")")
                .font(.title)
                .padding()
        }
        .navigationTitle(deck.title)
    }
}

#Preview {
    LLFinalCardView(deck: Deck(image: Image("lamp"), title: "Simple Deck", cards: [Card(front: "Front", back: "Back")]))
}
