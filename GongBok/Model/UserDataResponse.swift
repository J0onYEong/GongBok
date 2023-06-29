//
//  UserDataResponse.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/30.
//

import Foundation

struct UserDataResponse: Decodable {
    var resultCode: String
    var result: UserInfo
}
