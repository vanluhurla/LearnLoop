//
//  Card.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import Foundation
import SwiftData

@Model
class Card: Identifiable {
   
    var id = UUID()
    var front: String
    var back: String
    var sequence: Int = 0
    
    init(front: String, back: String, sequence: Int) {
        self.front = front
        self.back = back
        self.sequence = sequence
    }
}
