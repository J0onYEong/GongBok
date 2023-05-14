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

class LoginScreenViewModel: ObservableObject {
    @Published var viewState: [LoginScreenViewState] = []
    
    var dismiss: DismissAction?

    /// 루트뷰를 제외한 모든 뷰를 pop하고 해당 뷰를 삽입
    func presentScreen(destination: LoginScreenViewState) {
        viewState = [destination]
    }
    
    /// 해당뷰를 Stack에 추가
    func addToStack(destination: LoginScreenViewState) {
        viewState.append(destination)
    }
    
    func clearStack() {
        viewState = []
    }
}

extension LoginScreenViewModel {
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



