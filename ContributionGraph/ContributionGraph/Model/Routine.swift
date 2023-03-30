//
//  Routine.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-04.
//

import Foundation

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
