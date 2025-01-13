//
//  ModelContainerMock.swift
//  LearnLoopTests
//
//  Created by Vanessa Lucena on 12/01/2025.
//

@testable import LearnLoop
import SwiftData

struct ModelContainerMock {
    static func createModelContainer() -> ModelContainer {
        let schema = Schema([Deck.self, Card.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Could not generate a mock Model Container")
        }
    }
}
