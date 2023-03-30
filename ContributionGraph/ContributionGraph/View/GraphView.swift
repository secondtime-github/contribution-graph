//
//  GraphView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct GraphView: View {
    
    @EnvironmentObject var vm: GraphViewModel
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    vm.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: vm.currentDate)!
                }) {
                    Image(systemName: "arrow.left")
                }
                
                Text(dateFormatter.string(from: vm.currentDate))
                
                Button(action: {
                    vm.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: vm.currentDate)!
                }) {
                    Image(systemName: "arrow.right")
                }
            }
            
            CalendarView(year: Calendar.current.component(.year, from: vm.currentDate),
                         month: Calendar.current.component(.month, from: vm.currentDate))
            
            Spacer()
        }
        .onAppear {
            vm.fetchCounts()
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
            .environmentObject(GraphViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
