//
//  SmallCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 26/11/2024.
//

import SwiftUI

struct SmallCardView: View {
    
    @State var cardText: String = ""
    @Binding var text: String
    
    var body: some View {
        VStack {
            Text(cardText)
                .font(.headline)
            TextEditor(text: $text)
                .multilineTextAlignment(.center)
                .scrollContentBackground(.hidden)
                .font(.body)
                .padding()
                .frame(height: 210)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.orange.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.orange.opacity(0.1), lineWidth: 1)
                )
                .cornerRadius(10)
                .padding(5)
        }
    }
}

//#Preview {
//    SmallCardView(, text: <#Binding<String>#>)
//}
