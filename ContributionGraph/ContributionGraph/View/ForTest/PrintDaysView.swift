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
    
    @State var isShown = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(routines, id: \.self) { routine in
                    Text(routine.name)
                    Text((vm.tasks[routine] ?? false) ? "Yes" : "No")
                }
                
            }
            .onAppear {
                vm.fetchTasks()
            }
            .sheet(isPresented: $isShown) {
                Text("aaa")
            }
            .navigationBarTitleDisplayMode(.large)
            .toolbar(content: {
                Button(action: {isShown.toggle()}, label: {
                    Text("On")
                })
            })
        }
    }
}

struct PrintDaysView_Previews: PreviewProvider {
    static var previews: some View {
        PrintDaysView()
            .environmentObject(TodayViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
