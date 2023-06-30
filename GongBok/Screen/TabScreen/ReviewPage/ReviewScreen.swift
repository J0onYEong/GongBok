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
            ZStack {
                VStack {
                    Text("복습하기")
                        .font(Font.system(size: 25, weight: .bold))
                        .padding(.top, 50)
                    Spacer()
                    ZStack {
                        if controller.subjectLoadingState == .compelete {
                            ScrollView {
                                ForEach(Array(controller.subjects.enumerated()), id: \.element) { index, item in
                                    Button {
                                        
                                        controller.addToStack(destination: .weekNumber(name: item.name, id: item.id))
                                        
                                    } label: {
                                        ItemLabelView(color: .white, text: "\(item.name)", showArrow: false)
                                            .frame(height: 60)
                                            .padding(.bottom, 20)
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                Button {
                                    controller.isShowingNewSubjectView = true
                                } label: {
                                    ItemLabelView(color: .background, text: "+", showArrow: false)
                                        .frame(height: 60)
                                        .padding(.bottom, 20)
                                        .foregroundColor(.gray)
                                }
                                
                                
                            }
                            .padding([.horizontal], 20)
                            .padding(.top, 50)
                        } else {
                            GeometryReader { geo in
                                LoadingView()
                                    .position(x: geo.size.width/2, y: geo.size.height/2)
                            }
                        }
                    }
                }
                .zIndex(0)
                
                if controller.isShowingNewSubjectView {
                    ZStack {
                        Rectangle()
                            .fill(.gray.opacity(0.7))
                            .ignoresSafeArea()
                            .zIndex(0)
                        NewSubjectView(validation: controller.subjectNameValidation(name:)) { newSubjectName in
                            
                            withAnimation {
                                controller.addSubject(name: newSubjectName)
                                controller.isShowingNewSubjectView = false
                            }
                        } dismiss: {
                            controller.isShowingNewSubjectView = false
                        }
                        .padding(20)
                    }
                    .zIndex(1)
                }
            }
            .navigationDestination(for: ReviewScreenViewState.self) { state in
                switch (state) {
                case .weekNumber(let name, let id):
                    WeekNumberScreen(name: name, id: id)
                        .navigationBarBackButtonHidden()
                case .quiz(let id):
                    QuizScreen(id: id)
                        .navigationBarBackButtonHidden()
                case .quizDetail(let id):
                    switch (id) {
                    case "blank":
                        BlankQuizScreen1()
                            .navigationBarBackButtonHidden()
                    default:
                        Text("")
                    }
                }
            }
        }
        .environmentObject(controller)
        .onAppear {
            controller.getSubjects()
        }
        .animation(.easeIn(duration: 0.3), value: controller.subjects)
    }
}

struct ReviewScreen_Previews: PreviewProvider {
    static var previews: some View {
        ReviewScreen()
    }
}
