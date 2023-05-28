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

struct ReviewScreenTestData {
    static var subjects = ["파이썬", "피그마", "스프링"]
    static var weekNumber: [String : [String]] = [:]
    static var quizData: [String: TestQuizData] = [:]
}

class ReviewScreenController: NavigationController<ReviewScreenViewState> {
    @Published private(set) var subject: [String] = []
    @Published private(set) var weekNumber: [String] = []
    @Published var quizData = TestQuizData(reviewText: "")
    
    func getSubject() {
        subject = ReviewScreenTestData.subjects
    }
    
    func getWeekNumList(sub: String) {
        if let list = ReviewScreenTestData.weekNumber[sub] {
            weekNumber = list
            return;
        }
        weekNumber = []
        ReviewScreenTestData.weekNumber[sub] = []
    }
    
    func addWeekNumElement(sub: String) {
        let target = String(weekNumber.count+1)
        
        //로컬 리스트 추가
        //로컬 리스트는 subject선택시 각 subject의 데이터로 업데이트됨
        weekNumber.append(target)
        
        //!!!서버반영
        ReviewScreenTestData.weekNumber[sub] = weekNumber
    }
    
    //차시 삭제 + 퀴즈 데이터 삭제
    func deleteWeekNumberElement(sub: String) {
        
    }
    
    func getQuizData(id: String){
        if let data = ReviewScreenTestData.quizData[id] {
            quizData = data
            return;
        }
        quizData = TestQuizData(reviewText: "")
        ReviewScreenTestData.quizData[id] = quizData
    }
    
    //submit눌렀을때 테스트데이터에 반영
    func submitQuizData(id: String) {
        ReviewScreenTestData.quizData[id] = quizData
    }
}

