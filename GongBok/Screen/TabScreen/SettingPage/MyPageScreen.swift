//
//  MyPageScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct MyPageScreen: View {
    @StateObject var controller = SettingScreenController()
    
    @State private var showLogOutModal = false
    
    var body: some View {
        NavigationStack(path: $controller.viewState) {
            ZStack {
                VStack {
                    Text("마이페이지")
                        .font(Font.system(size: 25, weight: .bold))
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            controller.addToStack(destination: .editProfile)
                        } label: {
                            ItemLabelView(color: .settingColor1, text: "내 프로필 수정하기", image: Image("modPen"), alignment: .leading)
                                .frame(height: 60)
                        }
                        .foregroundColor(.black)
                        
                        Button {
                            controller.addToStack(destination: .editGongBok)
                        } label: {
                            ItemLabelView(color: .settingColor1, text: "공복이 설정", image: Image("star2"), alignment: .leading)
                                .frame(height: 60)
                        }
                        .foregroundColor(.black)
                        
                        NotiSettingView()
                        
                        Button {
                            withAnimation {
                                showLogOutModal = true
                            }
                        } label: {
                            ItemLabelView(color: .settingColor1, text: "로그아웃", alignment: .leading)
                                .frame(height: 60)
                        }
                        .foregroundColor(.black)
                        
                        Button {
                            controller.addToStack(destination: .resign)
                        } label: {
                            ItemLabelView(color: .background, text: "회원탈퇴", alignment: .leading)
                                .frame(height: 60)
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 150)
                }
                .navigationDestination(for: SettingScreenViewState.self) { state in
                    switch (state) {
                    case .resign:
                        ResignScreen()
                            .navigationBarBackButtonHidden()
                    case .editGongBok:
                        GongBokEditScreen()
                            .navigationBarBackButtonHidden()
                    case .editProfile:
                        ProfileEditScreen()
                            .navigationBarBackButtonHidden()
                    }
                }
                .onAppear {
                    
                    //유저정보 가져오기
                    controller.getUserInfo()
                    
                    
                }
                .zIndex(0)
                
                ConfirmationModalView(isPresent: $showLogOutModal, mainText: "로그아웃 하시겠습니까?") {
                    //로그아웃 로직
                } onRefuse: {
                    //..
                }
                .zIndex(1)
            }
        }
        .environmentObject(controller)
    }
}


struct MyPageScreen_Previews: PreviewProvider {
    static var previews: some View {
        MyPageScreen()
            .environmentObject(SettingScreenController())
    }
}
