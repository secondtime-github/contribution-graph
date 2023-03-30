//
//  RoutineListViewModel.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import Foundation
import CoreData

class RoutineListViewModel: ObservableObject {
    
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch let error {
            print("Error saving routineEntity: \(error.localizedDescription)")
        }
    }
    
    /// create new routine
    func create(_ newRoutineInfo: Routine) {
        let newRoutineEntity = RoutineEntity(context: viewContext)
        newRoutineEntity.isArchived = newRoutineInfo.isArchived
        
        newRoutineEntity.name = newRoutineInfo.name
        newRoutineEntity.icon = newRoutineInfo.icon
        newRoutineEntity.category = newRoutineInfo.category.rawValue
        newRoutineEntity.content = newRoutineInfo.description
        
        save()
    }
    
    /// delete a routine from list
    func delete(_ routineEntity: RoutineEntity) {
        viewContext.delete(routineEntity)
        save()
    }
    
    /// change archive state
    func archive(_ routineEntity: RoutineEntity) {
        routineEntity.isArchived.toggle()
        save()
    }
    
    /// update routine info
    func update(_ routineEntity: RoutineEntity, by newRoutineInfo: Routine) {
        routineEntity.name = newRoutineInfo.name
        routineEntity.icon = newRoutineInfo.icon
        routineEntity.category = newRoutineInfo.category.rawValue
        routineEntity.content = newRoutineInfo.description
        save()
    }

}
