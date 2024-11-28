//
//  CounterViewCell.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 15/11/2024.
//

import SwiftUI

struct CounterViewCell: View {
    
    var label: String
    var color: Color
    @Binding var count: Int
    
    var body: some View {
        VStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.gray)
            Text("\(count)")
                .font(.title2)
                .bold()
        }
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}


