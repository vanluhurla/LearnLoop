//
//  EditableCardViewModelTests.swift
//  LearnLoopTests
//
//  Created by Vanessa Lucena on 13/01/2025.
//

import Testing
@testable import LearnLoop

struct EditableCardViewModelTests {
    
    private var cardMock: Card!
    
    var sut: EditableCardViewModel!
    
    init() {
        sut = EditableCardViewModel()
    }
    
    @Test func createCard() {
        // Given
        sut.frontText = "Front"
        sut.backText = "Back"
        // When
        let createdCard = sut.createCard()
        // Then
        #expect(createdCard.front == "Front")
        #expect(createdCard.back == "Back")
    }
}
