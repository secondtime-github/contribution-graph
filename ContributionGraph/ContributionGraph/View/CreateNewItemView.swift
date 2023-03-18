//
//  CreateNewItemView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-18.
//

import SwiftUI

struct CreateNewItemView: View {
    
    @EnvironmentObject var routineListVM: RoutineListViewModel
    
    @Binding var isShown: Bool
    
    let emojis = ["😀", "😆", "😂", "🤣", "😊",
                  "😘", "😛", "😜", "🤪", "😝",
                  "🐶", "🐱", "🦁", "🐯", "🐷",
                  "🐙", "🐚", "🍔", "🍕", "🍟",
                  "🍿", "🍩", "🍪", "🎂", "🍰",
                  "🍭", "🍬", "🍮", "🥛", "🍺",
                  "🍹", "🍸", "🍾", "🥤", "🍼"]
    
    @State private var name = ""
    @State private var selectedIcon = "😀"
    @State private var selectedCategory = Category.study
    @State private var description = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Name") {
                    TextField("", text: $name)
                        .onReceive(name.publisher.collect()) {
                            self.name = String($0.prefix(20))
                        }
                }
                
                Section("Icon") {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                        ForEach(emojis, id: \.self) { emoji in
                            Button(action: {
                                selectedIcon = emoji
                            }) {
                                Text(emoji)
                                    .padding(5)
                                    .background(selectedIcon == emoji ? .blue : .gray)
                                    .cornerRadius(5)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                Section("Category") {
                    Picker("", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxHeight: 150)
                }
                
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                        .onReceive(description.publisher.collect()) {
                            self.description = String($0.prefix(100))
                        }
                }
            }
            .navigationTitle("New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let newItem = RoutineItem(
                            name: name,
                            icon: selectedIcon,
                            category: selectedCategory,
                            description: description
                        )
                        routineListVM.items.append(newItem)
                        
                        isShown.toggle()
                    }) {
                        Text("Save")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isShown.toggle()
                    }) {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}

struct CreateNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewItemView(isShown: .constant(true))
            .environmentObject(RoutineListViewModel())
    }
}
