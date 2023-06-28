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
                ForEach(Array(controller.quizTypes.enumerated()), id: \.element.key) { index, element in
                    Button {
                        controller.addToStack(destination: .quizDetail(id: element.key))
                    } label: {
                        ItemLabelView(color: .white, text: element.value)
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
