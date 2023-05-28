//
//  ChildScreenBase.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/28.
//

import SwiftUI

struct ChildScreenBase<T, Content: View>: View {
    var controller: NavigationController<T>
    
    var view: (() -> Content) = {
        Text("Hello world") as! Content
    }
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    controller.popTopView()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                }
                .foregroundColor(.black)
                .padding([.leading, .top], 10)
                Spacer()
            }
            view()
            Spacer()
        }
    }
}

struct ChildScreenBase_Previews: PreviewProvider {
    static var previews: some View {
        ChildScreenBase(controller: SettingScreenController()) {
            Text("Hello world")
        }
    }
}
