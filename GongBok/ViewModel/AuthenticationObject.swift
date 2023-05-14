//
//  CheckingViewViewModel.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import Foundation
import KakaoSDKCommon
import KakaoSDKUser // userApi
import KakaoSDKAuth // authApi

final class AuthenticationObject: ObservableObject {
    
    @Published var presentLoginModal: Bool = false
    
    private(set) var localToken: String?
    
    private var tokenCheckingState: TokenCheckingState = .checking {
        didSet {
            if(tokenCheckingState == .unavailable) {
                presentLoginModal = true
            }
        }
    }
    
    func checkLocalToken() {
        if let lt = FileController.shared.getData(.localToken, type: String.self) {
            localToken = lt
            tokenCheckingState = .available
        } else {
            tokenCheckingState = .unavailable
        }
    }
}
extension AuthenticationObject {
    enum TokenCheckingState {
        case checking, available, unavailable
    }
}
