//
//  RoutineListView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import SwiftUI

struct RoutineListView: View {
    
    @EnvironmentObject var routineListVM: RoutineListViewModel
    
    @State var isShown = false
    
    var body: some View {
        NavigationStack {
            List {
                Section{
                    ForEach(routineListVM.items.filter({!$0.isArchived})) { item in
                        HStack {
                            Text(item.icon)
                            Text(item.name)
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                Button {
                                    routineListVM.archiveItem(item)
                                } label: {
                                    Label("Archive", systemImage: "archivebox")
                                }
                                .tint(.red)
                            }
                    }
                }
                .fontWeight(.bold)
                
                Section("Archived") {
                    ForEach(routineListVM.items.filter({$0.isArchived})) { item in
                        HStack {
                            Text(item.icon)
                            Text(item.name)
                        }
                        .swipeActions(
                            edge: .trailing,
                            allowsFullSwipe: true) {
                                HStack {
                                    Button {
                                        routineListVM.deleteItem(item)
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    Button {
                                        routineListVM.archiveItem(item)
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
                CreateNewItemView(isShown: $isShown)
            }
        }
    }
    
    func addItem() -> Void {
        isShown.toggle()
        
//        let newItem = RoutineItem(name: "new one", imageName: "", category: .activity)
//        routineListVM.items.append(newItem)
    }
}

struct RoutineListView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineListView()
            .environmentObject(RoutineListViewModel())
    }
}
