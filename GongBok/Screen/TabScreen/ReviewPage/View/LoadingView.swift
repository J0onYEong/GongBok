//
//  LoadingView.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/30.
//

import SwiftUI

struct LoadingView: View {
    
    private enum ViewState {
        case start, s1, s2, s3, down
        
        mutating func next() {
            switch (self) {
            case .start:
                self = .s1
            case .s1:
                self = .s2
            case .s2:
                self = .s3
            case .s3:
                self = .down
            case .down:
                self = .s1
            }
        }
    }
    
    @State private var s1 = false;
    @State private var s2 = false;
    @State private var s3 = false;
    
    @State private var state: ViewState = .start
    
    @State private var timer: Timer?
    
    func stateManage() {
        state.next()
        
        switch (state) {
        case .start:
            return;
        case .s1:
            s1 = true
        case .s2:
            s2 = true
        case .s3:
            s3 = true
        case .down:
            s1 = false
            s2 = false
            s3 = false
        }
    }
    
    
    
    var body: some View {
        HStack(spacing: 0) {
            Group {
                if s1 {
                    Image(systemName: "dot.squareshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                }
                if s2 {
                    Image(systemName: "dot.squareshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing, 10)
                }
                if s3 {
                    Image(systemName: "dot.squareshape")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                Spacer()
            }
            .transition(.asymmetric(insertion: .customSlide(from: CGPoint(x: 0, y: -30), to: CGPoint(x: 0, y: 0), state: .insertion), removal: .customSlide(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 0, y: 30), state: .removal)))
            .animation(.easeIn(duration: 0.2), value: state)
        }
        .frame(width: 120, height: 30)
        .padding(.leading, 10)
        .clipShape(Rectangle())
        .onAppear {
            timer = Timer(timeInterval: 0.3, repeats: true) { _ in
                self.stateManage()
            }
            
            guard let uwp = timer else { return; }
            
            RunLoop.main.add(uwp, forMode: .default)
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

extension HorizontalAlignment {
    static var customAlignment: HorizontalAlignment = .center
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

