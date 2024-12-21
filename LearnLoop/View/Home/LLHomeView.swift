//
//  LLHomeView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI
import SwiftData

struct LLHomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var decks: [Deck]
    @StateObject var viewModel: LLHomeViewModel
    
    init(viewModel: LLHomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        NavigationStack {
            ZStack() {
                VStack {
                    deckList
                }
                .navigationTitle("My Decks")
                .listStyle(PlainListStyle())
                .background(Color.backgroundColour)
                .scrollContentBackground(.hidden)
                .padding(.bottom, -10)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        ZStack {
                            if !viewModel.isTitleEditing {
                                NavigationLink(value: LLHomeViewDestination.firstCard) {
                                    LLHomeViewButton(colour: Color.orange.opacity(0.5),
                                                     iconName: "rectangle.stack.badge.plus")
                                }
                                .offset(y: viewModel.showButtons ? -140 : 0)
                                .animation(viewModel.showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: viewModel.showButtons)
                            }
                            
                            Button(action: viewModel.toggleEditing) {
                                LLHomeViewButton(colour: decks.isEmpty ? Color.gray.opacity(0.5) : Color.green.opacity(0.5),
                                                 iconName: viewModel.isEditing ? "checkmark.circle" : "pencil")
                            }
                            .offset(y: viewModel.showButtons ? -70 : 0)
                            .animation(viewModel.showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeInOut(duration: 0.3), value: viewModel.showButtons)
                            .disabled(decks.isEmpty)
                            
                            if !viewModel.isTitleEditing {
                                Button(action: {
                                    withAnimation(viewModel.showButtons ? .spring(response: 0.5, dampingFraction: 0.5) : .easeIn(duration: 0.6)) {
                                        viewModel.showButtons.toggle()
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
            .navigationDestination(for: LLHomeViewDestination.self) { destination in
                switch destination {
                case .firstCard:
                    LLFirstCardView(
                        modelContext: modelContext,
                        onAddCard: { newCard in
                            print("Added new card: \(newCard.front) / \(newCard.back)")
                        },
                        onSave: { newDeck in
                            viewModel.addNewDeck(newDeck)
                        }
                    )
                }
            }
        }
        .onAppear {
            viewModel.decks = decks
        }
    }
    
    private var deckList: some View {
        VStack {
            List {
                ForEach(viewModel.decks.indices, id: \.self) { index in
                    let deck = viewModel.decks[index]
                    
                    Group {
                        if viewModel.isEditing {
                            LLHomeDeckCell(deck: $viewModel.decks[index], isEditing: viewModel.isEditing)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.isTitleEditing = true
                                        viewModel.showButtons = false
                                    }
                                }
                                .onDisappear {
                                    viewModel.isTitleEditing = false
                                }
                        } else {
                            NavigationLink(destination: LLFinalCardView(deck: deck)) {
                                LLHomeDeckCell(deck: $viewModel.decks[index], isEditing: viewModel.isEditing)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(10)
                        }
                    }
                    .padding(.vertical, 5)
                    .background(Color.backgroundCellColour)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.gray.opacity(0.1), radius: 1, x: 0, y: 1)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteDeck(at: indexSet)
                })
            }
        }
    }
}

//#Preview {
//    LLHomeView()
//}
