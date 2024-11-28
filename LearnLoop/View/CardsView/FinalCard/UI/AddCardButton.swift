//
//  AddCardButton.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 15/11/2024.
//

import SwiftUI

struct AddCardButton: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30)
            
            Image(systemName: "plus")
                .font(.system(size: 20))
                .foregroundColor(Color.white)
        }
    }
}

#Preview {
    AddCardButton()
}
