//
//  GraphView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct GraphView: View {
    
    
    
    @State var currentDate: Date = Date()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    currentDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate)!
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: currentDate))
                
                Button(action: {
                    currentDate = Calendar.current.date(byAdding: .month, value: 1, to: currentDate)!
                }) {
                    Image(systemName: "arrow.right")
                }
            }
            
            CalendarView(year: Calendar.current.component(.year, from: currentDate),
                         month: Calendar.current.component(.month, from: currentDate))
            
            Spacer()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
            .environmentObject(RoutineListViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
