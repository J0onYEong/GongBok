//
//  NewSubjectView.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/28.
//

import SwiftUI

struct NewSubjectView: View {
    @ObservedObject private var viewModel = NSViewModel()
    @FocusState private var focusState
    
    private let fontHeight: CGFloat = 20
    private let vPadding: CGFloat = 15
    
    var validation: ((String) -> Bool)?
    
    var submit: ((String) -> ())?
    
    var dismiss: ( ()->() )?
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                TextField("과목이름을 입력하세요!", text: $viewModel.subjectName)
                    .focused($focusState)
                    .font(Font.system(size: fontHeight))
                    .multilineTextAlignment(.center)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .frame(height: fontHeight)
                    .lineLimit(1)
                    .padding(.horizontal, 30)
                    .padding(.vertical, vPadding)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()

                            Button {
                                dismiss?()
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
                    .background(
                        RoundedRectangle(cornerRadius: fontHeight/2 + vPadding)
                            .fill(.white)
                            .shadow(radius: 5, y: 5)
                    )
                    .onSubmit {
                        if validation?(viewModel.subjectName) ?? true {
                            submit?(viewModel.subjectName)
                        }
                        else {
                            viewModel.showErrorMessage(.validation)
                        }
                    }
                Spacer()
            }
            
            VStack {
                Group {
                    if viewModel.isShowingError {
                        Text(viewModel.errorMessage)
                            .font(Font.system(size: 15, weight: .semibold))
                            .foregroundColor(.red)
                            .padding(.bottom, 10)
                            .lineLimit(1)
                    }
                }
                .transition(.scale.animation(.easeInOut))
                Spacer()
            }
            .zIndex(1.0)
        }
        .frame(height: fontHeight+vPadding+70)
        .onAppear {
            focusState = true
        }
        
    }
}

struct NewSubjectView_Previews: PreviewProvider {
    static var previews: some View {
        NewSubjectView { str in
            return false
        } submit: { _ in
            print("Hello world")
        }
    }
}
