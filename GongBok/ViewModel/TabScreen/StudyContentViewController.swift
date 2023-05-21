//
//  StudyContentViewController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation

enum AlignmentState {
    case hStack, vStack
}

class StudyContentViewController: ObservableObject {
    
    @Published var alignmentState: AlignmentState = .hStack
    
    func submit() {
        
        //제출 배앰~
        
    }
}
