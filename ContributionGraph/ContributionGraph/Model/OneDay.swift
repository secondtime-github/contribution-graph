//
//  OneDay.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-04.
//

import Foundation

struct OneDay {
    var date: Date
    var tasks: [Task]
    
    var completion: Int {
        tasks.map({ $0.isDone }).count
    }
}

struct Task {
    var name: String
    var imageName: String
    var isDone: Bool
    var category: Category
}
