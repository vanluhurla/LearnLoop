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
    
    private let modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: Deck.self, Card.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(context: modelContainer.mainContext))
        }
        .modelContainer(modelContainer)
    }
}
