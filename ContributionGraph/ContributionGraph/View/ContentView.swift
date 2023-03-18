//
//  ContentView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var routineListVM: RoutineListViewModel
    
    @State var currentDate: Date = Date()
    
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
                    ForEach(Category.allCases) { category in
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
                ForEach(routineListVM.items.filter({!$0.isArchived}), id: \.self) { item in
                    HStack {
                        Image(systemName: "dumbbell")
                        Text(item.name)
                        Spacer()
                        
                        Button(action: {
                            routineListVM.changeTaskStatus(item, at: currentDate)
                        }) {
                            Image(systemName: routineListVM
                                .days[dateFormatter.string(from: currentDate)]?
                                .tasks[item]?.isDone ?? false
                                  ? "checkmark.circle.fill"
                                  : "circle")
                        }
                        .foregroundColor(.green)
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
            .environmentObject(RoutineListViewModel())
    }
}
