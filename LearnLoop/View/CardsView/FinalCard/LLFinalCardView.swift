//
//  LLFinalCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 10/10/2024.
//

import SwiftUI
import SwiftData

struct LLFinalCardView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
        
    @StateObject private var viewModel: LLFinalCardViewModel
    
    init(deck: Deck, modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: LLFinalCardViewModel(
            deck: deck,
            modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(viewModel.deck.title)
                        .font(.title)
                }
                .padding()
                
                // MARK: Counters
                HStack(spacing: 30) {
                    CounterViewCell(label: "Learned", color: .green.opacity(0.1), count: $viewModel.learnedCount)
                    CounterViewCell(label: "Review", color: .blue.opacity(0.1), count: $viewModel.reviewingCount)
                }
                .padding(.top)
                
                // MARK: Card animation
                CardStackView(
                    cards: viewModel.deck.cards,
                    deck: viewModel.deck,
                    currentIndex: $viewModel.currentIndex,
                    isFlipped: $viewModel.isFlipped,
                    cardOffset: $viewModel.cardOffset
                    
                )
                .frame(width: 300, height: 400)
                .padding(30)
                
                // MARK: Action buttons
                HStack(spacing: 20) {
                    Button(action: {
                        viewModel.markAsLearned()
                        viewModel.swipeLeftAndNextCard()
                    }) {
                        StatusButton(color: .green, iconName: "hand.thumbsup.fill")
                    }
                    
                    Button(action: {
                        viewModel.isAddingCard = true
                    }) {
                        StatusButton(color: .blue, iconName: "plus")
                    }
                    .sheet(isPresented: $viewModel.isAddingCard) {
                        LLFirstCardView(deck: viewModel.deck,
                                        modelContext: modelContext,
                                        onAddCard: { newCard in
                            viewModel.deck.cards.append(newCard)
                            viewModel.currentIndex = viewModel.deck.cards.count - 1
                            try? modelContext.save()
                        },
                        onSave: nil
                        )
                    }
                }
                .padding(.bottom)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            viewModel.currentIndex = min(viewModel.currentIndex, viewModel.deck.cards.count - 1)
        }
    }
}

//#Preview {
//    LLFinalCardView(deck: Deck(title: "Simple Deck"))
//}
