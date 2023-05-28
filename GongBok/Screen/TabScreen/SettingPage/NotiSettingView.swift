//
//  NotiSettingView.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct NotiSettingView: View {
    @State var trigger = false
    
    var body: some View {
        HStack {
            Text("알림 설정")
                .font(Font.system(size: 15))
                .frame(height: 15)
                .padding(.leading, 30)
            Toggle("", isOn: $trigger)
                .tint(.starColor)
                .padding(.trailing, 20)
        }
        .frame(height: 15)
        .padding([.vertical], 20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.settingColor1)
                    .shadow(color: .gray, radius: 3, y: 2)
                    .padding(3)
            }
            
        )
    }
}

struct NotiSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotiSettingView()
    }
}
