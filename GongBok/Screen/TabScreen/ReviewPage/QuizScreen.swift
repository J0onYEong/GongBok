//
//  QuizScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import SwiftUI

struct QuizScreen: View {
    var id: String
    @EnvironmentObject var controller: ReviewScreenController
    
    var quizTypes = [
        "객관식 개념 퀴즈",
        "서술형 요약 퀴즈",
        "단답형 개념 퀴즈",
        "빈칸 퀴즈",
        "참/거짓 개념 퀴즈",
        "관련 자료",
        "틀린 문제 정리",
    ]
    
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
            
            ScrollView {
                StudyContentView(id: id)
                    .padding(20)
                ForEach(Array(quizTypes.enumerated()), id: \.element) { index, element in
                    Button {
                        
                    } label: {
                        ItemLabelView(color: .white, text: element)
                            .frame(height: 60)
                            .padding(.bottom, 20)
                            .foregroundColor(.black)
                    }
                    .padding([.horizontal], 20)
                }
            }
            
            Spacer()
        }
    }
}

struct QuizScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuizScreen(id: "파이썬1")
            .environmentObject(ReviewScreenController())
    }
}
