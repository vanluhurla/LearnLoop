//
//  LLHomeViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 17/12/2024.
//

import SwiftUI
import SwiftData

@MainActor
class LLHomeViewModel: ObservableObject {
    
    @Published var decks: [Deck] = []
    @Published var isEditing: Bool = false
    @Published var showButtons: Bool = false
    @Published var isTitleEditing: Bool = false
    
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext, decks: [Deck]) {
        self.modelContext = modelContext
        self.decks = decks
    }
    
    func addNewDeck(_ newDeck: Deck) {
        modelContext.insert(newDeck)
        
        do {
            try modelContext.save()
            print("Deck saved!")
        } catch {
            print(error.localizedDescription)
        }
        decks.append(newDeck)
    }
    
    func toggleEditing() {
        withAnimation {
            isEditing.toggle()
            showButtons = false
        }
    }

    func deleteDeck(at offSet: IndexSet) {
        for index in offSet {
            let deletedDeck = decks[index]
            modelContext.delete(deletedDeck)
        }
        decks.remove(atOffsets: offSet )
    }
}
