//
//  WelcomeView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-04-02.
//

import SwiftUI

struct WelcomeView: View {
    
    @State private var selectedTab = 0
    let icons = ["list.clipboard", "flag.checkered", "calendar"]
    
    @State var isLoggedIn = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                TabView(selection: $selectedTab) {
                    Slide(color: .blue, tilte: planStr)
                        .tag(0)
                    Slide(color: .green, tilte: doStr)
                        .tag(1)
                    Slide(color: .purple, tilte: checkStr)
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(maxHeight: 550)
                
                
                if selectedTab == 2 {
                    Button(action: {
                        UserDefaults.standard.set(true, forKey: "kIsLoggedIn")
                        isLoggedIn = true
                        
                    }) {
                        Text(goStr)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .padding()
                            .background(Capsule(style: .continuous).fill(.green))
                    }
                    .navigationDestination(isPresented: $isLoggedIn) {
                        MenuView()
                    }
                } else {
                    Text(goStr)
                        .foregroundColor(.clear)
                        .fontWeight(.heavy)
                        .padding()
                        .background(Capsule(style: .continuous).fill(.clear))
                }
            }
            .background(
                Image(systemName: icons[selectedTab])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 400)
                    .offset(x: 70, y: -200)
                    .foregroundColor(.gray.opacity(0.6))
                    .animation(.easeInOut, value: selectedTab)
            )
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
        VStack {
            Text(tilte)
                .foregroundColor(color)
                .font(.system(size: 50, weight: .bold))
        }
        .frame(width: 300, height: 400)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 10)
        
    }
}
