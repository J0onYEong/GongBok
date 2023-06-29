//
//  ServerAuth.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/30.
//

import Foundation

struct ServerAuth: Codable {
    var role: String?
    var accessToken: String
    var refreshToken: String
}
