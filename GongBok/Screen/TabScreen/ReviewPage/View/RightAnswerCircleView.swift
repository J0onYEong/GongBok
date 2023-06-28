//
//  RightAnswerCircleVuew.swift
//  GongBok
//
//  Created by 최준영 on 2023/06/25.
//

import SwiftUI

struct RightAnswerCircleView: View {
    @State private var trimAmount = 0.0
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: trimAmount)
            .stroke(lineWidth: 1.5)
            .rotation(.degrees(45))
            .fill(.red)
            .onAppear {
                withAnimation(.easeInOut(duration: 1.0)) {
                    trimAmount = 1.0
                }
            }
            
    }
}

struct RightAnswerCircleVuew_Previews: PreviewProvider {
    static var previews: some View {
        RightAnswerCircleView()
            .frame(height: 200)
    }
}
