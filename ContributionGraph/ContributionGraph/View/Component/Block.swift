//
//  Block.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-04.
//

import SwiftUI

struct Block: View {
    
    var value: Int = 5
    
    var body: some View {
        Rectangle()
            .fill(color(for: value))
            .frame(width: 30, height: 30)
            .cornerRadius(8)
    }
    
    func color(for value: Int) -> Color {
        switch value {
        case 0:
            return .gray.opacity(0.5)
        case 1:
            return .green.opacity(0.2)
        case 2:
            return .green.opacity(0.4)
        case 3:
            return .green.opacity(0.6)
        case 4:
            return .green.opacity(0.8)
        case 5...:
            return .green
        default:
            return .white
        }
    }
}

struct Block_Previews: PreviewProvider {
    static var previews: some View {
        Block()
    }
}
