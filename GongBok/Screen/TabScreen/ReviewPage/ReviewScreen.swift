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
                    ForEach(Array(controller.subject.enumerated()), id: \.element) { index, item in
                        Button {
                            
                            //!!!api요청(임시 로컬 구현)
                            print(item)
                            controller.getWeekNumList(sub: item)
                            
                            //임시
                            controller.addToStack(destination: .weekNumber(name: item))
                            
                            
                            
                        } label: {
                            ItemLabelView(color: .white, text: "\(item)")
                                .frame(height: 60)
                                .padding(.bottom, 20)
                                .foregroundColor(.black)
                        }
                        .padding(.top, index == 0 ? 50 : 0)
                    }
                }
                .padding([.horizontal], 20)
            }
            .navigationDestination(for: ReviewScreenViewState.self) { state in
                switch (state) {
                    case .weekNumber(let name):
                        WeekNumberScreen(subject: name)
                            .navigationBarBackButtonHidden()
                    case .quiz(let id):
                        QuizScreen(id: id)
                            .navigationBarBackButtonHidden()
                }
            }
        }
        .environmentObject(controller)
        .onAppear {
            controller.getSubject()
        }
    }
}

struct ReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewScreen()
    }
}
