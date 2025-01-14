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
    @Published var errorMessage = "Ooops... an error has occured."
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchDecks() {
        do {
            decks = try context.fetch(FetchDescriptor<Deck>())
        } catch {
            didReceiveError = true
        }
    }
    
    func createDeck() {
        context.insert(Deck())
        saveChanges()
    }
    
    func deleteDeck(_ deck: Deck) {
        context.delete(deck)
        saveChanges() 
    }
}

private extension HomeViewModel {
    func saveChanges() {
        saveContext()
        fetchDecks()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            didReceiveError = true
        }
    }
}
