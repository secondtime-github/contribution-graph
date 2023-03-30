//
//  GraphViewModel.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-29.
//

import Foundation
import CoreData

class GraphViewModel: ObservableObject {
    
    @Published var currentDate: Date = Date() {
        didSet { fetchCounts() }
    }
    
    @Published var counts = [Int : Int]()
    
    private let viewContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchCounts()
    }
    
    func fetchCounts() {
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate)
        
        let year = components.year!
        let month = components.month!
        
        
        let request = NSFetchRequest<NSDictionary>(entityName: "TaskEntity")

        let predicate = NSPredicate(format: "year == %d AND month == %d AND isDone == true", year, month)
        request.predicate = predicate
        
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "count"
        expressionDescription.expression = NSExpression(forFunction: "count:", arguments: [NSExpression(forKeyPath: \TaskEntity.day)])
        expressionDescription.expressionResultType = .integer32AttributeType
        
        request.propertiesToFetch = ["day", expressionDescription]
        request.propertiesToGroupBy = ["day"]
        request.resultType = .dictionaryResultType

        do {
            counts.removeAll()
            
            let results = try viewContext.fetch(request)
            for result in results {
                let day = result["day"] as! Int
                let count = result["count"] as! Int
                counts[day] = count
            }
            
        } catch {
            print("Error fetching data: \(error)")
        }


    }
}
