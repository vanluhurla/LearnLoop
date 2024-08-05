//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI

struct Deck: Identifiable {
    var id = UUID()
    var title: String
}

struct LLHomeView: View {
    @State private var decks: [Deck] = [] // Mutable array to hold decks
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($decks) { $deck in
                        LLHomeDeckCell(deck: $deck)
                    }
                    .onDelete(perform: deleteDeck) // Ensure `onDelete` is applied here
                }
                .navigationTitle("My Decks")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: addNewDeck) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .onTapGesture {
                dismissKeyboard() // Dismiss keyboard on tap outside
            }
        }
    }
    
    private func addNewDeck() {
        let newDeck = Deck(title: "New Deck")
        decks.append(newDeck)
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets) // Correctly handles deletion
    }
    
    private func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    LLHomeView()
}

