//
//  GongBokEditScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct GongBokEditScreen: View {
    @EnvironmentObject var controller: SettingScreenController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ChildScreenBase(controller: controller) {
            
            VStack {
                Text("내 공복이 설정")
                    .font(Font.system(size: 25, weight: .bold))
                Spacer()
                Button {
                    
                    //수정 로직
                    dismiss()
                    
                
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .foregroundColor(.underBar)
                            .frame(height: 50)
                            .shadow(color: .gray, radius: 3, x: 0, y: 4)
                        Text("완료")
                            .foregroundColor(.black)
                    }
                }
                .foregroundColor(.black)
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
            .padding(.top, 60)
        }
    }
}

struct GongBokEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        GongBokEditScreen()
            .environmentObject(SettingScreenController())
    }
}
