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
    @State private var showItems = false
    @State private var isTitleEditing: Bool = false
    @State private var navigateToFirstCard: Bool = false
    
    init() {
        setupNavigationBarAppearance()
    }
    
    
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.67, green: 0.84, blue: 0.9, alpha: 1.0)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach($decks) { $deck in
                        Group {
                            if isEditing {
                                LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                                    .onTapGesture {
                                        withAnimation {
                                            isTitleEditing = true
                                            showItems = false
                                        }
                                    }
                                    .onDisappear {
                                        isTitleEditing = false
                                    }
                            } else {
                                NavigationLink(destination: LLFinalCardView()) {
                                    LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                                }
                                .buttonStyle(PlainButtonStyle())
                                .padding(10)
                            }
                        }
                        .padding(.vertical, 5)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        
                    }
                    
                    .onDelete(perform: deleteDeck)
                }
                .navigationTitle("My Decks")
                .listStyle(PlainListStyle())
                .background(Color(UIColor.systemGray6))
                .scrollContentBackground(.hidden)
                .padding(.bottom, -10)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            if !isTitleEditing {
                                NavigationLink(destination: LLFirstCardView(card: Card(front: "Front", back: "Back"),
                                                                            onSave: { newCard in
                                    addFirstCardToNewDeck(newCard)
                                }
                                ), isActive: $navigateToFirstCard
                                ){
                                    EmptyView()
                                }
                                
                                Button(action: {
                                    navigateToFirstCard = true
                                }) {
                                    ItemButton(colour: Color.orange.opacity(0.5), iconName: "rectangle.stack.badge.plus")
                                }
                                .offset(y: showItems ? -140 : 0)
                                .animation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showItems)
                            }
                            
                            Button(action: toggleEditing) {
                                ItemButton(colour: decks.isEmpty ? Color.gray.opacity(0.5) : Color.green.opacity(0.5), iconName: isEditing ? "checkmark.circle" : "pencil")
                            }
                            .offset(y: showItems ? -70 : 0)
                            .animation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showItems)
                            .disabled(decks.isEmpty)
                            
                            if !isTitleEditing {
                                Button(action: {
                                    withAnimation(showItems ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.6)) {
                                        showItems.toggle()
                                    }
                                }) {
                                    ItemButton(colour: Color.blue, iconName: "plus")
                                }
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
    
    private func addFirstCardToNewDeck(_ newCard: Card) {
        let newDeck = Deck(image: Image("lamp"), title: "New Deck \(decks.count + 1)", cards: [newCard])
        decks.append(newDeck)
        
        withAnimation(.easeInOut(duration: 0.3)) {
            showItems = false
        }
    }
    
    private func toggleEditing() {
        withAnimation {
            isEditing.toggle()
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
