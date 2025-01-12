//
//  HomeViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 12/01/2025.
//

import Foundation
import SwiftData

class HomeViewModel: ObservableObject {
    
    let context: ModelContext
    
    @Published var decks: [Deck] = []
    @Published var didReceiveError: Bool = false
    @Published var errorTitle = "Error"
    @Published var errorMessage = "Ooops...an error has occured."
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func createDeck() {
        context.insert(Deck())
        saveChanges()
    }
    
    func deleteDeck(_ deck: Deck) {
        context.delete(deck)
        saveChanges()
    }
    
    func fetchDecks() {
        do {
            decks = try context.fetch(FetchDescriptor<Deck>())
        } catch {
            didReceiveError = true
        }
    }
}

private extension HomeViewModel {
    func saveChanges() {
        do {
            try context.save()
            fetchDecks()
        } catch {
            didReceiveError = true
        }
    }
}
