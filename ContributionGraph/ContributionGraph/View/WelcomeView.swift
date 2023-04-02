//
//  WelcomeView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-04-02.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var selectedTab = 0
    
    @State var isLoggedIn = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    Slide(color: .blue, tilte: "Plan")
                        .tag(0)
                    Slide(color: .green, tilte: "Do")
                        .tag(1)
                    Slide(color: .purple, tilte: "Check")
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(maxHeight: 550)
                
                Button(action: {
                    
                    UserDefaults.standard.set(true, forKey: "kIsLoggedIn")
                    isLoggedIn = true
                    
                }) {
                    Text("Go")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .padding()
                        .background(Circle().fill(.green))
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    MenuView()
                }
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: "kIsLoggedIn") {
                isLoggedIn = true
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}

struct Slide: View {
    let color: Color
    let tilte: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.gray.opacity(0.3))
            
            VStack {
                Text(tilte)
                    .foregroundColor(color)
                    .font(.system(size: 50, weight: .bold))
            }
            .padding()
        }
        .frame(width: 300, height: 400)
    }
}
