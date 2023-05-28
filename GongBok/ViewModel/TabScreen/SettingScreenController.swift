//
//  SettingScreenController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

enum SettingScreenViewState {
    case resign, editProfile, editGongBok
}


class SettingScreenController: NavigationController<SettingScreenViewState> {
    
    @Published var nickName = ""
    @Published var birthYear = 2000
    
    func getUserInfo() {
        objectWillChange.send()
        let testData = UserInfo.testData
        nickName = testData.nickName
        birthYear = testData.birthYear
    }
    
}
