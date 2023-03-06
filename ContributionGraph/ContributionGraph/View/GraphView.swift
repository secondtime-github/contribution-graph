//
//  GraphView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct GraphView: View {
    var body: some View {
        HStack {
            ForEach(1...7, id: \.self) { _ in
                Block(value: Int.random(in: 0..<6))
            }
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
    }
}
