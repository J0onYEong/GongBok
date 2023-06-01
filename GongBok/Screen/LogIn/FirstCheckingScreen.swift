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
                    Text("알아보는 중....")
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
    }
}

struct FirstCheckingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstCheckingScreen()
            .environmentObject(AuthenticationObject())
    }
}
