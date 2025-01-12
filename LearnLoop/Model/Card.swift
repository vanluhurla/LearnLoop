//
//  Card.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import Foundation // Should I keep Foundation or change to SwiftUI?
import SwiftData

@Model
final class Card: Identifiable {
   
    @Attribute(.unique) var id: UUID
    var front: String
    var back: String
    var sequence: Int
    var isLearned: Bool // Should I do the same as we did on the Deck?
    var forReview: Bool
    
    init(id: UUID = UUID(),
         front: String,
         back: String,
         sequence: Int = 0,
         isLearned: Bool = false,
         forReview: Bool = false) {
        self.id = id
        self.front = front
        self.back = back
        self.sequence = sequence
        self.isLearned = isLearned
        self.forReview = forReview
    }
}
