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
    
    @State private var deckName: String = ""
    @State private var frontText: String = ""
    @State private var backText: String = ""
    
    var onSave: ((Deck) -> Void)?
    var deck: Deck?
    var onAddCard: ((Card) -> Void)?
    
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
                    TextField("Deck Name", text: $deckName)
                        .font(.title)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(20)
                        .padding(.bottom, 20)
                }

                // MARK: Front Card
                SmallCardView(cardText: "Front Card", text: $frontText)

                
                // MARK: Front Card
                
                SmallCardView(cardText: "Back Card", text: $backText)

                
                Spacer()
                
                // MARK: Save Button
                Button(action: {
                    if deck != nil {
                        let newCard = Card(front: frontText, back: backText)
                        onAddCard?(newCard)
                    } else {
                        let newCard = Card(front: frontText, back: backText)
                        let newDeck = Deck(title: deckName)
                        newDeck.cards.append(newCard)
                        
                        modelContext.insert(newDeck)
                        
                        do {
                            try modelContext.save()
                            print("Deck saved successfully!")
                        } catch {
                            print("Error saving deck: \(error.localizedDescription)")
                        }
                        onSave?(newDeck)
                    }
                    dismiss()
                }) {
                    Text(deck == nil ? "Save Deck" : "Add Card")
                        .font(.title)
                        .fontWeight(.bold)
                        
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(!deckName.isEmpty && deckName.isEmpty || frontText.isEmpty || backText.isEmpty ? .gray.opacity(0.7) : .blue.opacity(0.7))
                        .foregroundStyle(Color.white)
                }
                .disabled(deckName.isEmpty && deck == nil || frontText.isEmpty || backText.isEmpty)
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

#Preview {
    LLFirstCardView { newDeck in
        print("New Deck: \(newDeck.title)")
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

