//
//  OneDay.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-04.
//

import Foundation

// MARK: - Date

struct OneDay {
    var date: Date
    var tasks: [Routine : Task]
    
    var completion: Int {
        tasks.filter { $0.value.isDone } .count
    }

    init(in dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        self.date = dateFormatter.date(from: dateString)!
        self.tasks = [Routine : Task]()
    }
}



// MARK: - Task

struct Task {
    var isDone: Bool
}

extension TaskEntity {
    func toTask() -> Task {
        Task(isDone: self.isDone)
    }
}



// MARK: - Routine

struct Routine: Hashable {
    
    var isArchived: Bool = false
    
    var name: String
    var icon: String
    var category: Category = .study
    var description: String = ""
    
    init(name: String, icon: String, category: Category, description: String) {
        
        self.isArchived = false
        
        self.name = name
        self.icon = icon
        self.category = category
        self.description = description
    }
    
    init(entity: RoutineEntity) {
        
        self.isArchived = entity.isArchived
        
        self.name = entity.name!
        self.icon = entity.icon!
        self.category = Category(rawValue: entity.category!)!
        self.description = entity.content ?? ""
    }
}
