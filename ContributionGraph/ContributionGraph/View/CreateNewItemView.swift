//
//  CreateNewItemView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-03-18.
//

import SwiftUI

struct CreateNewItemView: View {
    
    @EnvironmentObject var vm: RoutineListViewModel
    
    @Binding var isShown: Bool
    @Binding var selectedRoutineEntity: RoutineEntity?
    
    let emojis = ["😀", "😆", "😂", "🤣", "😊",
                  "😘", "😛", "😜", "🤪", "😝",
                  "🐶", "🐱", "🦁", "🐯", "🐷",
                  "🐙", "🐚", "🍔", "🍕", "🍟",
                  "🍿", "🍩", "🍪", "🎂", "🍰",
                  "🍭", "🍬", "🍮", "🥛", "🍺",
                  "🍹", "🍸", "🍾", "🥤", "🍼"]
    
    @State private var name = ""
    @State private var selectedIcon = "😀"
    @State private var selectedCategory: Category = .study
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
                        ForEach(Category.allCases, id: \.self) { category in
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
            .navigationTitle(selectedRoutineEntity?.name ?? "New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: updateRoutine) {
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
        .onAppear {
            if let selectedRoutineEntity = selectedRoutineEntity {
                let selectedRoutine = Routine(entity: selectedRoutineEntity)
                name = selectedRoutine.name
                selectedIcon = selectedRoutine.icon
                selectedCategory = selectedRoutine.category
                description = selectedRoutine.description
            }
        }
        .scrollDismissesKeyboard(.automatic)
    }
    
    func updateRoutine() {
        let newRoutineInfo = Routine(
            name: name,
            icon: selectedIcon,
            category: selectedCategory,
            description: description
        )
        
        if let selectedRoutineEntity = selectedRoutineEntity {
            vm.update(selectedRoutineEntity, by: newRoutineInfo)
        } else {
            vm.create(newRoutineInfo)
        }
        
        isShown.toggle()
    }
}

struct CreateNewItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewItemView(
            isShown: .constant(true),
            selectedRoutineEntity: .constant(nil))
        .environmentObject(RoutineListViewModel(context: PersistenceController.preview.container.viewContext))
    }
}
