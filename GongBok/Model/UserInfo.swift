//
//  UserInfo.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct UserInfo: Codable {
    var nickName: String
    var birthYear: Int
    
    static let testData = UserInfo(nickName: "닉네임", birthYear: 2000)
}
