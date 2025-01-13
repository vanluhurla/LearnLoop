//
//  CardView.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 06/01/2025.
//

import SwiftUI

struct CardView: View {
    
    @State private var isFlipped = false
    
    var frontText: String
    var backText: String
    
    var body: some View {
        ZStack {
            front
                .opacity(isFlipped ? 0 : 1)
            back
                .opacity(isFlipped ? 1 : 0)
        }
        .font(.title)
        .frame(width: 300, height: 400)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding()
        .onTapGesture {
            flipAnimation()
        }
    }
    
    func flipAnimation() {
        withAnimation(.easeIn) {
            isFlipped.toggle()
        }
    }
    
    var front: some View {
        VStack {
            ZStack {
                ScrollView {
                    Text(frontText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .scrollIndicators(.hidden)
                .frame(width: 280, height: 350)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.flashcardFront)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .rotation3DEffect(
            .degrees(isFlipped ? 90 : 0),
            axis: (x: 0.0, y: 1.0, z: 0.0),
            perspective: 0.2
        )
        .animation(isFlipped
                   ? .linear
                   : .linear.delay(0.35),
                   value: isFlipped)
    }
    
    var back: some View {
        VStack {
            ZStack {
                ScrollView {
                    Text(backText)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .scrollIndicators(.hidden)
                .frame(width: 280, height: 350)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.flashcardBack)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .rotation3DEffect(
            .degrees(isFlipped ? 0 : -90),
            axis: (x: 0.0, y: 1.0, z: 0.0),
            perspective: 0.2
        )
        .animation(isFlipped
                   ? .linear.delay(0.35)
                   : .linear,
                   value: isFlipped)
    }
}

#Preview {
    CardView(frontText: "This is a long front text example to test scrolling functionality on the front card. Make sure it works as expected!",
             backText: "This is a long back text example to test scrolling functionality on the back card. Make sure it works as expected!")
}






