//
//  MainScene.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct MainScene: View {
    @StateObject var sceneController = MainSceneController()
    
    var body: some View {
//        NavigationStack(path: $sceneController.viewState) {
//            Text("Main Scene")
//                .navigationDestination(for: MainSceneViewState.self) { state in
//                    switch (state) {
//                    case .firstChecking:
//                        FirstCheckingScreen()
//                            .navigationBarBackButtonHidden()
//                    case .homePage:
//                        TabScreen()
//                            .navigationBarBackButtonHidden()
//                    }
//                }
//        }
//        .onAppear {
//            sceneController.addToStack(destination: .homePage)
//        }
        
        TabScreen()
    }
}

struct MainScene_Previews: PreviewProvider {
    static var previews: some View {
        MainScene()
            .environmentObject(AuthenticationObject())
    }
}
