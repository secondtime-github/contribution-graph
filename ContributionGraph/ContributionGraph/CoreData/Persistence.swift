//
//  Persistence.swift
//  Practice4CoreData
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
            let diary = DiaryEntity(context: viewContext)
            diary.date = "2023-03-28"
            
            let routine = RoutineEntity(context: viewContext)
            routine.id = "1234\(i)"
            routine.name = "AAA\(i)"
            routine.icon = "🍸"
            routine.category = "Finance"
            routine.content = "description"
            routine.isArchived = false
            
            let task = TaskEntity(context: viewContext)
            //task.id = UUID()
            
            task.oneDay = diary
            task.category = routine
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
