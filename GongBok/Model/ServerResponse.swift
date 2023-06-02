//
//  ServerAuthData.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/01.
//

import Foundation

struct ServerAuthDataResponse: Codable {
    var role: String?
    var accessToken: String
    var refreshToken: String
}


struct UserPersonalDataReponse: Codable {
    var resultCode: String
    var result: UserInfo
}
