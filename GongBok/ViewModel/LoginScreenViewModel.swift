//
//  LoginScreenViewModel.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

enum LoginScreenViewState {
    case userInfo
}

class LoginScreenViewModel: NavigationController<LoginScreenViewState> {
    var dismiss: DismissAction?    
    
    func logInRequest() {
        KakaoSocialLogin.shared.logIn { result in
            switch(result) {
            case .success(let token):
                //서버로 토큰을 전달
                
                // !!! 테스트 코드
                var testServerToken = "12345"
                
                FileController.shared.saveData(.localToken, testServerToken)
                
                //최초가입일 경우 유저 정보창으로 이동
                
                
            case .failure(.otherError(let error)):
                print(error)
            }
        }
    }
    
}

