//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI


struct Deck: Identifiable, Hashable {
    var id = UUID()
    var title: String
}

struct LLHomeView: View {
    @State private var decks: [Deck] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach($decks, id: \.self) { deck in
                    LLHomeDeckCell(deck: deck)
                }
                .onDelete(perform: deleteDeck)
            }
            .navigationTitle("My Decks")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addNewDeck) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onTapGesture {
                dismissKeyboard()
            }
        }
    }
    
    private func addNewDeck() {
        let newDeck = Deck(title: "New Deck")
        decks.append(newDeck)
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LLHomeView()
}

