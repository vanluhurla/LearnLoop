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
        do {
            container = try ModelContainer(for: Deck.self, Card.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
