//
//  BlankQuiz1ViewModel.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/19.
//

import Foundation

class BlankQuiz1ViewModel: ObservableObject {
    
    @Published var inputStr = ""
    @Published private var quizData: BlankQuiz1ModelViewModel?
    @Published private(set) var state: BlankQuiz1State = .input
    @Published var focusState = true
    
    var quizString: String {
        quizData?.blankString ?? ""
    }
    
    var answer: String {
        quizData?.answer ?? ""
    }
    
    var hasInput: Bool {
        inputStr.count > 0
    }
    
    func getBlankQuiz1Data() {
        //APi요청을 통해 퀴즈 데이터를 가져옴
        
        let test = BlankQuiz1Model(blankString: "파이썬은 _을 할 수 있는 프로그램이다.", answer: "코딩")
        quizData = BlankQuiz1ModelViewModel(blankQuiz1: test)
    }
    
    func submit() {
        if let ans = quizData?.answer {
            let vStr = inputStr.trimmingCharacters(in: .whitespaces)
            state = ans == vStr ? .correct : .wrong
        } else {
            getBlankQuiz1Data()
        }
    }
    
    func reset() {
        inputStr = ""
        focusState = true
        state = .input
    }
}

enum BlankQuiz1State {
    case input, wrong, correct
}

class BlankQuiz1ModelViewModel {
    var blankQuiz1: BlankQuiz1Model
    
    init(blankQuiz1: BlankQuiz1Model) {
        self.blankQuiz1 = blankQuiz1
    }
    
    var blankString: String {
        blankQuiz1.blankString
    }
    
    var answer: String {
        blankQuiz1.answer
    }
}
