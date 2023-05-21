//
//  ReviewScreenController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation

enum ReviewScreenViewState: Hashable {
    case weekNumber(name: String)
    case quiz(id: String)
}

struct TestQuizData {
    var reviewText: String
}



class ReviewScreenController: NavigationController<ReviewScreenViewState> {
    var testData1 = ["파이썬", "스트링", "피그마"]
    var testData2: [String : [String]] = [:]
    var testData3: [String:TestQuizData] = [:]
    
    func getSubject() -> [String] {
        return testData1
    }
    
    func getWeekNumList(sub: String) -> [String]? {
        return testData2[sub]
    }
    
    func getQuizData(id: String) -> TestQuizData? {
        return testData3[id]
    }
}
