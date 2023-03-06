//
//  Hero.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct Hero: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "quote.opening")
                Spacer()
            }
            Image(systemName: "hand.thumbsup.fill")
                .imageScale(.large)
                .foregroundColor(.green)
            Text("Keep going and never give up!")
                .font(.title)
            HStack {
                Spacer()
                Image(systemName: "quote.closing")
            }
        }
        .padding()
        .background(.gray.opacity(0.3))
        .cornerRadius(16)
    }
}

struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero()
    }
}
