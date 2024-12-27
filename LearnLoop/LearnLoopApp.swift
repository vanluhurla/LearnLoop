//
//  LearnLoopApp.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI


@main
struct LearnLoopApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            LLHomeView(
                viewModel: LLHomeViewModel(
                    modelContext: dataController.container.mainContext, decks: []))
            .environment(\.modelContext, dataController.container.mainContext)

        }
    }
}
