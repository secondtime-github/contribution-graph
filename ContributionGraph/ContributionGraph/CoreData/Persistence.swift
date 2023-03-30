//
//  Persistence.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<5 {
            let routine = RoutineEntity(context: viewContext)
            routine.name = "AAA\(i)"
            routine.icon = "🍸"
            routine.category = "Finance"
            routine.content = "description"
            routine.isArchived = false
            
            let task1 = TaskEntity(context: viewContext)
            task1.isDone = false
            task1.year = Int16(2023)
            task1.month = Int16(3)
            task1.day = Int16(29)
            task1.category = routine
            
            let task2 = TaskEntity(context: viewContext)
            task2.isDone = true
            task2.year = Int16(2023)
            task2.month = Int16(3)
            task2.day = Int16(30)
            task2.category = routine
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "ContributionGraph")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
