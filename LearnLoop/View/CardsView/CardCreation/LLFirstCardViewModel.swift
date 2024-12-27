//
//  LLFirstCardViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 18/12/2024.
//

import SwiftUI
import SwiftData

@MainActor
class LLFirstCardViewModel: ObservableObject {
    
    @Published var frontText: String = ""
    @Published var backText: String = ""
    @Published var deckTitle: String = ""
    
    private var modelContext: ModelContext
    var onAddCard: ((Card) -> Void)?
    var onSave: ((Deck) -> Void)?
    
    init(modelContext: ModelContext, onAddCard: ((Card) -> Void)? = nil, onSave: ((Deck) -> Void)?) {
        self.modelContext = modelContext
        self.onAddCard = onAddCard
        self.onSave = onSave
    }
    
    func saveOrAddCard(deck: Deck?) {
        if deck != nil {
            let newCard = Card(front: frontText, back: backText)
            onAddCard?(newCard)
        } else {
            let newCard = Card(front: frontText, back: backText)
            let newDeck = Deck(title: deckTitle)
            newDeck.cards.append(newCard)
            
            modelContext.insert(newDeck)
            
            do {
                try modelContext.save()
                print("Deck presented!")
            } catch {
                print(error.localizedDescription)
            }
            onSave?(newDeck)
        }
    }
    
    func isButtonDisabled(deck: Deck?) -> Bool {
        return !deckTitle.isEmpty && deckTitle.isEmpty || frontText.isEmpty || backText.isEmpty
    }
}



