//
//  RoutineListViewModel.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import Foundation
import CoreData

class RoutineListViewModel: ObservableObject {
    
    // 习惯清单
    @Published var items: [RoutineItem] = []
    
    @Published var days = [String : OneDay]()
    
    func loadItems() {
        let request: NSFetchRequest<RoutineEntity> = RoutineEntity.fetchRequest()
        do {
            let routineEntities = try PersistenceController.shared.container.viewContext.fetch(request)
            
            self.items = routineEntities.map {
                RoutineItem(name: $0.name ?? "", icon: $0.imageName ?? "")
            }
        } catch {
            print("Error fetching tasks")
        }
    }
    
    init() {
        let item1 = RoutineItem(name: "Tech", icon: "😀", category: .study)
        let item2 = RoutineItem(name: "Language", icon: "😀", category: .entertainment)
        let item3 = RoutineItem(name: "Sport", icon: "😀", category: .finance)
        let item4 = RoutineItem(name: "Reading", icon: "😂", category: .health)
        let item5 = RoutineItem(name: "Activity", icon: "😀", category: .relationships)
        
        self.items.append(item1)
        self.items.append(item2)
        self.items.append(item3)
        self.items.append(item4)
        self.items.append(item5)
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
    func archiveItem(_ item: RoutineItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isArchived.toggle()
        }
    }
    
    func deleteItem(_ item: RoutineItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
    
    func createItem(_ item: RoutineItem) {
        items.append(item)
    }
    
    func updateItem(at id: UUID, by item: RoutineItem) {
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].name = item.name
            items[index].icon = item.icon
            items[index].category = item.category
            items[index].description = item.description
        }
    }
}
