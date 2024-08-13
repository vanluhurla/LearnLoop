//
//  LLHomeDeckCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 31/07/2024.
//

import SwiftUI

struct LLHomeDeckCell: View {
    
    @Binding var deck: Deck
    var isEditing: Bool
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .padding()
            
            if isEditing {
                TextField("Deck Title", text: $deck.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
            } else {
                Text(deck.title)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
        }
        .background(Color.clear)
        .contentShape(Rectangle())
        .padding()
    }
}

#Preview {
    LLHomeDeckCell(deck: .constant(Deck(title: "Sample Deck", cards: [Card(front: "Front", back: "Back")])), isEditing: false)
}
