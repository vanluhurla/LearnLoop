//
//  EditableCardView.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 07/01/2025.
//

import SwiftUI

enum CardField {
    case front, back
}

struct EditableCardView: View {
    @State private var isFlipped = false
    
    @State var frontText: String = ""
    @State var backText: String = ""
    
    @FocusState private var focusedField: CardField?
    
    var didCreateCard: (_ card: Card) -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ZStack {
                        front
                            .opacity(isFlipped ? 0 : 1)
                        back
                            .opacity(isFlipped ? 1 : 0)
                    }
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                    .padding(.top, 45)
                    
                    flipCardButton
                        .padding(10)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        createButton
                    }
                }
            }.scrollIndicators(.hidden)
                .onTapGesture {
                    hideEditableCardKeyboard()
                }
                .onAppear {
                    focusedField = .front
                }
        }
    }
}

//MARK: Action
private extension EditableCardView {
    func flipAnimation() {
        withAnimation(.easeIn) {
            isFlipped.toggle()
            focusedField = isFlipped ? .back : .front
        }
    }
    
    func createCard() -> Card {
        Card(front: frontText, back: backText)
    }
}

//MARK: Views
private extension EditableCardView {
    var front: some View {
        VStack(alignment: .leading) {
            ZStack {
                TextField("Type here", text: $frontText, axis: .vertical)
                    .lineLimit(5...10)
                    .multilineTextAlignment(.leading)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .frame(height: 240)
                    .background(Color.clear)
                    .focused($focusedField, equals: .front)
            }
        }
        .frame(width: 350, height: 250)
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
        VStack(alignment: .leading) {
            ZStack {
                TextField("Type here", text: $backText, axis: .vertical)
                    .lineLimit(5...10)
                    .multilineTextAlignment(.leading)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .frame(height: 240)
                    .background(Color.clear)
                    .focused($focusedField, equals: .back)
            }
        }
        .frame(width: 350, height: 250)
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
    
    var createButton: some View {
        Button("Create") {
            didCreateCard(createCard())
        }
        .font(.headline)
    }
    
    var flipCardButton: some View {
        Button(action: {
            flipAnimation()
        }) {
            Text("Tap to flip")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(30)
        }
        .frame(width: 200)
    }
}

extension View {
    func hideEditableCardKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//#Preview {
//    StatefulPreviewWrapper("Front Side", "Back Side", false) { frontText, backText, isAddingCard in
//        EditableCardView(
//            frontText: frontText,
//            backText: backText,
//            isAddingCard: isAddingCard
//        )
//    }
//}
//
//struct StatefulPreviewWrapper<Content: View>: View {
//    @State private var frontText: String
//    @State private var backText: String
//    @State private var isAddingCard: Bool
//
//    let content: (Binding<String>, Binding<String>, Binding<Bool>) -> Content
//
//    init(
//        _ frontText: String,
//        _ backText: String,
//        _ isAddingCard: Bool,
//        @ViewBuilder content: @escaping (Binding<String>, Binding<String>, Binding<Bool>) -> Content
//    ) {
//        _frontText = State(initialValue: frontText)
//        _backText = State(initialValue: backText)
//        _isAddingCard = State(initialValue: isAddingCard)
//        self.content = content
//    }
//
//    var body: some View {
//        content($frontText, $backText, $isAddingCard)
//    }
//}
