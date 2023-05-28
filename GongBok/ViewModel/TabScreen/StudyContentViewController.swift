//
//  StudyContentViewController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import Foundation

enum StudyContentViewMode {
    case Idle, Input
}

class StudyContentViewController: ObservableObject {
    
    @Published private(set) var mode: StudyContentViewMode = .Idle
    @Published var inputString = ""
    
    func toogleState() {
        if mode == .Idle {
            mode = .Input
        } else {
            mode = .Idle
        }
    }
    
    func submit() {
        
        //제출 배앰~
        
    }
}
