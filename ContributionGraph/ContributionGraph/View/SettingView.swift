//
//  SettingView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-04-02.
//

import SwiftUI

struct SettingView: View {
    
    let logout: () -> Void
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Link(destination: URL(string: "https://apple.com")!) {
                        Label("Website", systemImage: "link")
                    }
                }
                
                Button(action: logout) {
                    Label(logOutStr, systemImage: "xmark.square")
                }
            }
            .foregroundColor(.primary)
            .navigationTitle(settingStr)
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(logout: {})
    }
}
