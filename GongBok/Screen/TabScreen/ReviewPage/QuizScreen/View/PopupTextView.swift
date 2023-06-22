//
//  PopupView.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/22.
//

import SwiftUI

struct PopupTextView: View {
    var text: String
    var duration: CGFloat
    
    @State private var opacity = 1.0
    
    private let height = 50.0
    private let fontSize = 20.0
    
    var body: some View {
        Text(text)
            .font(Font.system(size: fontSize, weight: .bold))
            .foregroundColor(.white)
            .frame(height: fontSize)
            .padding(.vertical, (height-fontSize)/2)
            .padding(.horizontal, 70)
            .background(
                RoundedRectangle(cornerRadius: height/2)
                    .foregroundColor(.gray.opacity(0.6))
            )
            .opacity(opacity)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                    withAnimation(.easeInOut(duration: duration)) {
                        opacity = 0.0
                    }
                }
            }
        
        
    }
}

struct PopupTextView_Previews: PreviewProvider {
    static var previews: some View {
        PopupTextView(text: "정답! 포인트 +300", duration: 1.0)
    }
}
