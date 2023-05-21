//
//  NavigationController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import Foundation

class NavigationController<ViewState>: ObservableObject {
    @Published var viewState: [ViewState] = []

    /// 루트뷰를 제외한 모든 뷰를 pop하고 해당 뷰를 삽입
    func presentScreen(destination: ViewState) {
        viewState = [destination]
    }
    
    /// 해당뷰를 Stack에 추가
    func addToStack(destination: ViewState) {
        viewState.append(destination)
    }
    
    /// 최상단 뷰를 제거
    func popTopView() {
        let _ = viewState.popLast()
    }
    
    func clearStack() {
        viewState = []
    }
}
