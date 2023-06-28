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
    case quizDetail(id: String)
}

class ReviewScreenController: NavigationController<ReviewScreenViewState> {
    //ReviewScreen
    @Published private(set) var subject: [String] = []
    @Published var isShowingNewSubjectView = false
    
    //WeekNumberScreen
    @Published private(set) var weekNumber: [String] = []
    
    let quizTypes = [
        "choice" : "객관식 개념 퀴즈",
        "descriptive" : "서술형 요약 퀴즈",
        "short" : "단답형 개념 퀴즈",
        "blank" : "빈칸 퀴즈",
        "yesNo" : "참/거짓 개념 퀴즈",
        "reference" : "관련 자료",
        "review" : "틀린 문제 정리",
    ]
    
}

struct ReviewScreenTestData {
    static var subjects: [String] = []
    static var weekNumber: [String : [String]] = [:]
}

// MARK: - 과목
extension ReviewScreenController {
    func getSubject() {
        subject = ReviewScreenTestData.subjects
    }
    
    func subjectNameValidation(name: String) -> Bool {
        return !subject.contains(name)
    }
    
    func addSubject(name: String) {
        subject.append(name)
    }
}

// MARK: - 차시
extension ReviewScreenController {
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
    
    //차시 삭제
    func deleteWeekNumberElement(sub: String) {
        
    }
}

// MARK: - 퀴즈

