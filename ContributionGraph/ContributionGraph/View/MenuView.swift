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
            RoutineListView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("List")
                }
                .tag(0)
            ContentView()
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Today")
                }
                .tag(1)
            GraphView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Contribution")
                }
                .tag(2)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(RoutineListViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
