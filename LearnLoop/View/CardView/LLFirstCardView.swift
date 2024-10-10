//
//  LLFirstCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI

struct LLFirstCardView: View {
    @Environment(\.presentationMode) var presentationMode // To handle navigation back
    @State private var frontText: String
    @State private var backText: String
    
    var onSave: (Card) -> Void
    
    // Initialize front and back text from the card
    init(card: Card, onSave: @escaping (Card) -> Void) {
        _frontText = State(initialValue: card.front)
        _backText = State(initialValue: card.back)
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            TextField("Front Side", text: $frontText)
                .font(.largeTitle)
                .padding()
            
            Divider()
            
            TextField("Back Side", text: $backText)
                .font(.title)
                .padding()
        }
        .navigationTitle("Deck Name")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let updatedCard = Card(front: frontText, back: backText)
                    onSave(updatedCard) // Trigger save action
                    presentationMode.wrappedValue.dismiss() // Navigate back to LLHomeView
                }
            }
        }
        .padding()
    }
}

#Preview {
    LLFirstCardView(card: Card(front: "Front Side", back: "Back Side")) { newCard in
        print("Card saved: \(newCard.front) / \(newCard.back)")
    }
}
    
