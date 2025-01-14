//
//  DeckDetailsView.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 02/01/2025.
//

import SwiftUI

struct DeckDetailsView: View {
    
    @ObservedObject private var viewModel: DeckDetailsViewModel
    
    @State var isTitleEditing: Bool = false
    @State var isAddingCard: Bool = false
    
    init(viewModel: DeckDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    deckTitle
                    statusCardCounter
                    card
                    actionButtons
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.backgroundPrimary)
            }
            .scrollIndicators(.hidden)
            .onTapGesture {
                hideDeckDetailsKeyboard()
            }
            .onAppear {
                refreshActiveCards()
            }
            .alert(viewModel.errorTitle,
                   isPresented: $viewModel.didReceiveError) {
            } message: {
                Text(viewModel.errorMessage)
            }
        }
        .background(Color.backgroundPrimary)
    }
}

// MARK: Views
private extension DeckDetailsView {
    var deckTitle: some View {
        HStack {
            if isTitleEditing {
                TextField("Deck Title", text: $viewModel.deckTitle)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)
                    .padding(.horizontal, 10)
            } else {
                Text(viewModel.deck.title)
                    .font(.title)
                    .frame(height: 40)
            }
            Button(action: {
                isTitleEditing.toggle()
                saveTitle()
            }) {
                Image(systemName: isTitleEditing
                      ? "checkmark.circle"
                      : "pencil")
                .font(.title)
                .foregroundColor(isTitleEditing ? .green : .blue)
            }
        }
        .padding(10)
    }
    
    var statusCardCounter: some View {
        HStack(spacing: 30) {
            CounterView(label: "Learned",
                        color: Color.theme.learnedAction,
                        count: viewModel.deck.learnedCards.count)
            CounterView(label: "Available",
                        color: Color.theme.accent,
                        count: viewModel.deck.availableCards.count)
            CounterView(label: "Review",
                        color: Color.theme.reviewAction,
                        count: viewModel.deck.reviewedCards.count)
        }
    }
    
    var card: some View {
        ZStack {
            if viewModel.activeCards.isEmpty {
                VStack {
                    Text(
                    """
                          No card available.
                    Press + to add new card.
                    """
                    )
                    .frame(alignment: .center)
                    .font(.headline)
                    .foregroundStyle(.gray)
                    .padding()
                }
            } else {
                cardView
            }
        }
        .frame(width: 300, height: 400)
        .padding(30)
    }
    
    var cardView: some View {
        CardView(frontText: getCurrentCard()?.front ?? "",
                 backText: getCurrentCard()?.back ?? "")
    }
    
    var actionButtons: some View {
        HStack(spacing: 30) {
            ActionButton(type: viewModel.retrieveLearnedCards ? .retrieveLearned : .learn) {
                if viewModel.retrieveLearnedCards {
                    showRetrievedLearnedConfirmation()
                } else {
                    markCardAsLearned()
                }
            }
            .confirmationDialog("Retrieve learned cards?",
                                isPresented: $viewModel.showRetrieveLearnedDialog,
                                titleVisibility: .visible) {
                Button("Retrieve", role: .destructive) {
                    retrieveLearnedCard()
                }
                Button("Cancel", role: .cancel) {
                }
            }
            ActionButton(type: .create) {
                isAddingCard = true
            }
            .sheet(isPresented: $isAddingCard) {
                EditableCardView(viewModel: EditableCardViewModel()) { card in
                    isAddingCard = false
                    saveCard(card: card)
                }
            }
            ActionButton(type: viewModel.retrieveReviewCards ? .retrieveReview : .review) {
                if viewModel.retrieveReviewCards {
                    showRetrievedReviewConfirmation()
                } else {
                    markCardToReview()
                }
            }
            .confirmationDialog("Retrieve cards for review?",
                                isPresented: $viewModel.showRetrieveReviewDialog,
                                titleVisibility: .visible) {
                Button("Retrieve", role: .destructive) {
                    retrieveReviewCard()
                }
                Button("Cancel", role: .cancel) {}
            }
        }
        .padding(.bottom, 30)
    }
}

//MARK: Action
private extension DeckDetailsView {
    func saveTitle() {
        viewModel.saveTitle()
    }
    
    func saveCard(card: Card) {
        viewModel.saveCard(card: card)
    }
    
    func markCardAsLearned() {
        viewModel.markCardAsLearned()
    }
    
    func markCardToReview() {
        viewModel.markCardToReview()
    }
    
    func refreshActiveCards() {
        viewModel.refresh()
    }
    
    func showRetrievedLearnedConfirmation() {
        viewModel.showRetrievedLearnedConfirmation()
    }
    
    func showRetrievedReviewConfirmation() {
        viewModel.showRetrievedReviewConfirmation()
    }
    
    func retrieveLearnedCard() {
        viewModel.retrieveLearnedCard()
    }
    
    func retrieveReviewCard() {
        viewModel.retrieveReviewCard()
    }
    func getCurrentCard() -> Card? {
        viewModel.getCurrentCard()
    }
    
    func hideDeckDetailsKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
