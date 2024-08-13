//
//  LLCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI

struct LLCardView: View {
    var card: Card
    
    var body: some View {
        VStack {
            Text(card.front)
                .font(.largeTitle)
                .padding()
            
            Divider()
            
            Text(card.back)
                .font(.title)
                .padding()
        }
        .navigationTitle("Card Detail")
    }
}

#Preview {
    LLCardView(card: Card(front: "Front Side", back: "Back Side"))
}
