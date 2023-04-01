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
    
    var icon: String {
        switch self {
        case .study: return "🎓"
        case .work: return "💼"
        case .finance: return "💰"
        case .health: return "❤️"
        case .relationships: return "👥"
        case .entertainment: return "🎯"
        case .hobbies: return "🎨"
        }
    }
    
}
