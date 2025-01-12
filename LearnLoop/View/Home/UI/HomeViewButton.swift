//
//  HomeViewButton.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 24/10/2024.
//

import SwiftUI

struct HomeViewButton: View {
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 65, height: 65)
            
            Image(systemName: "plus")
                .font(.system(size: 30))
                .foregroundColor(Color.white)
        }
    }
}
