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
        VStack {
            Text(settingStr)
                .font(.system(.title))
            
            Button(action: logout) {
                Text(logOutStr)
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
        SettingView(logout: {})
    }
}
