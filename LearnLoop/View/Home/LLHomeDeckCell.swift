//
//  LLHomeDeckCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 31/07/2024.
//

import SwiftUI

//struct LLHomeDeckCell: View {
//    
//    @Binding var deck: Deck
//    var isEditing: Bool
//    
//    var body: some View {
//        HStack {
//            deck.image?
//                .resizable()
//                .scaledToFit()
//                .frame(width: 60, height: 60)
//                .padding()
//            
//            if isEditing {
//                TextField("Deck Title", text: $deck.title)
//                    .fontWeight(.semibold)
//                    .lineLimit(2)
//                    .minimumScaleFactor(0.5)
//            } else {
//                Text(deck.title)
//                    .fontWeight(.semibold)
//                    .lineLimit(2)
//                    .minimumScaleFactor(0.5)
//            }
//        }
//        .padding(.vertical, isEditing ? 10 : 0)
//        .background(Color.clear)
//        .contentShape(Rectangle())
//        .padding()
//    }
//}
//struct LLHomeDeckCell_Previews: PreviewProvider { 
//    static var previews: some View {
//        let sampleImage = Image("lamp")
//        let sampleDeck = Deck(image: sampleImage, title: "Sample Deck", cards: [Card(front: "Front", back: "Back")])
//        LLHomeDeckCell(deck: .constant(sampleDeck), isEditing: false)
//            .previewLayout(.sizeThatFits)
//    }
//}
