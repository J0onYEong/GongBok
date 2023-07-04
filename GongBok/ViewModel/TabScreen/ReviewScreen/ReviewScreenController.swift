//
//  ReviewScreenController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation



enum ReviewScreenViewState: Hashable {
    case weekNumber(id: Int)
    case quiz(id: String)
    case quizDetail(id: String)
}

class ReviewScreenController: NavigationController<ReviewScreenViewState> {
    //ReviewScreen
    @Published private(set) var subjects: [SubjectViewModel] = []
    @Published var isShowingNewSubjectView = false
    @Published private(set) var subjectLoadingState: LoadingState = .loading
    
    private var weekLoadingManager = WeekLoadingManager()
    
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



// MARK: - common
extension ReviewScreenController {
    enum LoadingState {
        case loading
        case compelete
    }
    
    actor WeekLoadingManager {
        private(set) var count = 0
        
        func increaseCount(_ target: Int, completion: ()->()) {
            count += 1
            if count >= target {
                completion()
            }
        }
    }
}

// MARK: - 과목
extension ReviewScreenController {
    
    func getSubjects() {
        HTTPRequest.shared.requestWithAccessToken(urlStr: APIUrl.getSubjects, method: .get, reponseType: Subjects.self, sendData: nil) { result in
            switch result {
            case .success(let data):
                guard let unw = data else { return; }
                
                self.subjects = unw.map({
                    SubjectViewModel(name: $0.subjectName, id: $0.id)
                })
                
                self.getWeekList()
                
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }
    
    func subjectNameValidation(name: String) -> Bool {
        return subjects.filter({
            $0.name == name
        }).isEmpty
    }
    
    func addSubject(name: String) {
        subjectLoadingState = .loading
        let sendData = AddSubjectRequest(subjectName: name)
        HTTPRequest.shared.requestWithAccessToken(urlStr: APIUrl.addSubject, method: .post, reponseType: NoReponseBody.self, sendData: sendData) { result in
            switch result {
            case .success( _ ):
                self.getSubjects()
            case .failure(let failure):
                print(failure.rawValue)
            }
        }
    }
}

// MARK: - 차시
extension ReviewScreenController {
    //비동기 요청
    func getWeekList() {
        if subjects.isEmpty { return; }
        
        let operation = BlockOperation()
        
        let size = subjects.count
        
        subjects.forEach { subject in
            operation.addExecutionBlock {
                subject.getWeekList {
                    //actor
                    Task {
                        await self.weekLoadingManager.increaseCount(size) {
                            Task { @MainActor in
                                self.subjectLoadingState = .compelete
                            }
                        }
                    }
                }
            }
        }
        
        operation.start()
    }
    
    func addWeekNumElement(id: Int) {
        objectWillChange.send()
        guard let sub = subjects[id] else { fatalError("과목이 존재하지 않습니다.") }
        
        sub.weekList.append(sub.weekList.count+1)
        
        HTTPRequest.shared.requestWithAccessToken(urlStr: APIUrl.subjectWeek(to: id), method: .post, reponseType: NoReponseBody.self, sendData: nil) { result in
            switch(result) {
            case .success(_):
                print("차시추가 성공")
            case.failure(let error):
                print("차시추가 실패, ", error.rawValue)
            }
        }
    }
    
    //차시 삭제
    func deleteWeekNumberElement(sub: String) {
        
    }
}

// MARK: - 퀴즈

