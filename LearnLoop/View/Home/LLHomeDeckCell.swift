//
//  LLHomeDeckCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 31/07/2024.
//

import SwiftUI

struct LLHomeDeckCell: View {
    @Binding var deck: Deck
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
                .padding()
            
            TextField("Deck Title", text: $deck.title)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .keyboardType(/*@START_MENU_TOKEN@*/.default/*@END_MENU_TOKEN@*/)
                .textInputAutocapitalization(.sentences)
        }
    }
}

#Preview {
    // Create a constant Deck to use in the preview
    LLHomeDeckCell(deck: .constant(Deck(title: "Sample Deck")))
}
