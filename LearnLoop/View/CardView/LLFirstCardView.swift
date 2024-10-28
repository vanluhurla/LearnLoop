//
//  LLFirstCardView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 07/08/2024.
//

import SwiftUI

struct LLFirstCardView: View {
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
                    let newDeck = Deck(image: Image("lamp"), title: deckName, cards: [newCard])
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


//@Environment(\.dismiss) var dismiss // Here I'm handling navigation back
//    @State private var frontText: String
//    @State private var backText: String
//    @State private var deckName: String = ""
//    @State private var isShowingFront: Bool = true
//
//    var onSave: (Deck) -> Void
//
//    init(card: Card, onSave: @escaping (Deck) -> Void) {
//        _frontText = State(initialValue: card.front)
//        _backText = State(initialValue: card.back)
//        self.onSave = onSave
//    }
//
//    var body: some View {
//        VStack {
//            TextField("Deck Name", text: $deckName)
//                .font(.title)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(10)
//                .padding(.bottom, 20)
//
//            Spacer()
//
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color.white)
//                    .frame(width: 350, height: 600)
//                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
//
//                if isShowingFront {
//                    VStack {
//                        Text("Front - Tap to turn")
//                            .font(.headline)
//                            .padding(.bottom, 50)
//
//                        TextEditor(text: $frontText)
//                            .multilineTextAlignment(.center)
//                            .font(.largeTitle)
//                            .padding()
//                            .frame(width: 300, height: 400)
//                            .background(Color.clear)
//                    }
//                    .onTapGesture {
//                        withAnimation {
//                            isShowingFront.toggle()
//                        }
//                    }
//                } else {
//                    VStack {
//                        Text("Back - Tap to turn")
//                            .font(.headline)
//                            .padding(.bottom, 50)
//
//                        TextEditor(text: $backText)
//                            .multilineTextAlignment(.center)
//                            .font(.largeTitle)
//                            .padding()
//                            .frame(width: 300, height: 400)
//                            .background(Color.clear)
//                    }
//                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
//                    .onTapGesture {
//                        withAnimation {
//                            isShowingFront.toggle()
//                        }
//                    }
//                }
//            }
//            .rotation3DEffect(
//                .degrees(isShowingFront ? 0 : 180), axis: (x: 0, y: 1, z: 0)
//            )
//            .animation(.easeInOut, value: isShowingFront)
//
//            Spacer()
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button("Save") {
//                    let newCard = Card(front: frontText, back: backText)
//                    let newDeck = Deck(image: Image("lamp"), title: deckName, cards: [newCard])
//                    onSave(newDeck)
//                    dismiss()
//                }
//                .disabled(deckName.isEmpty || frontText.isEmpty || backText.isEmpty)
//            }
//        }
//        .padding()
//    }

//#Preview {
//    LLFirstCardView(card: Card(front: "Front Text", back: "Back Text")) { newDeck in
//        print("Deck created: \(newDeck.title), with card: \(newDeck.cards.first?.front ?? "") / \(newDeck.cards.first?.back ?? "")")
//    }
//}
