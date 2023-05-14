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
        Text("토큰존재 확인전 최초 뷰입니다.")
            .onAppear {
                authentication.checkLocalToken()
            }
            .fullScreenCover(isPresented: $authentication.presentLoginModal) {
                LoginScreen()
            }
            .onTapGesture {
                //Test
                FileController.shared.deleteData(.localToken)
            }
            
    }
}

struct FirstCheckingScreen_Previews: PreviewProvider {
    static var previews: some View {
        FirstCheckingScreen()
            .environmentObject(AuthenticationObject())
    }
}
