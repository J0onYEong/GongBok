//
//  StudyContentView.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/21.
//

import SwiftUI

struct StudyContentView: View {
    @StateObject var viewModel = StudyContentViewController()
    @EnvironmentObject var controller: ReviewScreenController
    
    @FocusState private var focusState
    
    var id: String
    
    
    var body: some View {
        VStack {
            HStack {
                Text("학습내용:")
                    .font(Font.system(size: 15, weight: .semibold))
                    .frame(height: 15)
                    .padding(.trailing, 5)
                Text(viewModel.mode == .Idle ? viewModel.inputString : "")
                    .font(Font.system(size: 15, weight: .semibold))
                    .frame(height: 15)
                    .lineLimit(1)
                Spacer()
                Image(systemName: "chevron.down")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 10)
                    .rotationEffect(.degrees(viewModel.mode  == .Idle ? 0 : 180))
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            viewModel.toogleState()
                        }
                        focusState = true
                    }
            }
            
            if viewModel.mode == .Input {
                Rectangle()
                    .fill(.gray)
                    .frame(height: 1.3)
                    .opacity(0.5)
                    .padding(.top, 5)
                    .transition(.openSildeEffect())
            }
            
            VStack {
                if viewModel.mode == .Input {
                    VStack {
                        TextField("학습내용을 입력하세요", text: $viewModel.inputString, axis: .vertical)
                            .font(Font.system(size: 15))
                            .lineLimit(6, reservesSpace: true)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .focused($focusState)
                            .padding(.bottom, 5)
                        Button {
                            
                        } label: {
                            Text("제출하기")
                                .font(Font.system(size: 13, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(height: 13)
                                .padding([.horizontal], 30)
                                .padding([.vertical], 8)
                                .background(
                                    RoundedRectangle(cornerRadius: (17 + 20)/2)
                                        .fill(.white)
                                        .shadow(color: .gray, radius: 1.5, y: 1.5)
                                )
                        }
                        .padding(.bottom, 5)
                    }
                    .transition(.customSlideEffect(pos: CGSize(width: 0, height: -200)))
                }
            }
            .clipShape(Rectangle())
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.white)
                    .shadow(color: .gray, radius: 3, y: 2)
                    .padding(3)
            }

        )

    }
    
}


struct StudyContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StudyContentView(id: "파이썬1")
                .padding([.horizontal], 20)
            Spacer()
        }
        .frame(height: 200)
    }
}
