//
//  ContributionGraphApp.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

@main
struct ContributionGraphApp: App {
    
    let viewContext = PersistenceController.shared.container.viewContext
    
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(ViewModel(context: viewContext))
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
