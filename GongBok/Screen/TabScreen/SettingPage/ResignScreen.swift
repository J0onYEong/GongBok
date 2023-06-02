//
//  ResignScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct ResignScreen: View {
    @EnvironmentObject var controller: SettingScreenController
    @EnvironmentObject var authObj: AuthenticationObject
    @Environment(\.dismiss) var dismiss
    
    @State private var showConfirmationSheet = false
    
    var body: some View {
        ZStack {
            ChildScreenBase(controller: controller) {
                VStack {
                    Text("회원 탈퇴")
                        .font(Font.system(size: 25, weight: .bold))
                        .padding(.bottom, 50)
                    
                    (
                        Text(controller.nickName)
                            .foregroundColor(.gray)
                        +
                        Text(" 님,계정을 삭제하시겠습니까?")
                    )
                    .font(Font.system(size: 25, weight: .bold))
                    .padding(.bottom, 50)
                    
                    (
                        Text("계정 삭제 시 포함되어 있던")
                        +
                        Text(" 친구목록,")
                            .foregroundColor(.red)
                        
                    )
                    
                    (
                        Text("랭크 기록, 캘린더의 복습 기록 등")
                            .foregroundColor(.red)
                        +
                        Text("이")
                    )

                        
                    Text("모두 삭제됩니다.")
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            showConfirmationSheet = true
                        }
                    } label: {
                        
                        Text("탈퇴 완료하기")
                            .font(Font.system(size: 20, weight: .semibold))
                            .frame(height: 20)
                            .padding(.horizontal, 60)
                            .padding(.vertical, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.background)
                                    .shadow(color: .gray, radius: 2, y: 2)
                            )
                            
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, 50)
                }
                .padding(.top, 100)
            }
            .zIndex(0)
            
            ConfirmationModalView(isPresent: $showConfirmationSheet, mainText: "탈퇴를 완료하시겠습니까?") {
                controller.withdrawAccountRequest() {
                    authObj.setViewState(.unavailable)
                }
            } onRefuse: {
                dismiss()
            }
            .zIndex(1)
        }
    }
}

struct ResignScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResignScreen()
            .environmentObject(SettingScreenController())
    }
}
