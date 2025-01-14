//
//  HomeDeckCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 31/07/2024.
//

import SwiftUI

struct HomeDeckCell: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(Color.black)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
        }
        .padding(.vertical)
        .background(Color.theme.backgroundCell)
        .contentShape(Rectangle())
        .padding()
    }
}


