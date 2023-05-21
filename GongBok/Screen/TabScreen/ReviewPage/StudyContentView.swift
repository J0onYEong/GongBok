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
    
    var alignmentState: AlignmentState {
        viewModel.alignmentState
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    if alignmentState == .vStack {
                        Spacer()
                    }
                    ZStack {
                        Text("학습 내용:")
                            .font(Font.system(size: 20, weight: .bold))
                            .frame(height: 20)
                            .padding(.trailing, 5)
                            .padding(.leading, alignmentState == .hStack ? 10 : 0)
                            .alignmentGuide(VerticalAlignment.center) { d in titleVertical(d) }
                            .alignmentGuide(HorizontalAlignment.center) { d in titleHorizontal(d) }
                        if alignmentState == .hStack {
                            Text(controller.quizData.reviewText)
                                .font(Font.system(size: 20))
                                .frame(width: geo.size.width * 0.5, height: 20)
                                .alignmentGuide(VerticalAlignment.center) { d in contentVertical(d) }
                                .alignmentGuide(HorizontalAlignment.center) { d in contentHorizontal(d) }
                        } else {
                            VStack {
                                TextField("학습하신 내용을 입력하세요", text: $controller.quizData.reviewText, axis: .vertical)
                                    .font(Font.system(size: 20))
                                    .lineLimit(6, reservesSpace: true)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .frame(width: geo.size.width * 0.85)
                                    .focused($focusState)
                                Button {
                                    
                                    //
                                    //
                                    //
                                    controller.submitQuizData(id: id)
                                    
                                } label: {
                                    Text("제출하기")
                                        .font(Font.system(size: 17, weight: .semibold))
                                        .foregroundColor(.black)
                                        .frame(height: 17)
                                        .padding([.horizontal], 30)
                                        .padding([.vertical], 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: (17 + 20)/2)
                                                .fill(.white)
                                                .shadow(color: .gray, radius: 1.5, y: 1.5)
                                        )
                                }
                            }
                            .alignmentGuide(VerticalAlignment.center) { d in contentVertical(d) }
                            .alignmentGuide(HorizontalAlignment.center) { d in contentHorizontal(d) }
                        }
                    }
                    Spacer()
                }
                .padding([.vertical], 30)
                .padding([.horizontal], 10)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .shadow(color: .gray, radius: 3, y: 2)
                            .padding(3)
                    }
                    
                )
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            viewModel.alignmentState = alignmentState == .hStack ? .vStack : .hStack
                            focusState = true
                        } label: {
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(Angle(degrees: alignmentState == .hStack ? 0 : 180))
                                .foregroundColor(.black)
                                .frame(height: 10)
                                .animation(.easeInOut(duration: 0.2), value: alignmentState)
                        }
                    }
                    .padding([.top, .trailing], 30)
                    Spacer()
                }
            }
            .animation(alignmentState == .vStack ? .easeIn(duration: 0.1) : .none, value: alignmentState)
            .position(x: geo.size.width/2, y: geo.size.height/2)
        }
        .frame(height: alignmentState == .hStack ? 60 : 300)
    }
    
    func titleVertical(_ d: ViewDimensions) -> CGFloat {
        switch(alignmentState) {
        case .hStack:
            return d[.leading]
        case.vStack:
            return d[.bottom]
        }
    }
    func titleHorizontal(_ d: ViewDimensions) -> CGFloat {
        switch(alignmentState) {
        case .hStack:
            return d[.trailing]
        case.vStack:
            return d[.leading]
        }
    }
    func contentVertical(_ d: ViewDimensions) -> CGFloat {
        switch(alignmentState) {
        case .hStack:
            return d[.top]
        case.vStack:
            return d[.top]-10
        }
    }
    func contentHorizontal(_ d: ViewDimensions) -> CGFloat {
        switch(alignmentState) {
        case .hStack:
            return d[.leading]
        case.vStack:
            return d[.leading]
        }
    }

}


struct StudyContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StudyContentView(id: "파이썬1")
                .padding([.horizontal], 20)
                .environmentObject(ReviewScreenController())
        }
    }
}
