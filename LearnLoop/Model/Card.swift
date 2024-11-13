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
    
    init(front: String, back: String) {
        self.front = front
        self.back = back
    }
}
