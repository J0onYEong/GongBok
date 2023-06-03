//
//  HomeScreen.swift
//  GongBok
//
//  Created by 최준영 on 2023/05/14.
//

import SwiftUI




struct HomeScreen: View {
    
    @StateObject var viewModel = HomeScreenController()
    
    @State var modalType: ModalType = .noModal
    
    //animation
    @State private var levelExpForPin = 0
    @State private var levelExpForText = 0
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Image("addPerson")
                            .resizable()
                            .scaledToFit()
                            .padding(7)
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("podium")
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                    }
                    Spacer()
                    Button {
                        withAnimation {
                            modalType = .starLog
                        }
                    } label: {
                        StarView(starCount: viewModel.testData.starSum)
                    }
                }
                .frame(height: 50)
                .padding([.horizontal], 10)
                Spacer()
                
            }
            
            GeometryReader { geo in
                VStack {
                    ZStack {
                        VStack {
                            Spacer()
                            
                            Image("gongboke_idle")
                                .resizable()
                                .frame(width: 150, height: 190)
                                
                            
                            Text("Lv \(viewModel.testData.level).")
                                .font(Font.system(size: 25, weight: .bold))
                        }
                        VStack {
                            HStack {
                                SpeechBubbleView()
                                    .frame(width: geo.size.width/2)
                                Spacer()
                            }
                            .padding(.top, 110)
                            Spacer()
                        }
                    }
                    .frame(height: geo.size.height/2)
                    .padding(.top, 50)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .padding(.trailing, 20)
                                .onTapGesture {
                                    modalType = .starIntro
                                }
                        }
                        levelGradationView
                            .frame(height: 30)
                            .padding([.horizontal], 10)
                        levelTextView
                            .padding([.top], 20)
                    }
                    Spacer()
                }
            }
            
            
            // MARK: - 조건부 모달 표시
            if modalType != .noModal {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .ignoresSafeArea()
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .shadow(color: .gray, radius: 3, y: 5)
                        VStack {
                            HStack {
                                Image("x")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding([.top, .leading], 15)
                                    .onTapGesture {
                                        modalType = .noModal
                                    }
                                Spacer()
                            }
                            switch(modalType) {
                            case .starIntro:
                                starIntro
                            case .starLog:
                                starLog
                            case .noModal:
                                Text("")
                            }
                            Spacer()
                        }
                    }
                    .padding([.horizontal], 30)
                    .padding(.top, 60)
                    .padding(.bottom, 100)
                }
            }
        }
    }
    
    
    
    // MARK: - 레벨 텍스트 뷰
    var levelTextView: some View {
        Text("Lv. \(viewModel.testData.level+1)")
            .foregroundColor(.yellow)+Text(" 까지 ")+Text("\(1000-viewModel.testData.experience)")
            .foregroundColor(.cyan)+Text(" 이 필요합니다.")
    }
    
    
    // MARK: - 레벨 게이지 뷰
    var levelGradationView: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(colors: [.gradient2, .gradient1], startPoint: .leading, endPoint: .trailing)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .gray, radius: 5, y: 5)
                Circle()
                    .fill(.white)
                    .frame(height: 20)
                    .shadow(radius: 3)
                    .position(x: {
                        let gap = geo.size.width-30
                        let per = Double(levelExpForPin) / 1000.0
                        return 15.0+gap*Double(per)
                    }(), y: geo.size.height/2)
                HStack {
                    Spacer()
                    Text("\(levelExpForText)/1000")
                        .font(Font.system(size: 12))
                        .padding([.trailing], 10)
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                levelExpForPin = viewModel.testData.experience
            }
            
            if levelExpForText < 500 {
                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                    levelExpForText += (viewModel.testData.experience / 50);
                    if levelExpForText == viewModel.testData.experience {
                        timer.invalidate()
                    }
                }
            }
        }
    }
}



// MARK: - 모달에 표시될 뷰
extension HomeScreen {
    var starLog: some View {
        VStack {
            Image("star2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.yellow)
                .frame(height: 40)
                .padding(.bottom, 20)
            Text("별 포인트 내역")
                .font(Font.system(size: 20, weight: .bold))
                .padding(.bottom, 30)
            VStack(spacing: 30) {
                StarInfoView(quizName: "객관식 개념 퀴즈", point: "\(viewModel.testData.starLog[0])+")
                StarInfoView(quizName: "서술형 요약 퀴즈", point: "\(viewModel.testData.starLog[1])+")
                StarInfoView(quizName: "단답형 개념 퀴즈", point: "\(viewModel.testData.starLog[2])+")
                StarInfoView(quizName: "빈칸 퀴즈", point: "\(viewModel.testData.starLog[3])+")
            }
            .font(Font.system(size: 17, weight: .semibold))
            .padding([.horizontal], 30)
            .padding(.bottom, 100)
            Spacer()
        }
    }
    
    var starIntro: some View {
        VStack {
            Image(systemName: "questionmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
                .padding(.bottom, 20)
            Text("별 기능 소개")
                .font(Font.system(size: 20, weight: .bold))
                .padding(.bottom, 30)
            VStack(spacing: 30) {
                StarInfoView(quizName: "복습 수행 :", point: "1+")
                StarInfoView(quizName: "커뮤니티 질문/답변 :", point: "1+")
                StarInfoView(quizName: "복습 일정 어길시 :", point: "3-")
                StarInfoView(quizName: "커뮤니티 부적절 발언 :", point: "5-")
            }
            .font(Font.system(size: 17, weight: .semibold))
            .padding([.horizontal], 30)
            .padding(.bottom, 100)
            Spacer()
        }
    }
}



// MARK: - 모달 타입
extension HomeScreen {
    enum ModalType {
        case starLog, starIntro, noModal
    }
}

fileprivate struct StarInfoView: View {
    var quizName: String
    var point: String
    
    var body: some View {
        HStack {
            Text("\(quizName)")
            Spacer()
            Image("star2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
                .foregroundColor(.yellow)
            Text("\(point)")
                .font(Font.system(size: 15, weight: .bold))
                .frame(width: 40)
        }
    }
}


struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
