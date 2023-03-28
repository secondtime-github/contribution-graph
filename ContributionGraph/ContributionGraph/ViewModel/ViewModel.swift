//
//  RoutineListViewModel.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import Foundation
import CoreData

class ViewModel: ObservableObject {
    
    // 习惯清单
    @Published var items: [RoutineItem] = []
    @Published var days = [String : OneDay]()
    
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        //fetchItems()
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func changeTaskStatus(_ item: RoutineItem, at date: Date) {
        let key = dateFormatter.string(from: date)
        
        if days[key] != nil {
            if days[key]?.tasks[item] != nil {
                days[key]?.tasks[item]?.isDone.toggle()
            } else {
                days[key]?.tasks[item] = Task(category: item, isDone: true)
            }
        } else {
            days[key] = OneDay(date: date, tasks: [RoutineItem : Task]())
            days[key]?.tasks[item] = Task(category: item, isDone: true)
        }
    }
    
    
    // MARK: - Routine List
    /// show routine list
    func fetchItems() {
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        let routineEntities = (try? viewContext.fetch(request)) ?? []
        self.items = routineEntities.map {
            RoutineItem(
                id: UUID(uuidString: $0.id ?? "") ?? UUID(),
                isArchived: $0.isArchived,
                name: $0.name ?? "",
                icon: $0.icon ?? "",
                category: Category(rawValue: $0.category ?? "") ?? .study,
                description: $0.content ?? ""
            )
        }
    }
    
    /// create new routine
    func createItem(_ item: RoutineItem) {
        let newItem = RoutineEntity(context: viewContext)
        newItem.id = item.id.uuidString
        newItem.name = item.name
        newItem.icon = item.icon
        newItem.category = item.category.rawValue
        newItem.content = item.description
        newItem.isArchived = item.isArchived
        
        do {
            try viewContext.save()
            items.append(item)
        } catch {
            
        }
    }
    
    /// delete a routine from list
    func deleteItem(at id: UUID) {
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let results = try viewContext.fetch(request)
            for result in results {
                viewContext.delete(result)
            }
            try viewContext.save()
        } catch {
            print("Error deleting routine item: \(error)")
        }
        
        if let index = items.firstIndex(where: { $0.id == id }) {
            items.remove(at: index)
        }
    }
    
    /// change archive state
    func archiveItem(at id: UUID) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].isArchived.toggle()
        }
        
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try viewContext.fetch(request)
            if let routine = results.first {
                routine.isArchived.toggle()
                
                try viewContext.save()
            }
        } catch {
            print("Error updating routine: \(error.localizedDescription)")
        }
    }
    
    /// update routine info
    func updateItem(at id: UUID, by item: RoutineItem) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].name = item.name
            items[index].icon = item.icon
            items[index].category = item.category
            items[index].description = item.description
        }
        
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try viewContext.fetch(request)
            if let routine = results.first {
                routine.name = item.name
                routine.icon = item.icon
                routine.category = item.category.rawValue
                routine.content = item.description
                
                try viewContext.save()
            }
        } catch {
            print("Error updating routine: \(error.localizedDescription)")
        }
    }
}
