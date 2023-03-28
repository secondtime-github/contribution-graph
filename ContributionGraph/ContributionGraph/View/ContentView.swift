//
//  ContentView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var routineListVM: ViewModel
    
    @State var currentDate: Date = Date()
    var formattedCurrentDate: String {
        dateFormatter.string(from: currentDate)
    }
    
    let statusList = ["All", "Completed", "Not Completed"]
    @State var currentStatus = "All"
    
    var currentDay: OneDay? {
        routineListVM.days[formattedCurrentDate]
    }
    
    var filteredTasks: [RoutineItem] {
        let filteredItems = routineListVM.items.filter { !$0.isArchived }
        let currentCompletedItems = currentDay?.tasks.filter { $0.value.isDone }.map { $0.key } ?? []
        
        if currentStatus == "Completed" {
            return currentCompletedItems
        } else if currentStatus == "All" {
            return filteredItems
        } else {
            let diff = Set(filteredItems).subtracting(Set(currentCompletedItems))
            return Array(diff)
        }
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
                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: currentDate))
                
                Button(action: {
                    currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
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
                ForEach(filteredTasks, id: \.self) { item in
                    HStack {
                        Text(item.icon)
                        Text(item.name)
                        Spacer()
                        
                        Button(action: {
                            routineListVM.changeTaskStatus(item, at: currentDate)
                        }) {
                            Image(systemName: currentDay?.tasks[item]?.isDone ?? false
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
            .environmentObject(ViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
