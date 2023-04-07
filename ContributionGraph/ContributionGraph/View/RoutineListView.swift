//
//  RoutineListView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import SwiftUI
import CoreData

struct RoutineListView: View {
    
    @EnvironmentObject var vm: RoutineListViewModel
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RoutineEntity.name, ascending: true)],
        animation: .default
    )
    private var routineEntities: FetchedResults<RoutineEntity>
    
    @State private var isShown = false
    @State var selectedRoutineEntity: RoutineEntity? = nil
    
    var body: some View {
        NavigationView {
            List {
                Section{
                    ForEach(routineEntities.filter { !$0.isArchived } ) { routineEntity in
                        HStack {
                            Text(routineEntity.icon!)
                            Text(routineEntity.name!)
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                HStack {
                                    Button {
                                        vm.archive(routineEntity)
                                    } label: {
                                        Label("Archive", systemImage: "archivebox")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        selectedRoutineEntity = routineEntity
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
                
                Section(archivedStr) {
                    ForEach(routineEntities.filter { $0.isArchived } ) { routineEntity in
                        HStack {
                            Text(routineEntity.icon!)
                            Text(routineEntity.name!)
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                HStack {
                                    Button {
                                        vm.delete(routineEntity)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        vm.archive(routineEntity)
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
            .navigationTitle(Text(routineListStr))
            .navigationBarTitleDisplayMode(.large)
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
                    selectedRoutineEntity: $selectedRoutineEntity)
            }
        }
    }
    
    func addItem() {
        selectedRoutineEntity = nil
        isShown.toggle()
    }
}

struct RoutineListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListView()
            .environmentObject(RoutineListViewModel(context: PersistenceController.preview.container.viewContext))
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
    }
}
