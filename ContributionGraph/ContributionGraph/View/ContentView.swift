//
//  ContentView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct ContentView: View {
    
    var list: [String] = ["GYM", "English", "Android","Books", "Work"]
    
    var body: some View {
        VStack {
            // Hero
            Hero()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Category.allCases, id: \.self) { category in
                        Button(action: {}) {
                            Text(category.rawValue)
                                .foregroundColor(.black)
                                .padding()
                                .background(.green.opacity(0.5))
                                .cornerRadius(16)
                        }
                    }
                }
            }
            
            List {
                ForEach(list, id: \.self) { item in
                    HStack {
                        Image(systemName: "dumbbell")
                        Text(item)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
