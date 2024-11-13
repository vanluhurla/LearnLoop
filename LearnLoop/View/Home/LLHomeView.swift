//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI
import SwiftData

enum LLHomeViewDestination: Hashable {
    case firstCard
}

struct LLHomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var decks: [Deck]
    
    @State private var localDecks: [Deck] = []  // Local state to hold mutable deck array
    @State var isEditing: Bool = false
    @State var isTitleEditing: Bool = false
    @State var showButtons: Bool = false
    @State private var selectedDestination: LLHomeViewDestination? = nil
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    deckList
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
                                // Orange Button using NavigationLink with `value`
                                NavigationLink(value: LLHomeViewDestination.firstCard) {
                                    LLHomeViewButton(colour: Color.orange.opacity(0.5),
                                                     iconName: "rectangle.stack.badge.plus")
                                }
                                .offset(y: showButtons ? -140 : 0)
                                .animation(showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showButtons)
                            }
                            
                            // Edit button
                            Button(action: toggleEditing) {
                                LLHomeViewButton(colour: decks.isEmpty ? Color.gray.opacity(0.5) : Color.green.opacity(0.5),
                                                 iconName: isEditing ? "checkmark.circle" : "pencil")
                            }
                            .offset(y: showButtons ? -70 : 0)
                            .animation(showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showButtons)
                            .disabled(decks.isEmpty)
                            
                            if !isTitleEditing {
                                Button(action: {
                                    withAnimation(showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeIn(duration: 0.6)) {
                                        showButtons.toggle()
                                    }
                                }) {
                                    LLHomeViewButton(colour: Color.blue, iconName: "plus")
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
            // Define the destination view using `navigationDestination`
            .navigationDestination(for: LLHomeViewDestination.self) { destination in
                switch destination {
                case .firstCard:
                    LLFirstCardView(onSave: { newDeck in
                        addNewDeck(newDeck)
                    })
                }
            }
        }
        .onAppear {
            // Populate localDecks with data from @Query
            localDecks = decks
        }
    }
    
    private var deckList: some View {
        VStack {
            List {
                ForEach($localDecks) { $deck in  // Use the localDecks for editable binding
                    Group {
                        if isEditing {
                            LLHomeDeckCell(deck: $deck, isEditing: isEditing)
                                .onTapGesture {
                                    withAnimation {
                                        isTitleEditing = true
                                        showButtons = false
                                    }
                                }
                                .onDisappear {
                                    isTitleEditing = false
                                }
                        } else {
                            NavigationLink(destination: LLFinalCardView(deck: deck)) {
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
        }
    }
    
    private func toggleEditing() {
        withAnimation {
            isEditing.toggle()
            showButtons = false
        }
    }
    
    private func addNewDeck(_ newDeck: Deck) {
        modelContext.insert(newDeck)
        
        do {
            try modelContext.save()
            print("Deck saved successfully!")
        } catch {
            print("Error saving deck: \(error.localizedDescription)")
        }
        
        
        localDecks.append(newDeck)
    }
    
    private func deleteDeck(at offSets: IndexSet) {
        for index in offSets {
            let deckToDelete = localDecks[index]
            modelContext.delete(deckToDelete)
        }
        localDecks.remove(atOffsets: offSets)  
    }
}

#Preview {
    LLHomeView()
}
