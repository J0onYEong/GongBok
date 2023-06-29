//
//  Subjects.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/30.
//

import Foundation

struct Subject: Decodable {
    var id: Int
    var subjectName: String
}

typealias Subjects = [Subject]
