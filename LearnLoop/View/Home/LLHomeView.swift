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
                // List view with less padding or negative padding to avoid blocking the scroll
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
                .background(Color(UIColor.systemGray6)) // Light grey background for the List
                .scrollContentBackground(.hidden)
                .padding(.bottom, 15) // Less padding so content can scroll behind buttons
                
                // Buttons stacked on top of the list
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            // Add the buttons
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
                            
                            // Main Button
                            Button(action: {
                                withAnimation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.6)) {
                                    showItems.toggle()
                                }
                            }) {
                                ItemButton(colour: Color.blue, iconName: "plus")
                            }
                        }
                        .padding([.bottom, .trailing], 25) // Padding to keep the buttons off the edges
                        .zIndex(1) // Ensure buttons are above the list
                    }
                }
                .frame(width: screen.width) // Ensure the frame covers the area
            }
            .background(Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)) // Background color for the entire view
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
