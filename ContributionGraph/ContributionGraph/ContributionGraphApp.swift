//
//  ContributionGraphApp.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

@main
struct ContributionGraphApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(
                    RoutineListViewModel(context: persistenceController.container.viewContext)
                )
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext
                )
        }
    }
}
