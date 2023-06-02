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
        guard let accessToken = FileController.shared.getData(.authorizationData, type: ServerAuthData.self)?.accessToken else {
            print("토큰없음")
            return;
        }
        let url = APIUrl.personalDataSave
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        AF.request(request).responseDecodable(of: PersonalDataReponse.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                print("세팅페이지: 장보가져오기 성공")
                self?.objectWillChange.send()
                self?.nickName = data.result.nickname
                self?.birthYear = data.result.birthYear
            case .failure(let error):
                print("멤버정보가져오기: \(error)")
            }
        }
    }
    
    func withdrawAccountRequest(completion: (() -> ())?) {
        
        guard let accessToken = FileController.shared.getData(.authorizationData, type: ServerAuthData.self)?.accessToken else {
            print("토큰없음")
            return;
        }
        let url = APIUrl.personalDataSave
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        AF.request(request).response { response in
            switch response.result {
            case .success(_):
                print("성공")
                FileController.shared.deleteData(.authorizationData)
                completion?()
            case .failure(let error):
                print("회원탈퇴: \(error)")
            }
        }
    }
    
}
