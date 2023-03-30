//
//  ContentView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var vm: TodayViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RoutineEntity.name, ascending: true)],
        animation: .default
    )
    private var routineEntities: FetchedResults<RoutineEntity>
    
    let statusList = ["All", "Completed", "Not Completed"]
    @State var currentStatus = "All"
    
    var filteredRoutines: [Routine] {
        let allRoutines: [Routine] = routineEntities.map { Routine(entity: $0) }
        let completedRoutines: [Routine] = vm.tasks.filter { $0.value } .map { $0.key }

        switch currentStatus {
        case "All":
            return allRoutines
        case "Completed":
            return completedRoutines
        default:
            let diff = Set(allRoutines).subtracting(Set(completedRoutines))
            return Array(diff)
        }
    }
    
    var formattedCurrentDate: String {
        dateFormatter.string(from: vm.currentDate)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    vm.currentDate = Calendar.current.date(byAdding: .day, value: -1, to: vm.currentDate)!
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(formattedCurrentDate)
                
                Button(action: {
                    vm.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: vm.currentDate)!
                }) {
                    Image(systemName: "arrow.right")
                }
            }
            
            // Hero
            Hero()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(statusList, id: \.self) { status in
                        Button(action: {
                            currentStatus = status
                        }) {
                            Text(status)
                                .foregroundColor(.primary)
                                .padding()
                                .frame(minWidth: 120)
                                .background(.green.opacity(
                                    currentStatus == status ? 1 : 0.5)
                                )
                                .cornerRadius(16)
                        }
                    }
                }
            }
            .padding()
            
            List {
                ForEach(filteredRoutines, id: \.self) { routine in
                    HStack {
                        Text(routine.icon)
                        Text(routine.name)
                        Spacer()
                        
                        Button(action: {
                            vm.toggleTask(with: routine)
                        }) {
                            Image(systemName: vm.tasks[routine] ?? false
                                  ? "checkmark.circle.fill"
                                  : "circle")
                        }
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TodayViewModel(context: PersistenceController.preview.container.viewContext))
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
