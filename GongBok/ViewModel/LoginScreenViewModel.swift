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
        let userInfo = UserInfo(nickname: self.nickName, birthYear: self.birthYear)
        
        guard let accessToken = FileController.shared.getData(.authorizationData, type: ServerAuthData.self)?.accessToken else {
            print("토큰없음")
            return;
        }
        
        guard let sendData = try? JSONEncoder().encode(userInfo) else {
            return;
        }
        
        let url = APIUrl.personalDataSave
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.patch.rawValue
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = sendData
        
        AF.request(request).responseData { response in
            switch response.result {
            case .success(_):
                completion?()
                self.popTopView()
            case .failure(let error):
                print("Error in Patch: \(error)")
            }
        }
    }
}

