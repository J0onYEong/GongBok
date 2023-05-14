//
//  GlobalState.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/12.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class GlobalState: ObservableObject {
    @Published private(set) var oauthToken: OAuthToken?
    
    func setToken(_ token: OAuthToken) {
        oauthToken = token
    }
}
