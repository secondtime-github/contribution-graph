//
//  MenuView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem { Text("Today") }
                .tag(1)
            GraphView()
                .tabItem { Text("Contribution") }
                .tag(2)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
