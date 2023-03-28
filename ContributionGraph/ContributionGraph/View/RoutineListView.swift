//
//  RoutineListView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import SwiftUI
import CoreData

struct RoutineListView: View {
    
    @EnvironmentObject var routineListVM: ViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RoutineEntity.name, ascending: true)],
        animation: .default
    )
    private var items: FetchedResults<RoutineEntity>
    
    @State var isShown = false
    @State var selectedRoutine: RoutineItem? = nil
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    ForEach(items.filter({!$0.isArchived})) { item in
                        HStack {
                            Text(item.icon ?? "")
                            Text(item.name ?? "")
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                HStack {
                                    Button {
                                        routineListVM.archiveItem(at: UUID(uuidString: item.id ?? "") ?? UUID())
                                    } label: {
                                        Label("Archive", systemImage: "archivebox")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        selectedRoutine = RoutineItem(
                                            id: UUID(uuidString: item.id ?? "") ?? UUID(),
                                            isArchived: item.isArchived,
                                            name: item.name ?? "",
                                            icon: item.icon ?? "",
                                            category: Category(rawValue: item.category ?? "") ?? .study,
                                            description: item.content ?? ""
                                        )
                                        isShown.toggle()
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.green)
                                }
                            }
                    }
                }
                .fontWeight(.bold)
                
                Section("Archived") {
                    ForEach(items.filter({$0.isArchived})) { item in
                        HStack {
                            Text(item.icon ?? "")
                            Text(item.name ?? "")
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                HStack {
                                    Button {
                                        routineListVM.deleteItem(at: UUID(uuidString: item.id ?? "") ?? UUID())
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        routineListVM.archiveItem(at: UUID(uuidString: item.id ?? "") ?? UUID())
                                    } label: {
                                        Label("Back", systemImage: "arrow.uturn.up")
                                    }
                                    .tint(.green)
                                }
                            }
                    }
                }
                .foregroundColor(.gray)
                
            }
            .navigationTitle(Text("Routine List"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addItem) {
                        Image(systemName: "plus.app")
                    }
                }
            }
            .sheet(isPresented: $isShown) {
                CreateNewItemView(
                    isShown: $isShown,
                    selectedRoutine: $selectedRoutine)
            }
        }
    }
    
    func addItem() -> Void {
        selectedRoutine = nil
        isShown.toggle()
    }
}

struct RoutineListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListView()
            .environmentObject(ViewModel(context: PersistenceController.preview.container.viewContext))
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
