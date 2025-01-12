//
//  HomeView.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 31/12/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
        
    @ObservedObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                deckList
                createDeckButton
            }
            .navigationTitle("My Decks")
            .listStyle(PlainListStyle())
            .background(Color.backgroundPrimary)
            .scrollContentBackground(.hidden)
            .onAppear {
                viewModel.fetchDecks()
            }
            .alert(viewModel.errorTitle,
                   isPresented: $viewModel.didReceiveError) {
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

// MARK: Views
private extension HomeView {
    var deckList: some View {
        VStack {
            List {
                ForEach(viewModel.decks) { deck in
                    NavigationLink(destination: DeckDetailsView(deck: deck)) {
                        HomeDeckCell(title: deck.title)
                            .swipeActions {
                                deleteDeckButton(for: deck)
                            }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(Color.backgroundCell)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(color: Color.gray.opacity(0.1), radius: 1, x: 0, y: 1)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
    }
    
    var createDeckButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Button(action: createDeck) {
                        HomeViewButton()
                    }
                    .padding([.bottom, .trailing], 25)
                }
            }
        }
    }
    
    func deleteDeckButton(for deck: Deck) -> some View {
        Button(action: {
            deleteDeck(deck)
        }) {
            if let image = UIImage(systemName: "trash") {
                Image(uiImage: image.withTintColor(.red, renderingMode: .alwaysOriginal))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
            }
        }
        .tint(Color.backgroundPrimary)
    }
}

// MARK: Actions
private extension HomeView {
    func createDeck() {
        viewModel.createDeck()
    }
    
    func deleteDeck(_ deck: Deck) {
        viewModel.deleteDeck(deck)
    }
}

