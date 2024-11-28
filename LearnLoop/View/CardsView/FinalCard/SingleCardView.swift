//
//  SingleCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 22/11/2024.
//

import SwiftUI

struct SingleCardView: View {
    
    let card: Card?
    let currentIndex: Int
    @Binding var isFlipped: Bool
    
    var body: some View {
        ZStack {
            //MARK: Back Card
            CardViewCell(
                tapText: "Back: Tap here!",
                color: .flashcardColor,
                counterCard: "\(currentIndex + 1)/1",
                
                contentCardText: card?.back ?? "No card available."
            )
            .rotation3DEffect(
                .degrees(isFlipped ? 0 : -90),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                perspective: 0.2
            )
            .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
            
            //MARK: Front Card
            CardViewCell(
                tapText: "Front: Tap here!",
                color: .flashcardColor,
                counterCard: "\(currentIndex + 1)/1",
                contentCardText: card?.front ?? "No card available."
            )
            .rotation3DEffect(
                .degrees(isFlipped ? 90 : 0),
                axis: (x: 0.0, y: 1.0, z: 0.0),
                perspective: 0.2
            )
            .animation(isFlipped ? .linear : .linear.delay(0.35), value: isFlipped)
        }
        .onTapGesture {
            withAnimation(.easeIn) {
                isFlipped.toggle()
            }
        }
    }
}


