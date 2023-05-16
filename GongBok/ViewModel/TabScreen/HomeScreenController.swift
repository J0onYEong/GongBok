//
//  HomeScreenController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import Foundation

struct TestUserData {
    var level: Int
    var experience: Int
    var starLog = [500, 300, 300, 300]
    var starSum: Int {
        var sum = 0;
        starLog.forEach {
            sum+=$0
        }
        return sum
    }
}

class HomeScreenController: ObservableObject {
    
    @Published private(set) var testData = TestUserData(level: 2, experience: 500)

    
    
    
}
