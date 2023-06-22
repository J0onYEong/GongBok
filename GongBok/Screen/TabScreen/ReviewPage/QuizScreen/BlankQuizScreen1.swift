//
//  BlankQuizScreen1.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/18.
//

import SwiftUI

struct BlankQuizScreen1: View {
    @EnvironmentObject var controller: ReviewScreenController
    @ObservedObject private var viewModel = BlankQuiz1ViewModel()
    
    @FocusState private var focusState
    
    var body: some View {
        ChildScreenBase(controller: controller) {
            VStack {
                Text("빈칸 퀴즈")
                    .font(Font.system(size: 25, weight: .bold))
                HStack {
                    Spacer()
                    Text("파이썬 1차시")
                        .font(Font.system(size: 20, weight: .bold))
                        .frame(height: 20)
                    Spacer()
                }
                .padding(.vertical, 20)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.submit)
                )
                .padding(.horizontal, 10)
                .padding(.top, 10)
                
                ZStack {
                    Text(viewModel.quizString)
                        .font(Font.system(size: 20, weight: .semibold))
                        .zIndex(0)
                    if viewModel.state == .correct {
                        HStack {
                            Circle()
                                .strokeBorder(lineWidth: 1.5)
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40)
                                .padding(.leading, 30)
                            
                            Spacer()
                        }
                        .zIndex(1)
                    }
                    if viewModel.state == .wrong {
                        HStack {
                            DiagonalLine()
                                .stroke(Color.red, lineWidth: 1.0)
                                .frame(width: 50, height: 30)
                                .padding(.leading, 30)
                            Spacer()
                        }
                        .zIndex(1)
                    }
                }
                .frame(height: 30)
                .padding(.top, 40)
                
                GeometryReader { geo in
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .strokeBorder(lineWidth: 1.0)
                                .foregroundColor(.gray)
                                .zIndex(0)
                            
                            TextField("", text: $viewModel.inputStr)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled(true)
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.center)
                                .focused($focusState)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()

                                        Button {
                                            viewModel.focusState = false
                                        } label: {
                                            Text("닫기")
                                                .font(Font.system(size: 20))
                                                .frame(height: 20)
                                                .foregroundColor(.black)
                                                .padding(.vertical, 5)
                                                .padding(.horizontal, 15)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .fill(Color.background)
                                                )
                                        }
                                        .foregroundColor(.black)
                                    }
                                }
                                .zIndex(1)
                        }
                        .frame(height: 250)
                        .padding(.top, 40)
                        .padding(.horizontal, 20)
                        
                        if viewModel.state == .correct {
                            PopupTextView(text: "테스트", duration: 1.0)
                                .position(x: geo.size.width/2, y: geo.size.height*0.75)
                            
                        }
                    }
                    .position(x: geo.size.width/2, y: geo.size.height/2)
                }
                
                Spacer()
                
                if viewModel.state == .correct {
                    Text("정답!")
                        .font(Font.system(size: 20, weight: .bold))
                        .frame(height: 20)
                }
                
                if viewModel.state == .wrong {
                    
                    (
                        Text("오답! 정답은 ")
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        +
                        Text(viewModel.answer)
                            .font(Font.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                    )
                    .frame(height: 20)
                    
                }
                
                Spacer()
                
                if viewModel.state == .wrong {
                    HStack {
                        Button {
                            viewModel.reset()
                        } label: {
                            Text("다시 풀기")
                                .font(Font.system(size: 17, weight: .semibold))
                                .frame(height: 17)
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 16.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.correctAnswer)
                                        .shadow(color: .gray, radius: 2, y: 2)
                                )
                        }
                        Spacer()
                        Button {
                            controller.popTopView()
                        } label: {
                            Text("목록으로")
                                .font(Font.system(size: 17, weight: .semibold))
                                .frame(height: 17)
                                .foregroundColor(.black)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 16.5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.submit)
                                        .shadow(color: .gray, radius: 2, y: 2)
                                )
                        }
                        
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 30)
                } else {
                    Button {
                        if viewModel.state == .input {
                            viewModel.submit()
                        } else {
                            controller.popTopView()
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text(viewModel.state == .input ? "정답 제출" : "목록으로 돌아가기")
                                .font(Font.system(size: 20, weight: .semibold))
                                .frame(height: 20)
                                .padding(.vertical, 20)
                            Spacer()
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(viewModel.hasInput ? .correctAnswer : .submit)
                                .shadow(color: .gray, radius: 2, y: 2)
                        )
                        .padding(.horizontal, 30)
                    }
                    .foregroundColor(viewModel.hasInput ? .white : .black.opacity(0.8))
                    .padding(.bottom, 30)
                    .disabled(!viewModel.hasInput)
                    .animation(.easeInOut(duration: 0.2), value: viewModel.hasInput)
                }
                
            }
            .onAppear {
                focusState = true
                viewModel.getBlankQuiz1Data()
            }
            .sync($viewModel.focusState, with: _focusState)
        }
    }
}

struct BlankQuizScreen1_Previews: PreviewProvider {
    static var previews: some View {
        BlankQuizScreen1()
            .environmentObject(ReviewScreenController())
    }
}

extension View {
    func sync<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
        self
            .onChange(of: binding.wrappedValue) {
                focusState.wrappedValue = $0
            }
            .onChange(of: focusState.wrappedValue) {
                binding.wrappedValue = $0
            }
    }
}
