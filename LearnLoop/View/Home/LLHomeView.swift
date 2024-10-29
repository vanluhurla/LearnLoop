//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI

struct LLHomeView: View {
    
    @State var decks: [Deck] = []
    @State var navigateToFirstCard: Bool = false
    @State var isEditing: Bool = false
    @State var isTitleEditing: Bool = false
    @State var showButtons: Bool = false
    
    let screen =  UIScreen.main.bounds
    
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
                                NavigationLink(
                                    destination: LLFirstCardView(onSave: { newDeck in
                                        addNewDeck(newDeck)
                                    }),
                                    isActive: $navigateToFirstCard
                                ) {
                                    EmptyView()
                                }
                                
                                Button(action: {
                                    navigateToFirstCard = true
                                }) {
                                    LLHomeViewButton(colour: Color.orange.opacity(0.5),
                                                     iconName: "rectangle.stack.badge.plus")
                                }
                                .offset(y: showButtons ? -140 : 0)
                                .animation(showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: showButtons)
                            }
                            
                            Button(action: toggleEditing) {
                                LLHomeViewButton(colour: decks.isEmpty ? Color.gray.opacity(0.5) : Color.green.opacity(0.5), iconName: isEditing ? "checkmark.circle" : "pencil")
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
        }
    }
    
    private func toggleEditing() {
        withAnimation {
            isEditing.toggle()
            showButtons = false
        }
    }
    
    private func addNewDeck(_ newDeck: Deck) {
        decks.append(newDeck)
    }
    
    private func deleteDeck(at offSets: IndexSet) {
        decks.remove(atOffsets: offSets)
    }
}

#Preview {
    LLHomeView()
}





