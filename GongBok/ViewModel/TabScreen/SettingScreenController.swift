//
//  SettingScreenController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI
import Alamofire

enum SettingScreenViewState {
    case resign, editProfile, editGongBok
}


class SettingScreenController: NavigationController<SettingScreenViewState> {
    
    @Published var nickName = ""
    @Published var birthYear = 2000
    
    func getUserInfo() {
        HTTPRequest.shared.requestWithAccessToken(url: .personalData, method: .get, reponseType: UserPersonalDataReponse.self, sendData: nil) { [weak self] result in
            switch result {
            case .success(let data):
                self?.objectWillChange.send()
                self?.nickName = data.result.nickname
                self?.birthYear = data.result.birthYear
            case .failure(let error):
                print("설정페이지 유저정보요청 에러: \(error.rawValue)")
            }
        }
    }
    
    
    func updateUserPersonalData() {
        HTTPRequest.shared.requestWithAccessToken(url: .personalData, method: .patch, reponseType: NoReponseBody.self, sendData: UserInfo(nickname: self.nickName, birthYear: self.birthYear)) { result in
            switch result {
            case .success(_):
                print("정보수정 성공")
            case .failure(let error):
                print("설정페이지 유저정보 업데이트 에러: \(error.rawValue)")
            }
        }
    }
    
    func withdrawAccountRequest(completion: (() -> ())?) {
        HTTPRequest.shared.requestWithAccessToken(url: .personalData, method: .delete, reponseType: NoReponseBody.self, sendData: nil) { result in
            switch result {
            case .success(_):
                FileController.shared.deleteData(.authorizationData)
                completion?()
                print("회원 탈퇴 성공")
            case .failure(let error):
                print("회원 탈퇴 에러: \(error.rawValue)")
            }
        }
    }
    
}
