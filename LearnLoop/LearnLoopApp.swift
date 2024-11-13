//
//  LearnLoopApp.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI


@main
struct MyApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            LLHomeView()
                .environment(\.modelContext, dataController.container.mainContext)
        }
    }
}
