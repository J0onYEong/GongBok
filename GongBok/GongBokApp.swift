//
//  SocialLoginTestAppApp.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/05.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct GongBokApp: App {
    @ObservedObject var authentication = AuthenticationObject()
    
    var body: some Scene {
        WindowGroup {
            MainScene()
                .environmentObject(authentication)
        }
    }
}
