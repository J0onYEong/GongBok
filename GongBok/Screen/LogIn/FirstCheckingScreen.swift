//
//  FirstCheckingView.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct FirstCheckingScreen: View {
    @EnvironmentObject var authentication: AuthenticationObject
    
    var body: some View {
        Group {
            switch authentication.tokenCheckingState {
                case .checking:
                    Text("")
                case .available:
                    TabScreen()
                        .transition(.slide)
                case .unavailable:
                    LoginScreen()
                        .transition(.slide)
            }
        }
        .onAppear {
            authentication.checkLocalAuthData()
        }
        .animation(.easeInOut, value: authentication.tokenCheckingState)
    }
}

struct FirstCheckingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstCheckingScreen()
            .environmentObject(AuthenticationObject())
    }
}
