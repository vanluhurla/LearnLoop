//
//  LLFinalCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 10/10/2024.
//

import SwiftUI

struct LLFinalCardView: View {
    var deck: Deck
    
    // MARK: Card Data
    @State private var isFlipped: Bool = false
    @State private var angle: Double = 0
    @State private var showBackText: Bool = false // Flag para controlar a exibição do texto do verso
    
    @State private var frontText: String
    @State private var backText: String
    @State private var currentIndex: Int = 0
    
    // MARK: Counters
    @State private var learnedCount: Int = 0
    @State private var reviewingCount: Int = 0
    
    init(deck: Deck) {
        self.deck = deck
        _frontText = State(initialValue: deck.cards.first?.front ?? "No card available")
        _backText = State(initialValue: deck.cards.first?.back ?? "No card available")
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(deck.title)
                    .font(.title)
                
                Spacer()
                
                Button(action: {
                    // Ação para adicionar um novo card ou outra funcionalidade
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 30, height: 30)
                        
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                            .foregroundColor(Color.white)
                    }
                }
            }
            .padding(.horizontal)
            
            ZStack {
                CardViewCell(tapText: "Back: Tap here!", color: .purple, contentCardText: backText)
                    .rotation3DEffect(.degrees(isFlipped ? 0 : -90),
                                      axis: (x: 0.0, y: 1.0, z: 0.0),
                                      perspective: 0.2
                    )
                    .animation(isFlipped ? .linear.delay(0.35) : .linear, value: isFlipped)
                
                CardViewCell(tapText: "Front: Tap here!", color: .pink, contentCardText: frontText)
                    .rotation3DEffect(.degrees(isFlipped ? 90 : 0),
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
            .frame(width: 300, height: 400)
            .padding(20)
            
            // MARK: Botões
            HStack(spacing: 40) {
                Button(action: {
                    learnedCount += 1
                    nextCard()
                }) {
                    StatusButton(color: .green, iconName: "hand.thumbsup.fill")
                }
                
                Button(action: {
                    reviewingCount += 1
                    nextCard()
                }) {
                    StatusButton(color: .orange, iconName: "repeat")
                }
            }
            .padding(.bottom)
        }
    }

    private func updateCardContent() {
        frontText = deck.cards[currentIndex].front
        backText = deck.cards[currentIndex].back
    }
    
    private func nextCard() {
        currentIndex = (currentIndex + 1) % deck.cards.count
        isFlipped = false
        showBackText = false // Esconde o texto antes de mostrar o novo card
        frontText = deck.cards[currentIndex].front
        backText = deck.cards[currentIndex].back
    }
}

#Preview {
    LLFinalCardView(deck: Deck(image: Image("lamp"), title: "Simple Deck", cards: [Card(front: "Front", back: "Back")]))
}




