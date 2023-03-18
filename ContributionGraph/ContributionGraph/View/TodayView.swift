//
//  TodayView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import SwiftUI
import CoreData

struct TodayView: View {
    
    @State private var currentDate = Date()
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var diaries: Date?
    
    func fetchDiaries(forDate date: Date) {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        
        let predicate = NSPredicate(format: "date >= %@ AND date < %@", startDate as NSDate, endDate as NSDate)
        let fetchRequest: NSFetchRequest<Diary> = Diary.fetchRequest()
        fetchRequest.predicate = predicate
        
        do {
            let diaries = try self.viewContext.fetch(fetchRequest)
            self.diaries = diaries.first?.date
        } catch let error as NSError {
            print("Failed to fetch diaries: \(error.localizedDescription)")
        }
    }

    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text(getContent(for: diaries ?? Date()))
                
                //ContentView()
            }
            .navigationTitle(
                Text(dateFormatter.string(from: currentDate))
                    .font(.headline)
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                        fetchDiaries(forDate: currentDate)
                    }) {
                        Image(systemName: "arrow.left")
                    },
                trailing:
                    HStack {
                        Button(action: {
                            currentDate = Date()
                            fetchDiaries(forDate: currentDate)
                        }) {
                            Text("Today")
                        }
                        Button(action: {
                            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
                            fetchDiaries(forDate: currentDate)
                        }) {
                            Image(systemName: "arrow.right")
                        }
                    }
            )
        }
    }
    
    func getContent(for date: Date) -> String {
        return "Here is \(dateFormatter.string(from: date))"
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
            .environment(
                \.managedObjectContext,
                 PersistenceController.preview.container.viewContext
            )
            .environmentObject(RoutineListViewModel())
    }
}
