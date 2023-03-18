//
//  OneDay.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-04.
//

import Foundation

struct OneDay {
    var date: Date
    var tasks: [RoutineItem : Task]
    
    var completion: Int {
        tasks.filter({ $0.value.isDone }).count
    }
}

struct Task: Hashable {
    let id = UUID()
    var category: RoutineItem
    var isDone: Bool
}

struct RoutineItem: Hashable, Identifiable {
    let id = UUID()
    var isArchived: Bool = false
    
    var name: String
    var icon: String
    var category: Category = .study
    var description: String = ""
}

