//
//  DeckDetailsView.swift
//  LearnLoop
//
//  Created by Vanessa Lucena on 02/01/2025.
//

import SwiftUI

struct DeckDetailsView: View {
    @Environment(\.modelContext) private var context
    @State var title: String = ""
    @State var isTitleEditing: Bool = false
    @State var frontText: String = ""
    @State var backText: String = ""
    @State var isAddingCard: Bool = false
    @State var activeCards: [Card] = []
    
    @State private var retrieveLearnedCards = false
    @State private var retrieveReviewCards = false
    @State private var showRetrieveLearnedDialog = false
    @State private var showRetrieveReviewDialog = false
    
    var deck: Deck
    var currentCard: Card? {
        activeCards.last
    }
    var currentCardIndex: Int {
        (currentCard?.sequence ?? 0) + 1
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    deckTitle
                        .padding()
                    statusCardCounter
                        .padding(5)
                    card
                        .padding(-10)
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
        }
        .background(Color.backgroundPrimary)
    }
}

// MARK: Views
private extension DeckDetailsView {
    var deckTitle: some View {
        HStack {
            if isTitleEditing {
                TextField("Deck Title", text: $title)
                    .font(.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)
            } else {
                Text(deck.title)
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
        .padding(.horizontal, 50)
    }
    
    var statusCardCounter: some View {
        HStack(spacing: 30) {
            CounterView(label: "Learned",
                        color: Color.theme.learnedAction,
                        count: deck.learnedCards.count)
            CounterView(label: "Available",
                        color: Color.theme.accent,
                        count: deck.availableCards.count)
            CounterView(label: "Review",
                        color: Color.theme.reviewAction,
                        count: deck.reviewedCards.count)
        }
    }
    
    var card: some View {
        ZStack {
            if activeCards.isEmpty {
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
        }.frame(width: 300, height: 400)
            .padding(30)
    }
    
    var cardView: some View {
        CardView(frontText: currentCard?.front ?? "",
                 backText: currentCard?.back ?? "")
    }
    
    var actionButtons: some View {
        HStack(spacing: 30) {
            ActionButton(type: deck.availableCards.isEmpty && retrieveLearnedCards ? .retrieveLearned : .learn) {
                if activeCards.isEmpty && retrieveLearnedCards {
                    showRetrievedLeanedConfirmation()
                } else {
                    markCardAsLearned()
                }
            }
            .confirmationDialog("Retrieve learned cards?",
                                isPresented: $showRetrieveLearnedDialog,
                                titleVisibility: .visible) {
                Button("Retrieve", role: .destructive) {
                    retrieveLearnedCard()
                }
                Button("Cancel", role: .cancel) {}
            }
            
            ActionButton(type: .create) {
                frontText = ""
                backText = ""
                isAddingCard = true
            }
            .sheet(isPresented: $isAddingCard) {
                EditableCardView(viewModel: EditableCardViewModel()) { card in
                    isAddingCard = false
                    saveCard(card: card)
                }
            }
            
            
            ActionButton(type: deck.availableCards.isEmpty && retrieveReviewCards ? .retrieveReview : .review) {
                if activeCards.isEmpty && retrieveReviewCards {
                    showRetrievedReviewConfirmation()
                } else {
                    markCardToReview()
                }
            }
            .confirmationDialog("Retrieve cards for review?",
                                isPresented: $showRetrieveReviewDialog,
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
        deck.title = title
        saveChanges()
    }
    
    func saveCard(card: Card) {
        let sequence: Int = {
            if let latestCard = deck.currentAvailableCard {
                return latestCard.sequence + 1
            } else {
                return 0
            }
        }()
        card.sequence = sequence
        deck.cards.append(card)
        saveChanges()
    }
    
    func markCardAsLearned() {
        guard let currentCard = deck.currentAvailableCard else { return }
        currentCard.isLearned = true
        saveChanges()
    }
    
    func markCardToReview() {
        guard let currentCard = deck.currentAvailableCard else { return }
        currentCard.forReview = true
        saveChanges()
    }
    
    func saveChanges() {
        saveContext()
        refreshActiveCards()
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch {
            // show an alert saying the changes could not be saved
        }
    }
    
    func refreshActiveCards() {
        activeCards = deck.availableCards
        retrieveLearnedCards = !deck.learnedCards.isEmpty
        retrieveReviewCards = !deck.reviewedCards.isEmpty
    }
    
    func showRetrievedLeanedConfirmation() {
        showRetrieveLearnedDialog = true
    }
    
    func showRetrievedReviewConfirmation() {
        showRetrieveReviewDialog = true
    }
    
    func retrieveLearnedCard() {
        for card in deck.learnedCards {
            card.isLearned = false
        }
        saveChanges()
    }
    
    func retrieveReviewCard() {
        for card in deck.reviewedCards {
            card.forReview = false
        }        
        saveChanges()
    }
}

#Preview {
    DeckDetailsView(isTitleEditing: true,
                    deck: Deck(title: "Deck Title"))
}

extension View {
    func hideDeckDetailsKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
