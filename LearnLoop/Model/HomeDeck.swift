//
//  HomeDeck.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI

struct Deck: Identifiable, Equatable {
    var id = UUID()
    var image: Image?
    var emoji: String = "📚"
    var title: String
    var cards: [Card] = []
}
