//
//  PrintDaysView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-29.
//

import SwiftUI

struct PrintDaysView: View {
    
    @EnvironmentObject var vm: TodayViewModel
    
    var routines: [Routine] {
        vm.tasks.map { $0.key }
    }
    
    var body: some View {
        List {
            ForEach(routines, id: \.self) { routine in
                Text(routine.name)
                Text((vm.tasks[routine] ?? false) ? "Yes" : "No")
            }
        }
    }
}

struct PrintDaysView_Previews: PreviewProvider {
    static var previews: some View {
        PrintDaysView()
            .environmentObject(TodayViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
