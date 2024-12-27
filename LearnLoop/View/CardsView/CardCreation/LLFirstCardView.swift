//
//  LLFirstCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI
import SwiftData

struct LLFirstCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel: LLFirstCardViewModel
    
    var deck: Deck?
    
    init(deck: Deck? = nil, modelContext: ModelContext, onAddCard: ((Card) -> Void)? = nil, onSave: ((Deck) -> Void)?) {
        self.deck = deck
        _viewModel = StateObject(wrappedValue: LLFirstCardViewModel(
            modelContext: modelContext,
            onAddCard: onAddCard,
            onSave: onSave
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                // MARK: Deck Name
                if let deck = deck {
                    Text(deck.title)
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                } else {
                    TextField("Deck Name", text: $viewModel.deckTitle)
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                }

                SmallCardView(cardText: "Front Card", text: $viewModel.frontText)
                SmallCardView(cardText: "Back Card", text: $viewModel.backText)

                Spacer()
                
                Button(action: {
                    viewModel.saveOrAddCard(deck: deck)
                    dismiss()
                }) {
                    Text(deck == nil ? "Save Deck" : "Add Card")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isButtonDisabled(deck: deck) ? .gray.opacity(0.7) : .blue.opacity(0.7))
                        .foregroundStyle(Color.white)
                }
                .disabled(viewModel.isButtonDisabled(deck: deck))
                .cornerRadius(20)
                .padding()
            }
            .padding()
            .padding(.bottom, 10)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

//#Preview {
//    let mockModelContext = ModelContext() // Mock ModelContext
//    let previewDeck = Deck(title: "Sample Deck") // Example Deck
//    
//    LLFirstCardView(
//        deck: previewDeck,
//        modelContext: mockModelContext,
//        onAddCard: { newCard in
//            print("Preview Add Card: \(newCard.front) / \(newCard.back)")
//        },
//        onSave: { newDeck in
//            print("Preview Save Deck: \(newDeck.title)")
//        }
//    )
//}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

