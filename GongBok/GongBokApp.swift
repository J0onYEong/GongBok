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
    
    init() {
        KakaoSDK.initSDK(appKey: Bundle.main.apiKey!)
    }
    
    var body: some Scene {
        WindowGroup {
            MainScene()
                .environmentObject(authentication)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
