//
//  CalendarView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-08.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var routineListVM: RoutineListViewModel
    
    let year: Int
    let month: Int
    
    let daysInMonth: Int
    let firstDayOfMonth: Int
    
    init(year: Int, month: Int) {
        self.year = year
        self.month = month
        
        // 构建一个包含指定年份和月份的日期组件对象
        let dateComponents = DateComponents(year: year, month: month)

        // 使用当前日历获取一个Date对象，如果日期组件无效，则抛出一个致命错误
        let calendar = Calendar.current
        guard let date = calendar.date(from: dateComponents) else {
            fatalError("Invalid date components")
        }

        // 使用当前日历获取该月份中所有的日期范围，如果获取失败，则抛出一个致命错误
        let range = calendar.range(of: .day, in: .month, for: date)!
        daysInMonth = range.count

        // 使用当前日历获取该月份的第一天是星期几，星期日为1，星期六为7
        let weekdayComponents = calendar.dateComponents([.weekday], from: date)
        firstDayOfMonth = weekdayComponents.weekday! - calendar.firstWeekday
    }
    
    func formatDate(year: Int, month: Int, day: Int) -> String? {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let date = calendar.date(from: dateComponents)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date!)
        
        return dateString
    }
    
    var body: some View {
        VStack {
            //Text("\(year)年\(month)月").font(.title)
            
            LazyVGrid(
                columns: Array(repeating: GridItem(), count: 7),
                spacing: 10
            ) {
                ForEach(0..<firstDayOfMonth, id: \.self) { _ in
                    Text("")
                }
                
                ForEach(1...daysInMonth, id: \.self) { day in
                    
                    if let key = formatDate(year: year, month: month, day: day) {
                        
                        if routineListVM.days[key] != nil {
                            Block()
                        } else {
                            Block(value: 0)
                        }
                    }
                    
                }
            }
        }
        .frame(maxWidth: 300)
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(year: 2023, month: 3)
            .environmentObject(RoutineListViewModel())
    }
}
