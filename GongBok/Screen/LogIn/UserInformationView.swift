//
//  UserInformationView.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI

struct UserInformationView: View {
    @State private var nickName = ""
    @State private var birthYear = Date.now
    @State private var buttonColor: Color = .submit
    @ObservedObject var viewModel: LoginScreenViewModel
        
    var submitValidation: Bool {
        return nickName.count >= 3
    }
    
    var body: some View {
        VStack {
            Text("우리 같이 공복을 채워봐요!")
                .font(Font.system(size: 25, weight: .semibold, design: .default))
                .frame(height: 25)
            VStack(spacing: 50) {
                HStack {
                    Text("닉네임을 입력하세요.")
                        .font(Font.system(size: 17, weight: .medium))
                        .padding(.leading, 20)
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.1))
                        TextField("", text: $nickName)
                            .padding([.horizontal], 12)
                            .padding([.vertical], 5)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                    }
                    .frame(width: 120, height: 35)
                    .padding(.trailing, 20)
                }
                .frame(height: 35)
                HStack {
                    Text("언제 태어났나요?")
                        .font(Font.system(size: 17, weight: .medium))
                        .padding(.leading, 20)
                    Spacer()
                    Picker("", selection: $birthYear) {
                        ForEach(1980...Calendar.current.component(.year, from: Date.now), id: \.self) {
                            Text(String($0))
                        }
                    }
                    .pickerStyle(InlinePickerStyle())
                    .frame(width: 120, height: 100)
                    .padding(.trailing, 20)
                }
                .frame(height: 35)
            }
            .padding([.horizontal], 15)
            .padding(.top, 75)
            
            Button {
                
                //서버로 인풋을 넘겨주고 유효성 검사후 화면 조정
                
                
                buttonColor = .underBar
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundColor(buttonColor)
                        .frame(height: 50)
                        .shadow(color: .gray, radius: 3, x: 0, y: 4)
                    Text("가입 완료")
                        .foregroundColor(.gray)
                }
            }
            .disabled(!submitValidation)
            .padding([.horizontal], 50)
            .padding(.top, 200)
        }
        .navigationBarBackButtonHidden()
    }
}

struct UserInformationView_Previews: PreviewProvider {
    static var previews: some View {
        UserInformationView(viewModel: LoginScreenViewModel())
    }
}
