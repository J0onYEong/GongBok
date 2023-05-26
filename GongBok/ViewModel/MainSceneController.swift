//
//  MainSceneController.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import Foundation

enum MainSceneViewState {
    case firstChecking, homePage
}

class MainSceneViewModel: ObservableObject {
    @Published var viewState: MainSceneViewState = .homePage
}
