//
//  DataController.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 13/11/2024.
//
import SwiftUI
import SwiftData

class DataController: ObservableObject {
    let container: ModelContainer
    
    init() {
        container = try! ModelContainer(for: Deck.self, Card.self)
    }
}
