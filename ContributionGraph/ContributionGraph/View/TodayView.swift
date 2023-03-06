//
//  TodayView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-06.
//

import SwiftUI

struct TodayView: View {
    
    @State private var currentDate = Date()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(getContent(for: currentDate))
                
                ContentView()
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
                    }) {
                        Image(systemName: "arrow.left")
                    },
                trailing:
                    HStack {
                        Button(action: {
                            currentDate = Date()
                        }) {
                            Text("Today")
                        }
                        Button(action: {
                            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
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
    }
}
