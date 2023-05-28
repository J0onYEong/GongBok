//
//  WeekNumberScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import SwiftUI

struct WeekNumberScreen: View {
    @EnvironmentObject var controller: ReviewScreenController
    var subject: String
    
    var weekNumber: [String] {
        return controller.weekNumber + ["AddButton"]
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
            (
                Text(subject)
                    .foregroundColor(.underBar)
                +
                Text(" 주차별 복습하기")
            )
            .font(Font.system(size: 25, weight: .bold))
            .padding(.top, 20)
            ScrollView {
                ForEach(Array(weekNumber.enumerated()), id: \.element) { index, item in
                    if item == "AddButton" {
                        Button {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                controller.addWeekNumElement(sub: subject)
                            }
                        } label: {
                            ItemLabelView(color: .background, text: "+", showImage: false)
                                .frame(height: 60)
                                .padding(.bottom, 20)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, index == 0 ? 50 : 0)
                    } else {
                        Button {
                            //임시
                            let id = subject+item
                            controller.getQuizData(id: id)
                            controller.addToStack(destination: .quiz(id: id))
                        } label: {
                            ItemLabelView(color: .white, text: "\(item)차시")
                                .frame(height: 60)
                                .padding(.bottom, 20)
                                .foregroundColor(.black)
                        }
                        .padding(.top, index == 0 ? 50 : 0)
                    }
                }
            }
            .padding([.horizontal], 20)
        }
        .onAppear {
            print(subject)
            controller.getWeekNumList(sub: subject)
        }
    }
}

struct WeekNumberScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeekNumberScreen(subject: "파이썬")
            .environmentObject(ReviewScreenController())
    }
}
