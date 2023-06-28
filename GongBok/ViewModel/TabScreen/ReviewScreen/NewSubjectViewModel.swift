//
//  NewSubjectViewModel.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/28.
//

import SwiftUI

class NSViewModel: ObservableObject {
    @Published var subjectName = "" {
        didSet {
            if subjectName.count > maxLength {
                subjectName = oldValue
                showErrorMessage(.maxLen)
            }
            else {
                isShowingError = false
            }
        }
    }
    
    @Published private(set) var isShowingError = false
    @Published private(set) var errorMessage = ""
    
    
    private let maxLenErrorMessage = "과목의 이름은 최대 10글자입니다!!"
    private let validationErrorMessage = "이미 존재하는 과목명 입니다!!"
    
    private let maxLength: Int = 10
    
    func showErrorMessage(_ type: ErrorType) {
        errorMessage = type == .maxLen ? maxLenErrorMessage : validationErrorMessage
        
        isShowingError = true;
    }
 }

extension NSViewModel {
    enum ErrorType {
        case maxLen, validation
    }
}
