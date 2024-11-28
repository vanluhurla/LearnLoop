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
    var counterCard: String?
    var isEditable: Bool = false
    
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
                        RoundedRectangle(cornerRadius: 20)
                            .fill(color)
                    )
                    .multilineTextAlignment(.center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(color, lineWidth: 1)
                    )
                    .disabled(!isEditable)
                    .foregroundStyle(isEditable ? .primary : .secondary)
            }
            .background(color.secondary)
            
            if let counterCard = counterCard {
                //MARK: Small counter
                VStack {
                    HStack {
                        Spacer()
                        Text(counterCard)
                            .font(.caption)
                            .padding(5)
                            .cornerRadius(5)
                    }
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    CardViewCell(
        tapText: "Tap to flip!",
        color: .orange,
        isEditable: true,
        contentCardText: "Front Text"
        
    )
}
