//
//  TodayViewModel.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-29.
//

import Foundation
import CoreData

class TodayViewModel: ObservableObject {
    
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchTasks()
    }
    
    @Published var currentDate: Date = Date() {
        didSet { fetchTasks() }
    }
    
    @Published var tasks = [Routine : Bool]()
    
    /// show days map
    func fetchTasks() {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "year == %d AND month == %d AND day == %d AND category.isArchived == false", year, month, day)
        request.predicate = predicate
        
        let keyPath = #keyPath(TaskEntity.category.name)
        let sortDescriptor = NSSortDescriptor(key: keyPath, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let taskEntities = try viewContext.fetch(request)
            
            tasks.removeAll()
            
            for taskEntity in taskEntities {
                if let routineEntity = taskEntity.category {
                    let routine = Routine(entity: routineEntity)
                    tasks[routine] = taskEntity.isDone
                }
            }
        } catch {
            print("Error fetching tasks: \(error.localizedDescription)")
        }
    }
    
    func toggleTask(with routine: Routine) {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        let predicate = NSPredicate(
            format: "category.name == %@ AND year == %d AND month == %d AND day == %d",
            routine.name, year, month, day)
        request.predicate = predicate
        
        do {
            let taskEntities = try viewContext.fetch(request)
            
            if let taskEntity = taskEntities.first {
                taskEntity.isDone.toggle()
            } else {
                let taskEntity = TaskEntity(context: viewContext)
                taskEntity.isDone = true
                taskEntity.year = Int16(year)
                taskEntity.month = Int16(month)
                taskEntity.day = Int16(day)
                
                taskEntity.category = fetchRoutineEntity(by: routine)!
            }
            
            try viewContext.save()
        } catch {
            print("Error toggling task: \(error.localizedDescription)")
        }
        
        fetchTasks()
    }
    
    func fetchRoutineEntity(by routine: Routine) -> RoutineEntity? {
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", routine.name)
        
        if let results = try? viewContext.fetch(request) {
            return results.first
        } else {
            return nil
        }
    }
}
