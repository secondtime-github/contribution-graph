//
//  Category.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case study = "study"
    case work = "work"
    case finance = "finance"
    case health = "health"
    case relationships = "relationships"
    case entertainment = "entertainment"
    case hobbies = "hobbies"
    
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
    
    var index: Int {
        switch self {
        case .study: return 1
        case .work: return 2
        case .finance: return 3
        case .health: return 4
        case .relationships: return 5
        case .entertainment: return 6
        case .hobbies: return 7
        }
    }
}
