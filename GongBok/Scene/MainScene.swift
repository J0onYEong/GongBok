//
//  MainScene.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct MainScene: View {
    @StateObject var viewModel = MainSceneViewModel()
    
    var body: some View {
        switch (viewModel.viewState) {
            case MainSceneViewState.firstChecking:
                FirstCheckingScreen()
                    .navigationBarBackButtonHidden()
            case MainSceneViewState.homePage:
                TabScreen()
                    .navigationBarBackButtonHidden()
        }
    }
}

struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        MainScene()
            .environmentObject(AuthenticationObject())
    }
}
