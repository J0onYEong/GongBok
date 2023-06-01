//
//  UserInformationView.swift
//  SocialLoginTestApp
//
//  Created by 최준영 on 2023/05/07.
//

import SwiftUI
import Alamofire

struct UserInformationView: View {
    @State private var userInfo = UserInfo(nickName: "", birthYear: 2000)
    @EnvironmentObject var authObj: AuthenticationObject
    @EnvironmentObject var viewModel: LoginScreenViewModel
        
    var submitValidation: Bool {
        return userInfo.nickName.count >= 3
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
                        TextField("", text: $userInfo.nickName)
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
                    Picker("", selection: $userInfo.birthYear) {
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
                guard let accessTk = authObj.localAuthData?.accessToken, let sendData = try? JSONEncoder().encode(userInfo) else {
                    return;
                }
                
                let url = APIUrl.personalDataSave
                var request = URLRequest(url: URL(string: url)!)
                request.httpMethod = HTTPMethod.patch.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("Bearer \(accessTk)", forHTTPHeaderField: "Authorization")
                request.httpBody = sendData
                
//                AF.request(request).responseDecodable(of: PersonalDataReponse.self) { res in
//
//                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .foregroundColor(submitValidation ? .underBar : .submit)
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
        UserInformationView()
            .environmentObject(LoginScreenViewModel())
    }
}
