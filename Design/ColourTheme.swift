//
//  ColourTheme.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 15/08/2024.
//

import SwiftUI

struct ColourTheme {
    let accent = Color.accentColor
    
    let backgroundPrimary = Color.backgroundPrimary
    let backgroundCell = Color.backgroundCell
    let flashcardFront = Color.flashcardFront
    let flashcardBack = Color.flashcardBack
    let learnedAction = Color.learnedAction
    let reviewAction = Color.reviewAction
    let text = Color.text
}

extension Color {
    static let theme = ColourTheme()
}
