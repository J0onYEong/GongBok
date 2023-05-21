//
//  ReviewScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/20.
//

import SwiftUI

struct ReviewScreen: View {
    @StateObject var controller = ReviewScreenController()
    
    var body: some View {
        NavigationStack(path: $controller.viewState) {
            VStack {
                Text("복습하기")
                    .font(Font.system(size: 25, weight: .bold))
                    .padding(.top, 50)
                ScrollView {
                    ForEach(controller.getSubject(), id: \.self) { item in
                        Button {
                            //임시
                            controller.addToStack(destination: .weekNumber(name: item))
                        } label: {
                            ItemLabelView(color: .white, text: "\(item)")
                                .frame(height: 60)
                                .padding(.bottom, 20)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.top, 50)
                .padding([.horizontal], 20)
            }
        }
        .navigationDestination(for: ReviewScreenViewState.self) { state in
            switch (state) {
            case .weekNumber(let name):
                Text("")
            case .quiz(let id):
                Text("")
            }
        }
        .environmentObject(controller)
    }
}

struct ReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewScreen()
    }
}
