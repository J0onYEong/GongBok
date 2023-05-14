//
//  LoginScreen.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject var viewModel = LoginScreenViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack(path: $viewModel.viewState) {
            GeometryReader { geo in
                VStack {
                    Button {
                        viewModel.logInRequest()
                    } label: {
                        Image("kakao_login_large_wide")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width*0.8)
                    }
                }
                .position(x: geo.size.width/2, y: geo.size.height/2)
            }
                .navigationDestination(for: LoginScreenViewState.self) { state in
                    switch (state) {
                    case .userInfo:
                        UserInformationView(viewModel: viewModel)
                    }
                }
        }
        .onAppear {
            viewModel.dismiss = dismiss
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(AuthenticationObject())
    }
}
