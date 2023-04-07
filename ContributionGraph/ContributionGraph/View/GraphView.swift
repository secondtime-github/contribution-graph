//
//  GraphView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-03.
//

import SwiftUI

struct GraphView: View {
    
    @Environment(\.presentationMode) var presentation
    
    @EnvironmentObject var vm: GraphViewModel
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    @State private var isShown = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        vm.currentDate = Calendar.current.date(byAdding: .month, value: -1, to: vm.currentDate)!
                    }) {
                        Image(systemName: "arrow.left").bold()
                    }
                    
                    Text(dateFormatter.string(from: vm.currentDate))
                        .fontWeight(.heavy)
                        .font(.system(size: 28))
                        .padding(.horizontal)
                    
                    Button(action: {
                        vm.currentDate = Calendar.current.date(byAdding: .month, value: 1, to: vm.currentDate)!
                    }) {
                        Image(systemName: "arrow.right").bold()
                    }
                }
                
                CalendarView(year: Calendar.current.component(.year, from: vm.currentDate),
                             month: Calendar.current.component(.month, from: vm.currentDate))
                
                Spacer()
                
            }
            .navigationBarTitleDisplayMode(.large)// 必须设置为large才能保证sheet正常弹出
            .toolbar {
                Button(action: { isShown.toggle() }) {
                    Image(systemName: "gearshape")
                }
            }
            .sheet(isPresented: $isShown) {
                SettingView {
                    logout()
                }
            }
            .onAppear {
                vm.fetchCounts()
            }
        }
    }
    
    func logout() {
        isShown.toggle()
        UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
        self.presentation.wrappedValue.dismiss()
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView()
            .environmentObject(GraphViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
