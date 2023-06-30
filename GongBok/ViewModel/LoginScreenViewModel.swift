//
//  LoginScreenViewModel.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI
import Alamofire

enum LoginScreenViewState {
    case webView
    case userInfo
}

class LoginScreenViewModel: NavigationController<LoginScreenViewState> {
    @Published var nickName = ""
    @Published var birthYear = 2000
    
    var inputValidation: Bool {
        nickName.count >= 3
    }
    
    func registerPersonalData(completion: (() -> ())?) {
        HTTPRequest.shared.requestWithAccessToken(urlStr: APIUrl.personalData, method: .patch, reponseType: NoReponseBody.self, sendData: UserInfo(nickname: self.nickName, birthYear: self.birthYear)) { [weak self] result in
            switch result {
            case .success(_):
                completion?()
                self?.popTopView()
            case .failure(let error):
                print("유저정보 최초등록 에러: \(error)")
            }
        }
    }
}

