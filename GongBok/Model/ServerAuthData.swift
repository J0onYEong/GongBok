//
//  ServerAuthData.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/01.
//

import Foundation

struct ServerAuthData: Codable {
    var role: String
    var accessToken: String
    var refreshToken: String
}


struct PersonalDataReponse: Codable {
    var resultCode: String
    var result: UserInfo
}
