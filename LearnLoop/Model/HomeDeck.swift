//
//  HomeDeck.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import Foundation

struct Deck: Identifiable, Equatable {
    var id = UUID()
    var title: String
    var cards: [Card] = []
}
