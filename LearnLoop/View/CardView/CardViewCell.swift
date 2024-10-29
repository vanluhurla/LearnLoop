//
//  CardViewCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 29/10/2024.
//

import SwiftUI

struct CardViewCell: View {
    
    var tapText: String
    @State var contentCardText: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: 300, height: 600)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            VStack {
                Text(tapText)
                    .font(.headline)
                    .padding(.bottom, 50)
                
                TextEditor(text: $contentCardText)
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .padding()
                    .frame(width: 300, height: 400)
                    .background(Color.clear)
            }
        }
    }
}

#Preview {
    CardViewCell(tapText: "Tap to flip!", contentCardText: "Front Text")
}
