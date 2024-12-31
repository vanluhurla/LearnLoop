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
            if isEditing {
                TextField("Deck Title", text: $deck.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.mainFontColour)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            } else {
                Text(deck.title)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.mainFontColour)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
            }
        }
        .padding(.vertical, isEditing ? 10 : 0)
        .background(Color.backgroundCellColor)
        .contentShape(Rectangle())
        .padding()
    }
}

//struct LLHomeDeckCell_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleDeck = Deck(title: "Sample Deck")
//        sampleDeck.cards = [Card(front: "Front", back: "Back")]
//        
//        return LLHomeDeckCell(deck: .constant(sampleDeck), isEditing: false)
//            .previewLayout(.sizeThatFits)
//    }
//}
