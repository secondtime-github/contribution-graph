//
//  MenuView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct MenuView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            RoutineListView()
                .environmentObject(RoutineListViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("List")
                }
                .tag(0)
            
            ContentView()
                .environmentObject(TodayViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "flag.checkered")
                    Text("Today")
                }
                .tag(1)
            
            GraphView()
                .environmentObject(GraphViewModel(context: viewContext))
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Contribution")
                }
                .tag(2)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext
            )
    }
}
