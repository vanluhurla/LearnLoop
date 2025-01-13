//
//  TestDependencies.swift
//  LearnLoopTests
//
//  Created by Vanessa Lucena on 12/01/2025.
//

@testable import LearnLoop
import SwiftData

@MainActor
class TestingDependencies {
    let container: ModelContainer
    init() {
        container = ModelContainerMock.createModelContainer()
    }
}
