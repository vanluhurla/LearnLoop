//
//  CounterView.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 15/11/2024.
//

import SwiftUI

struct CounterView: View {
    
    var label: String
    var color: Color
    var count: Int
    
    var body: some View {
        VStack {
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.white)
            Text("\(count)")
                .font(.title2)
                .foregroundStyle(.white)
                .bold()
        }
        .padding()
        .background(color)
        .cornerRadius(10)
    }
}


