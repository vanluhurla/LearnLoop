//
//  LLFirstCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI

struct LLFirstCardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var deckName: String = ""
    @State private var frontText: String = ""
    @State private var backText: String = ""
    
    var onSave: (Deck) -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Deck Name", text: $deckName)
                    .font(.title)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                
                Text("Front Card")
                    .font(.headline)
                TextEditor(text: $frontText)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                    .frame(height: 210)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Text("Back Card")
                    .font(.headline)
                TextEditor(text: $backText)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                    .frame(height: 210)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                Spacer()
                
                Button(action: {
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
                    
                    
                    onSave(newDeck)
                    
                    dismiss()
                }) {
                    Text("Save")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(deckName.isEmpty || frontText.isEmpty || backText.isEmpty ? Color.gray : Color.blue)
                        .foregroundStyle(Color.white)
                }
                .disabled(deckName.isEmpty || frontText.isEmpty || backText.isEmpty)
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
