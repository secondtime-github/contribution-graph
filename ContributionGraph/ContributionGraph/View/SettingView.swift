//
//  SettingView.swift
//  ContributionGraph
//
//  Created by TEKI HOU on 2023-04-02.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Setting")
                .font(.system(.title))
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "kIsLoggedIn")
                
                self.presentation.wrappedValue.dismiss()
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill().opacity(0.8))
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
