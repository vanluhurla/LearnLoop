//
//  EditableCardViewModel.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 13/01/2025.
//

import Foundation

class EditableCardViewModel: ObservableObject {
    
    @Published var frontText: String = ""
    @Published var backText: String = ""
    
    func createCard() -> Card {
        Card(front: frontText, back: backText)
    }
}
