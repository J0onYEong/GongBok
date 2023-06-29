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
    
    private(set) var localAuthData: ServerAuthDataViewModel?
    
    @Published private(set) var tokenCheckingState: TokenCheckingState = .checking
    
    func checkLocalAuthData() {
        objectWillChange.send()
        if let authData = FileController.shared.getData(.authorizationData, type: ServerAuth.self) {
            //내부저장소에 저장된 데이터 토큰을 건네받음
            localAuthData = ServerAuthDataViewModel(accessToken: authData.accessToken)
            tokenCheckingState = .available
        } else {
            tokenCheckingState = .unavailable
        }
    }
    
    func setLocalAuthData(_ data: ServerAuth) {
        objectWillChange.send()
        localAuthData = ServerAuthDataViewModel(accessToken: data.accessToken)
        FileController.shared.saveData(.authorizationData, data)
    }
    
    func setViewState(_ state: TokenCheckingState) {
        objectWillChange.send()
        tokenCheckingState = state
    }
}

enum TokenCheckingState {
    case checking, available, unavailable
}

struct ServerAuthDataViewModel {
    var accessToken: String
}

