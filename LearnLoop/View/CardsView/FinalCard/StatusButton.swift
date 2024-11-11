//
//  StatusButton.swift
//  LearnLoop
//
//  Created by Vanessa Hurla on 05/11/2024.
//

import SwiftUI

struct StatusButton: View {

    var color: Color
    var iconName: String
//    var action: () -> Void
    
    var body: some View {
        
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 65, height: 65)
            
            Image(systemName: iconName)
                .font(.system(size: 30))
                .foregroundColor(Color.white)
        }
    }
}


