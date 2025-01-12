//
//  LearnLoopApp.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI
import SwiftData

@main
struct LearnLoopApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: [Deck.self, Card.self], isAutosaveEnabled: true)
    }
}
