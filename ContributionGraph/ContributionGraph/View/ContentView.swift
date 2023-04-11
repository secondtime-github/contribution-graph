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
        predicate: NSPredicate(format: "isArchived == false")
    )
    private var routineEntities: FetchedResults<RoutineEntity>
    
    @State var currentCategory: Category? = nil
    
    var filteredRoutines: [Routine] {
        return routineEntities
            .map { Routine(entity: $0) }
            .filter { routine in
                if let currentCategory = currentCategory {
                    return routine.category == currentCategory
                }
                return true
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
            dateBar
            Hero()
            categoryFilter
            checkSheet
        }
        .onAppear {
            vm.fetchTasks()
        }
    }
    
    var dateBar: some View {
        HStack {
            Button(action: {
                vm.currentDate = Calendar.current.date(byAdding: .day, value: -1, to: vm.currentDate)!
            }) {
                Image(systemName: "arrow.left").bold()
            }
            
            Text(formattedCurrentDate)
                .fontWeight(.heavy)
                .font(.system(size: 28))
                .padding(.horizontal)
            
            Button(action: {
                vm.currentDate = Calendar.current.date(byAdding: .day, value: 1, to: vm.currentDate)!
            }) {
                Image(systemName: "arrow.right").bold()
            }
        }
    }
    
    var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                CategoryButton(
                    currentCategory: $currentCategory,
                    category: nil
                )
                ForEach(Category.allCases) { category in
                    CategoryButton(
                        currentCategory: $currentCategory,
                        category: category
                    )
                }
            }
        }
        .padding()
    }
    
    var checkSheet: some View {
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

struct CategoryButton: View {
    @Binding var currentCategory: Category?
    let category: Category?
    
    var body: some View {
        Button(action: {
            currentCategory = category
        }) {
            Text(category?.icon ?? "😊")
                .padding()
                .background(Circle().fill(.green.opacity(
                    currentCategory == category ? 1 : 0.5)
                ))
        }
    }
}
