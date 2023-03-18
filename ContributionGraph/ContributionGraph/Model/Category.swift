//
//  Category.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case study = "Study"
    case work = "Work"
    case finance = "Finance"
    case health = "Health"
    case relationships = "Relationships"
    case entertainment = "Entertainment"
    case hobbies = "Hobbies"
}
