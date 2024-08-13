//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI

struct LLHomeView: View {
    
    @State private var decks: [Deck] = []
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($decks) { $deck in
                        if isEditing {
                            LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                        } else {
                            NavigationLink(destination: LLCardView(card: deck.cards.first ?? Card(front: "Front", back: "Back"))) {
                                LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onDelete(perform: deleteDeck)
                }
                .navigationTitle("My Decks")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: toggleEditing) {
                            Image(systemName: isEditing ? "checkmark.circle" : "square.and.pencil")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addNewDeck) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    private func toggleEditing() {
        isEditing.toggle()
    }
    
    private func addNewDeck() {
        let newDeck = Deck(title: "New Deck", cards: [Card(front: "Example Front", back: "Example Back")])
        decks.append(newDeck)
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }
    
}
    
#Preview {
    LLHomeView()
}
