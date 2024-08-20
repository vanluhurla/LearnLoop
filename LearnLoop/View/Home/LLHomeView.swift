//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI

struct LLHomeView: View {
    
    @State private var decks: [Deck] = []
    @State private var isEditing: Bool = false
    @State var showItems = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach($decks) { $deck in
                        if isEditing {
                            LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                        } else {
                            NavigationLink(destination: LLCardView(card: deck.cards.first ?? Card(front: "Front", back: "Back"))) {
                                LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onDelete(perform: deleteDeck)
                }
                .navigationTitle("My Decks")
                .background(Color(UIColor.systemGray6))
                .scrollContentBackground(.hidden)
                .padding(.bottom, 15)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            Button(action: addNewDeck) {
                                ItemButton(colour: Color.orange.opacity(0.5), iconName: "rectangle.stack.badge.plus")
                            }
                            .offset(y: showItems ? -140 : 0)
                            .animation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showItems)
                            
                            Button(action: toggleEditing) {
                                ItemButton(colour: decks.isEmpty ? Color.gray.opacity(0.5) : Color.green.opacity(0.5), iconName: isEditing ? "checkmark.circle" : "pencil")
                            }
                            .offset(y: showItems ? -70 : 0)
                            .animation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showItems)
                            .disabled(decks.isEmpty)
                            
                            Button(action: {
                                withAnimation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.6)) {
                                    showItems.toggle()
                                }
                            }) {
                                ItemButton(colour: Color.blue, iconName: "plus")
                            }
                        }
                        .padding([.bottom, .trailing], 25)
                        .zIndex(1)
                    }
                }
                .frame(width: screen.width)
            }
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all))
        }
    }
    
    private func toggleEditing() {
        isEditing.toggle()
    }
    
    private func addNewDeck() {
        let newDeck = Deck(image: Image("lamp"), title: "New Deck", cards: [Card(front: "Example Front", back: "Example Back")])
        decks.append(newDeck)
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showItems = false
        }
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        decks.remove(atOffsets: offsets)
    }
}
    
#Preview {
    LLHomeView()
}

let screen =  UIScreen.main.bounds

struct ItemButton: View {
    var colour: Color
    var iconName: String
    var body: some View {
        
        ZStack {
            Circle()
                .fill(colour)
                .frame(width: 65, height: 65)
            
            Image(systemName: iconName)
                .font(.system(size: 30))
                .foregroundColor(Color.white)
        }
    }
}
