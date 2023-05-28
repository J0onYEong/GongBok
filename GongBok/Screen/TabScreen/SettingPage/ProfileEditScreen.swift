//
//  ProfileEditScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct ProfileEditScreen: View {
    @EnvironmentObject var controller: SettingScreenController
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ChildScreenBase(controller: controller) {
            VStack {
                Text("내 프로필 수정")
                    .font(Font.system(size: 25, weight: .bold))
                    .padding(.bottom, 100)
                
                HStack {
                    Text("닉네임 수정")
                        .font(Font.system(size: 20, weight: .semibold))
                        .frame(width: 100, height: 20)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.1))
                        TextField("", text: $controller.nickName)
                            .padding([.horizontal], 12)
                            .padding([.vertical], 5)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .lineLimit(1)
                    }
                    .frame(width: 100, height: 40)
                    .padding(.trailing, 10)
                }
                
                HStack {
                    Text("연도 수정")
                        .font(Font.system(size: 20, weight: .semibold))
                        .frame(width: 100, height: 20)
                    Spacer()
                    
                    Picker("", selection: $controller.birthYear) {
                        ForEach(1980...Calendar.current.component(.year, from: Date.now), id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    .frame(width: 120, height: 100)
                }
                
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
                .padding(.bottom, 50)
            }
            .padding(.top, 150)
            .padding(.horizontal, 30)
        }
    }
}

struct ProfileEditScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditScreen()
            .environmentObject(SettingScreenController())
    }
}
