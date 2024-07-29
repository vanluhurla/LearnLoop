//
//  MainView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/07/2024.
//

import SwiftUI

struct MainView: View {
    
    @State var deckOne: [String] = ["UIKit", "SwiftUI"]
    
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("Programming")) {
                        ForEach(deckOne, id: \.self) { content in
                            Text(content)
                        }
                    }
            }
            .navigationTitle("My Decks")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                }
            }
        }
    }
}

#Preview {
    MainView()
}
