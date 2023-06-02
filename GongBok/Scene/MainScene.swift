//
//  MainScene.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct MainScene: View {
    var body: some View {
        FirstCheckingScreen()
    }
}

struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        MainScene()
            .environmentObject(AuthenticationObject())
    }
}
