//
//  CardViewCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 29/10/2024.
//

import SwiftUI

struct CardViewCell: View {
    
    var tapText: String
    var color: Color
    
    @State var contentCardText: String
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
                .frame(width: 300, height: 400)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            VStack {
                Text(tapText)
                    .font(.headline)
                    .padding(.bottom, 50)
                
                TextEditor(text: $contentCardText)
                    .font(.largeTitle)
                    .padding()
                    .frame(width: 260, height: 200)
                    .scrollContentBackground(.hidden)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color.opacity(0.1))
                    )
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                        .stroke(color.opacity(0.1), lineWidth: 1)
                    )
            }
            .background(color.opacity(0.1))
        }
    }
}

#Preview {
    CardViewCell(tapText: "Tap to flip!", color: .yellow.opacity(0.1), contentCardText: "Front Text")
}
