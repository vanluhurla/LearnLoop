//
//  HomeDeck.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI
import SwiftData

@Model
class Deck: Identifiable, Equatable {
    
    var id = UUID()
    var title: String
    @Relationship(deleteRule: .cascade) var cards: [Card] = []
    
    init(title: String) {
        self.title = title
    }
    
    static func ==(lhs: Deck, rhs: Deck) -> Bool {
        lhs.id == rhs.id
    }
}
