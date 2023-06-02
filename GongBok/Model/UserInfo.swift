//
//  UserInfo.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct UserInfo: Codable {
    var nickname: String
    var birthYear: Int
    
    static let testData = UserInfo(nickname: "닉네임", birthYear: 2000)
}
