//
//  ActionButton.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 05/11/2024.
//

import SwiftUI

enum ActionButtonType {
    case learn, create, review, retrieveLearned, retrieveReview
    
    var colour: Color {
        switch self {
        case .learn, .retrieveLearned: Color.theme.learnedAction
        case .create: Color.theme.accent
        case .review, .retrieveReview: Color.theme.reviewAction
        }
    }
    
    var iconName: String {
        switch self {
        case .learn: "hand.thumbsup.fill"
        case .create: "plus"
        case .review: "repeat"
        case .retrieveLearned, .retrieveReview: "arrow.clockwise"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .learn, .retrieveLearned: 65
        case .create: 80
        case .review, .retrieveReview: 65
        }
    }
}

struct ActionButton: View {
    var type: ActionButtonType
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Circle()
                    .fill(type.colour)
                    .frame(width: type.size, height: type.size)
                Image(systemName: type.iconName)
                    .font(.system(size: 30))
                    .foregroundColor(Color.white)
            }
        }
    }
}


